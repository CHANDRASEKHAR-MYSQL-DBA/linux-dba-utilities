#!/bin/bash
###############################################################################
# Script Name : cpu_usage.sh
# Title       : Cpu Usage
# Version     : 1.0.0
# Author      : Chandrasekhar Chittimoju
# Purpose     : Demonstration DBA utility for GitHub portfolio.
# Usage       : ./cpu_usage.sh [-h]
# Exit Codes  : 0=Success, 1=Error
###############################################################################

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/cpu_usage.log"

GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; NC="\e[0m"

log(){
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
cat <<EOF
cpu_usage.sh
Usage: ./cpu_usage.sh
EOF
exit 0
fi

set -o pipefail

log "CPU report"; top -bn1 | head -15; mpstat 1 1 2>/dev/null || true

exit 0
