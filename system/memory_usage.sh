#!/bin/bash
###############################################################################
# Script Name : memory_usage.sh
# Title       : Memory Usage
# Version     : 1.0.0
# Author      : Chandrasekhar Chittimoju
# Purpose     : Demonstration DBA utility for GitHub portfolio.
# Usage       : ./memory_usage.sh [-h]
# Exit Codes  : 0=Success, 1=Error
###############################################################################

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/memory_usage.log"

GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; NC="\e[0m"

log(){
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
cat <<EOF
memory_usage.sh
Usage: ./memory_usage.sh
EOF
exit 0
fi

set -o pipefail

log "Memory report"; free -h; vmstat 1 3

exit 0
