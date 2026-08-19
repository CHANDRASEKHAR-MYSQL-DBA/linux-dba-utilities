#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/backup_files"
VERIFY_SCRIPT="$SCRIPT_DIR/backup_verify.sh"

LATEST_BACKUP=$(find "$BACKUP_DIR" -maxdepth 1 -type f -name "*.sql" -printf "%T@ %p\n" |
    sort -nr |
    head -1 |
    cut -d' ' -f2-)

if [[ -z "$LATEST_BACKUP" ]]; then
    echo "ERROR: No backup file found."
    exit 1
fi

echo "Latest backup:"
echo "$LATEST_BACKUP"
echo

"$VERIFY_SCRIPT" "$LATEST_BACKUP"
