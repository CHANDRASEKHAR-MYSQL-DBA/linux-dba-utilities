#!/bin/bash
BACKUP_DIR=./backup
mkdir -p "$BACKUP_DIR"
FILE=$BACKUP_DIR/mysql_$(date +%F_%H%M%S).sql
mysqldump --all-databases > "$FILE" && echo "Backup completed: $FILE" || echo "Backup failed"
