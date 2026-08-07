#!/bin/bash
###############################################################################
# Script Name : user_audit.sh
# Title       : User Audit
# Version     : 1.0.0
# Author      : Chandrasekhar Chittimoju
# Purpose     : Demonstration DBA utility for GitHub portfolio.
# Usage       : ./user_audit.sh [-h]
# Exit Codes  : 0=Success, 1=Error
###############################################################################

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/user_audit.log"

GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; NC="\e[0m"

log(){
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
cat <<EOF
user_audit.sh
Usage: ./user_audit.sh
EOF
exit 0
fi

set -o pipefail

mysql -e "SELECT User,Host FROM mysql.user ORDER BY User;"; mysql -e "SHOW GRANTS FOR CURRENT_USER();"

exit 0
