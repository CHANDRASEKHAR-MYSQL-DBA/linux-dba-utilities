#!/bin/bash
###############################################################################
# Script Name : replication_status.sh
# Title       : Replication Status
# Version     : 1.0.0
# Author      : Chandrasekhar Chittimoju
# Purpose     : Demonstration DBA utility for GitHub portfolio.
# Usage       : ./replication_status.sh [-h]
# Exit Codes  : 0=Success, 1=Error
###############################################################################

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/replication_status.log"

GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; NC="\e[0m"

log(){
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
cat <<EOF
replication_status.sh
Usage: ./replication_status.sh
EOF
exit 0
fi

set -o pipefail

mysql -e "SHOW REPLICA STATUS\G" 2>/dev/null || mysql -e "SHOW SLAVE STATUS\G"

exit 0
