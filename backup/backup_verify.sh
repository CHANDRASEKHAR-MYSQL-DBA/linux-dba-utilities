#!/bin/bash

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/backup_verify.log"

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: ./backup_verify.sh <backup_file>"
    exit 0
fi

if [[ -z "$1" ]]; then
    echo "ERROR: Backup file is required."
    echo "Usage: ./backup_verify.sh <backup_file>"
    exit 1
fi

BACKUP_FILE="$1"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

if [[ ! -f "$BACKUP_FILE" ]]; then
    STATUS="FAILED"
    EXISTS="NO"
    SIZE="N/A"
    READABLE="NO"
    SQL_CONTENT="N/A"
else
    EXISTS="YES"
    SIZE=$(du -h "$BACKUP_FILE" | awk '{print $1}')

    if [[ -r "$BACKUP_FILE" ]]; then
        READABLE="YES"
    else
        READABLE="NO"
    fi

    if grep -Eq '^(-- MySQL dump|-- MariaDB dump|CREATE DATABASE|CREATE TABLE|INSERT INTO|SET )' "$BACKUP_FILE"; then
        SQL_CONTENT="VALID"
        STATUS="SUCCESS"
    else
        SQL_CONTENT="NOT DETECTED"
        STATUS="WARNING"
    fi
fi

cat <<EOF | tee "$LOG_FILE"

========================================================
              MARIADB BACKUP VERIFY REPORT
========================================================

Date        : $DATE
Backup File : $BACKUP_FILE

---------------- BACKUP ------------------
Exists      : $EXISTS
File Size   : $SIZE
Readable    : $READABLE

---------------- VALIDATION ---------------
SQL Content : $SQL_CONTENT

---------------- SUMMARY ------------------
Verification: COMPLETED
Status      : $STATUS
========================================================
EOF

[[ "$STATUS" == "SUCCESS" ]] && exit 0
exit 1
