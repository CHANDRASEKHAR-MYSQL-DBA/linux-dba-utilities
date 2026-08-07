#!/bin/bash
###############################################################################
# Script Name : system_health.sh
# Title       : System Health
# Version     : 1.0.0
# Author      : Chandrasekhar Chittimoju
# Purpose     : Demonstration DBA utility for GitHub portfolio.
# Usage       : ./system_health.sh [-h]
# Exit Codes  : 0=Success, 1=Error
###############################################################################

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/system_health.log"

GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; NC="\e[0m"

log(){
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
cat <<EOF
system_health.sh
Usage: ./system_health.sh
EOF
exit 0
fi

set -o pipefail


log "Collecting system health"
echo -e "${GREEN}Hostname:${NC} $(hostname)"
echo -e "${GREEN}OS:${NC}"; grep PRETTY_NAME /etc/os-release 2>/dev/null
echo -e "${GREEN}Kernel:${NC} $(uname -r)"
echo -e "${GREEN}Uptime:${NC}"; uptime
echo -e "${GREEN}CPU:${NC}"; lscpu | head -10
echo -e "${GREEN}Memory:${NC}"; free -h
echo -e "${GREEN}Disk:${NC}"; df -h
echo -e "${GREEN}Load:${NC}"; cat /proc/loadavg
echo -e "${GREEN}Top CPU:${NC}"; ps -eo pid,comm,%cpu --sort=-%cpu | head
echo -e "${GREEN}Top MEM:${NC}"; ps -eo pid,comm,%mem --sort=-%mem | head
echo -e "${GREEN}Network:${NC}"; ip -brief addr
ping -c1 8.8.8.8 >/dev/null 2>&1 && log "Internet OK" || log "Internet unavailable"


exit 0
