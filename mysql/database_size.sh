#!/bin/bash
###############################################################################
# Script Name : database_size.sh
# Title       : Database Size
# Version     : 1.0.0
# Author      : Chandrasekhar Chittimoju
# Purpose     : Demonstration DBA utility for GitHub portfolio.
# Usage       : ./database_size.sh [-h]
# Exit Codes  : 0=Success, 1=Error
###############################################################################

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/database_size.log"

GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; NC="\e[0m"

log(){
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
cat <<EOF
database_size.sh
Usage: ./database_size.sh
EOF
exit 0
fi

set -o pipefail

mysql -e "SELECT table_schema,ROUND(SUM(data_length+index_length)/1024/1024,2) MB FROM information_schema.tables GROUP BY table_schema ORDER BY MB DESC;"

exit 0
