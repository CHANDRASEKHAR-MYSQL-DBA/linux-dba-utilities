#!/bin/bash
# Common style: readable DBA report, logging, help, and exit status.
LOG_DIR="${LOG_DIR:-./logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/mysql_status.log"

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
if ! command -v mysql >/dev/null 2>&1; then echo "ERROR: mysql client not found"; exit 1; fi
VERSION=$(mysql -Nse "SELECT VERSION();" 2>/dev/null) || { echo "ERROR: MariaDB connection failed"; exit 1; }
UPTIME=$(mysql -Nse "SHOW GLOBAL STATUS LIKE 'Uptime';" 2>/dev/null | awk '{print $2}')
THREADS=$(mysql -Nse "SHOW GLOBAL STATUS LIKE 'Threads_connected';" 2>/dev/null | awk '{print $2}')
QUESTIONS=$(mysql -Nse "SHOW GLOBAL STATUS LIKE 'Questions';" 2>/dev/null | awk '{print $2}')
SLOW=$(mysql -Nse "SHOW GLOBAL STATUS LIKE 'Slow_queries';" 2>/dev/null | awk '{print $2}')
SERVICE="UNKNOWN"
systemctl is-active --quiet mariadb 2>/dev/null && SERVICE="ACTIVE / RUNNING"
{
echo "========================================================"
echo "              MARIADB SERVER STATUS REPORT"
echo "========================================================"
echo
echo "Date        : $DATE"
echo "Hostname    : $HOSTNAME"
echo "Database    : MariaDB"
echo "Version     : $VERSION"
echo
echo "---------------- SERVICE -----------------"
echo "Service     : mariadb"
echo "Status      : $SERVICE"
echo
echo "---------------- SERVER ------------------"
echo "Uptime      : ${UPTIME:-N/A} seconds"
echo "Connections : ${THREADS:-N/A}"
echo "Questions   : ${QUESTIONS:-N/A}"
echo "Slow Queries: ${SLOW:-N/A}"
echo
echo "---------------- SUMMARY -----------------"
echo "Database    : MariaDB"
echo "Health Check: COMPLETED"
echo "Status      : RUNNING"
echo "========================================================"
} | tee "$LOG_FILE"
