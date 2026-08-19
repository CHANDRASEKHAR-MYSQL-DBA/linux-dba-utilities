#!/bin/bash
# Common style: readable DBA report, logging, help, and exit status.
LOG_DIR="${LOG_DIR:-./logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/database_size.log"

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
HOSTNAME=$(hostname)
REPORT=$(mysql -Nse "SELECT table_schema, ROUND(SUM(data_length+index_length)/1024/1024,2) FROM information_schema.tables GROUP BY table_schema ORDER BY SUM(data_length+index_length) DESC;" 2>/dev/null) || { echo "ERROR: MariaDB connection failed"; exit 1; }
{
echo "========================================================"
echo "              DATABASE SIZE REPORT"
echo "========================================================"
echo
echo "Date        : $DATE"
echo "Hostname    : $HOSTNAME"
echo "Database    : MariaDB"
echo
echo "---------------- DATABASES ---------------"
printf "%-25s %12s\n" "Database" "Size (MB)"
while read -r db size; do printf "%-25s %12s\n" "$db" "$size"; done <<< "$REPORT"
echo
echo "---------------- SUMMARY -----------------"
echo "Database Check : COMPLETED"
echo "Status         : CHECKED"
echo "========================================================"
} | tee "$LOG_FILE"
