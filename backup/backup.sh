#!/bin/bash
LOG_DIR="/chand/linux/linux-dba-utilities/logs"
LOG_FILE="$LOG_DIR/backup.log"

mkdir -p "$LOG_DIR"

exec > >(tee -a "$LOG_FILE") 2>&1
# Common style: readable DBA report, logging, help, and exit status.
LOG_DIR="${LOG_DIR:-./logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/backup.log"

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
BACKUP_DIR="/chand/linux/linux-dba-utilities/backup/backup_files"
#BACKUP_DIR="${BACKUP_DIR:-./backup}"
mkdir -p "$BACKUP_DIR"
DATE=$(date '+%Y-%m-%d %H:%M:%S')
FILE="$BACKUP_DIR/mariadb_$(date '+%Y-%m-%d_%H%M%S').sql"
if ! command -v mysqldump >/dev/null 2>&1; then echo "ERROR: mysqldump not found"; exit 1; fi
START=$(date +%s)
if mysqldump --all-databases > "$FILE"; then

    END=$(date +%s)
    DURATION=$((END-START))
    SIZE=$(du -h "$FILE" | awk '{print $1}')

    RESULT="SUCCESS"
    EXIT_CODE=0

else

    RESULT="FAILED"
    EXIT_CODE=1

    /chand/linux/linux-dba-utilities/alerts/alert_manager.sh backup_failed

fi
{
echo "========================================================"
echo "                MARIADB BACKUP REPORT"
echo "========================================================"
echo
echo "Date        : $DATE"
echo "Hostname    : $(hostname)"
echo "Database    : MariaDB"
echo
echo "---------------- BACKUP ------------------"
echo "Backup Type : Logical Full Backup"
echo "Tool        : mysqldump"
echo "Destination : $BACKUP_DIR"
echo "File        : $FILE"
echo "File Size   : ${SIZE:-N/A}"
echo "Duration    : ${DURATION:-N/A} seconds"
echo
echo "---------------- SUMMARY -----------------"
echo "Backup      : $RESULT"
echo "Exit Code   : $EXIT_CODE"
echo "Status      : $RESULT"
echo "========================================================"
} | tee "$LOG_FILE"
exit "$EXIT_CODE"
