#!/bin/bash
# Common style: readable DBA report, logging, help, and exit status.
LOG_DIR="${LOG_DIR:-./logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/slow_query_report.log"

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
SLOW_LOG=$(mysql -Nse "SHOW VARIABLES LIKE 'slow_query_log';" 2>/dev/null | awk '{print $2}')
LONG_TIME=$(mysql -Nse "SHOW VARIABLES LIKE 'long_query_time';" 2>/dev/null | awk '{print $2}')
SLOW_COUNT=$(mysql -Nse "SHOW GLOBAL STATUS LIKE 'Slow_queries';" 2>/dev/null | awk '{print $2}')
{
echo "========================================================"
echo "               SLOW QUERY REPORT"
echo "========================================================"
echo
echo "Date        : $DATE"
echo "Hostname    : $(hostname)"
echo "Database    : MariaDB"
echo "Version     : $(mysql -Nse 'SELECT VERSION();' 2>/dev/null)"
echo
echo "---------------- CONFIGURATION ------------"
echo "Slow Query Log : ${SLOW_LOG:-N/A}"
echo "Long Query Time: ${LONG_TIME:-N/A} seconds"
echo
echo "---------------- STATISTICS ---------------"
echo "Slow Queries   : ${SLOW_COUNT:-N/A}"
echo
echo "---------------- SUMMARY ------------------"
echo "Report Generation : COMPLETED"
echo "Status            : CHECKED"
echo "========================================================"
} | tee "$LOG_FILE"
