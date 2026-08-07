#!/bin/bash
###############################################################################
# Script Name : disk_usage.sh
# Title       : Disk Usage
# Version     : 1.0.0
# Author      : Chandrasekhar Chittimoju
# Purpose     : Demonstration DBA utility for GitHub portfolio.
# Usage       : ./disk_usage.sh [-h]
# Exit Codes  : 0=Success, 1=Error
###############################################################################

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/disk_usage.log"

GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; NC="\e[0m"

log(){
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
cat <<EOF
disk_usage.sh
Usage: ./disk_usage.sh
EOF
exit 0
fi

set -o pipefail

log "Disk report"; df -h; du -sh /* 2>/dev/null|sort -h|tail

exit 0
