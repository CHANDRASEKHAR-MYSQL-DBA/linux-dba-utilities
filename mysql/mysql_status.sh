#!/bin/bash
###############################################################################
# Script Name : mysql_status.sh
# Title       : Mysql Status
# Version     : 1.0.0
# Author      : Chandrasekhar Chittimoju
# Purpose     : Demonstration DBA utility for GitHub portfolio.
# Usage       : ./mysql_status.sh [-h]
# Exit Codes  : 0=Success, 1=Error
###############################################################################

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/mysql_status.log"

GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; NC="\e[0m"

log(){
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
cat <<EOF
mysql_status.sh
Usage: ./mysql_status.sh
EOF
exit 0
fi

set -o pipefail

log "MySQL status"; mysql -e "STATUS;" || exit 1; systemctl status mariadb --no-pager 2>/dev/null || systemctl status mysql --no-pager

exit 0
