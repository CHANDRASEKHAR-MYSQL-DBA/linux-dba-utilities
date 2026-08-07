#!/bin/bash
###############################################################################
# Script Name : slow_query_report.sh
# Title       : Slow Query Report
# Version     : 1.0.0
# Author      : Chandrasekhar Chittimoju
# Purpose     : Demonstration DBA utility for GitHub portfolio.
# Usage       : ./slow_query_report.sh [-h]
# Exit Codes  : 0=Success, 1=Error
###############################################################################

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/slow_query_report.log"

GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; NC="\e[0m"

log(){
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
cat <<EOF
slow_query_report.sh
Usage: ./slow_query_report.sh
EOF
exit 0
fi

set -o pipefail

mysql -e "SHOW VARIABLES LIKE \"slow_query_log\";"; mysql -e "SHOW GLOBAL STATUS LIKE \"Slow_queries\";"

exit 0
