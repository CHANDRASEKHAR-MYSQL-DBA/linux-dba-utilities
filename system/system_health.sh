#!/bin/bash
# Common style: readable DBA report, logging, help, and exit status.
LOG_DIR="${LOG_DIR:-./logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/system_health.log"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

usage() {
    echo "Usage: $0 [-h|--help]"
}

log() {
    echo "$(date '+%F %T') - $1" >> "$LOG_FILE"
}

# Script Name : system_health.sh
# Version     : 2.0.0
# Author      : Chandrasekhar Chittimoju

if [[ "$1" == "-h" || "$1" == "--help" ]]; then usage; exit 0; fi

HOSTNAME=$(hostname)
DATE=$(date '+%Y-%m-%d %H:%M:%S')
OS=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2- | tr -d '"')
KERNEL=$(uname -r)
CPU_COUNT=$(nproc)
CPU_MODEL=$(lscpu | awk -F: '/Model name/ {gsub(/^[ \t]+/,"",$2); print $2; exit}')
LOAD=$(awk '{print $1", "$2", "$3}' /proc/loadavg)
UPTIME=$(uptime -p)
MEM_TOTAL=$(free -h | awk '/^Mem:/ {print $2}')
MEM_USED=$(free -h | awk '/^Mem:/ {print $3}')
MEM_AVAILABLE=$(free -h | awk '/^Mem:/ {print $7}')
SWAP_TOTAL=$(free -h | awk '/^Swap:/ {print $2}')
SWAP_USED=$(free -h | awk '/^Swap:/ {print $3}')
ROOT_USE=$(df -h / | awk 'NR==2 {print $5}')
HOME_USE=$(df -h /home 2>/dev/null | awk 'NR==2 {print $5}')
BOOT_USE=$(df -h /boot 2>/dev/null | awk 'NR==2 {print $5}')
IFACE=$(ip -o -4 addr show scope global 2>/dev/null | awk '{print $2; exit}')
IP_ADDR=$(ip -o -4 addr show scope global 2>/dev/null | awk '{print $4; exit}' | cut -d/ -f1)
PING_STATUS="FAILED"
ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1 && PING_STATUS="OK"

DB_STATUS="NOT INSTALLED"
if command -v systemctl >/dev/null 2>&1; then
    if systemctl is-active --quiet mariadb 2>/dev/null; then DB_STATUS="RUNNING"
    elif systemctl is-active --quiet mysqld 2>/dev/null; then DB_STATUS="RUNNING"
    elif systemctl list-unit-files 2>/dev/null | grep -q '^mariadb.service'; then DB_STATUS="STOPPED"
    fi
fi

{
echo "========================================================"
echo "             LINUX SYSTEM HEALTH REPORT"
echo "========================================================"
echo
echo "Date        : $DATE"
echo "Hostname    : $HOSTNAME"
echo "OS          : $OS"
echo "Kernel      : $KERNEL"
echo
echo "---------------- SYSTEM ----------------"
echo "Uptime      : $UPTIME"
echo "CPU         : $CPU_COUNT CPUs"
echo "CPU Model   : $CPU_MODEL"
echo "Load        : $LOAD"
echo
echo "---------------- MEMORY ----------------"
echo "Total       : $MEM_TOTAL"
echo "Used        : $MEM_USED"
echo "Available   : $MEM_AVAILABLE"
echo "Swap        : $SWAP_TOTAL"
echo "Swap Used   : $SWAP_USED"
echo
echo "---------------- DISK ------------------"
echo "Root        : $ROOT_USE used"
echo "Home        : ${HOME_USE:-N/A} used"
echo "Boot        : ${BOOT_USE:-N/A} used"
echo
echo "---------------- NETWORK ---------------"
echo "Interface   : ${IFACE:-N/A}"
echo "IP Address  : ${IP_ADDR:-N/A}"
echo "Internet    : $PING_STATUS"
echo
echo "---------------- DATABASE --------------"
echo "MariaDB     : $DB_STATUS"
echo
echo "---------------- SUMMARY ---------------"
echo "System Health : CHECKED"
echo "Disk Health   : CHECKED"
echo "Memory Health : CHECKED"
echo "Network       : $PING_STATUS"
echo "Database      : $DB_STATUS"
echo "========================================================"
} | tee "$LOG_FILE"
log "System health report completed"
exit 0
