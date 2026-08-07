#!/bin/bash
###############################################################################
# Script Name : backup.sh
# Title       : Backup
# Version     : 1.0.0
# Author      : Chandrasekhar Chittimoju
# Purpose     : Demonstration DBA utility for GitHub portfolio.
# Usage       : ./backup.sh [-h]
# Exit Codes  : 0=Success, 1=Error
###############################################################################

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/backup.log"

GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; NC="\e[0m"

log(){
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
cat <<EOF
backup.sh
Usage: ./backup.sh
EOF
exit 0
fi

set -o pipefail

DEST=./backup; mkdir -p "$DEST"; FILE="$DEST/all_$(date +%F_%H%M).sql"; mysqldump --all-databases > "$FILE" && log "Backup saved to $FILE"

exit 0
