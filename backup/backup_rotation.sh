#!/bin/bash

BACKUP_DIR="${1:-./backup}"
RETENTION_DAYS="${2:-7}"

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/backup_rotation.log"

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: ./backup_rotation.sh [backup_directory] [retention_days]"
    echo "Default directory: ./backup"
    echo "Default retention: 7 days"
    exit 0
fi

if [[ ! -d "$BACKUP_DIR" ]]; then
    echo "ERROR: Backup directory does not exist: $BACKUP_DIR"
    exit 1
fi

if ! [[ "$RETENTION_DAYS" =~ ^[0-9]+$ ]]; then
    echo "ERROR: Retention days must be a number."
    exit 1
fi

DATE=$(date '+%Y-%m-%d %H:%M:%S')

OLD_BACKUPS=$(find "$BACKUP_DIR" \
    -type f \
    \( -name "*.sql" -o -name "*.sql.gz" -o -name "*.dump" \) \
    -mtime +"$RETENTION_DAYS" \
    -print)

FOUND=0
DELETED=0

if [[ -n "$OLD_BACKUPS" ]]; then
    FOUND=$(printf '%s\n' "$OLD_BACKUPS" | wc -l)

    while IFS= read -r FILE; do
        [[ -z "$FILE" ]] && continue

        if rm -f "$FILE"; then
            DELETED=$((DELETED + 1))
        fi
    done <<< "$OLD_BACKUPS"
fi

REMAINING=$(find "$BACKUP_DIR" \
    -type f \
    \( -name "*.sql" -o -name "*.sql.gz" -o -name "*.dump" \) \
    | wc -l)

cat <<EOF | tee "$LOG_FILE"

========================================================
             MARIADB BACKUP ROTATION REPORT
========================================================

Date            : $DATE
Backup Directory: $BACKUP_DIR
Retention Days  : $RETENTION_DAYS

---------------- ROTATION -----------------
Old Backups     : $FOUND
Deleted         : $DELETED
Remaining       : $REMAINING

---------------- SUMMARY ------------------
Rotation        : COMPLETED
Status          : SUCCESS
========================================================
EOF
