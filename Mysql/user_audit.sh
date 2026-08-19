#!/bin/bash
# Common style: readable DBA report, logging, help, and exit status.
LOG_DIR="${LOG_DIR:-./logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/user_audit.log"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

usage() {
    echo "Usage: $0 [-h|--help]"
}

log() {
    echo "$(date '+%F %T') - $1" >> "$LOG_FILE"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then usage; exit 0; fi
DATE=$(date '+%Y-%m-%d %H:%M:%S')
USERS=$(mysql -Nse "SELECT User,Host FROM mysql.user ORDER BY User,Host;" 2>/dev/null) || { echo "ERROR: MariaDB connection failed"; exit 1; }
ANON=$(mysql -Nse "SELECT COUNT(*) FROM mysql.user WHERE User='';" 2>/dev/null)
{
echo "========================================================"
echo "                 MARIADB USER AUDIT"
echo "========================================================"
echo
echo "Date        : $DATE"
echo "Hostname    : $(hostname)"
echo "Database    : MariaDB"
echo "Version     : $(mysql -Nse 'SELECT VERSION();' 2>/dev/null)"
echo
echo "---------------- DATABASE USERS -----------"
printf "%-25s %-25s\n" "User" "Host"
while read -r user host; do printf "%-25s %-25s\n" "$user" "$host"; done <<< "$USERS"
echo
echo "---------------- SECURITY CHECK -----------"
echo "Anonymous Users : ${ANON:-0}"
echo
echo "---------------- SUMMARY ------------------"
echo "User Audit      : COMPLETED"
echo "Privilege Review: REQUIRED"
echo "Status          : CHECKED"
echo "========================================================"
} | tee "$LOG_FILE"
