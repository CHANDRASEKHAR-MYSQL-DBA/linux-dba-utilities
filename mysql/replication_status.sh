#!/bin/bash
# Common style: readable DBA report, logging, help, and exit status.
LOG_DIR="${LOG_DIR:-./logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/replication_status.log"

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
RAW=$(mysql -e "SHOW REPLICA STATUS\G" 2>/dev/null)
if [[ -z "$RAW" ]]; then RAW=$(mysql -e "SHOW SLAVE STATUS\G" 2>/dev/null); fi
IO=$(awk -F': ' '/Replica_IO_Running:|Slave_IO_Running:/ {print $2; exit}' <<< "$RAW")
SQL=$(awk -F': ' '/Replica_SQL_Running:|Slave_SQL_Running:/ {print $2; exit}' <<< "$RAW")
LAG=$(awk -F': ' '/Seconds_Behind_Source:|Seconds_Behind_Master:/ {print $2; exit}' <<< "$RAW")
MASTER=$(awk -F': ' '/Source_Host:|Master_Host:/ {print $2; exit}' <<< "$RAW")
if [[ -z "$RAW" ]]; then STATUS="NOT CONFIGURED"; else
    if [[ "$IO" == "Yes" && "$SQL" == "Yes" ]]; then STATUS="HEALTHY"; else STATUS="WARNING"; fi
fi
{
echo "========================================================"
echo "             MARIADB REPLICATION REPORT"
echo "========================================================"
echo
echo "Date        : $DATE"
echo "Hostname    : $(hostname)"
echo "Database    : MariaDB"
echo "Version     : $(mysql -Nse 'SELECT VERSION();' 2>/dev/null)"
echo
echo "---------------- REPLICATION -------------"
echo "IO Thread   : ${IO:-N/A}"
echo "SQL Thread  : ${SQL:-N/A}"
echo "Seconds Behind: ${LAG:-N/A}"
echo "Master Host : ${MASTER:-N/A}"
echo
echo "---------------- HEALTH CHECK ------------"
echo "Replication Status : $STATUS"
echo
echo "---------------- SUMMARY -----------------"
echo "Replication Check  : COMPLETED"
echo "Status             : $STATUS"
echo "========================================================"
} | tee "$LOG_FILE"
