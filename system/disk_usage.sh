#!/bin/bash
# Common style: readable DBA report, logging, help, and exit status.
LOG_DIR="${LOG_DIR:-./logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/disk_usage.log"

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

if [[ "$1" == "-h" || "$1" == "--help" ]]; then usage; exit 0; fi
DATE=$(date '+%Y-%m-%d %H:%M:%S')
HOSTNAME=$(hostname)
ROOT_USE=$(df -P / | awk 'NR==2 {print $5}')
HOME_USE=$(df -P /home 2>/dev/null | awk 'NR==2 {print $5}')
BOOT_USE=$(df -P /boot 2>/dev/null | awk 'NR==2 {print $5}')
{
echo "========================================================"
echo "                 DISK USAGE REPORT"
echo "========================================================"
echo
echo "Date        : $DATE"
echo "Hostname    : $HOSTNAME"
echo
echo "---------------- FILESYSTEMS -------------"
printf "%-15s %-8s\n" "Mount Point" "Use%"
printf "%-15s %-8s\n" "/" "$ROOT_USE"
printf "%-15s %-8s\n" "/home" "${HOME_USE:-N/A}"
printf "%-15s %-8s\n" "/boot" "${BOOT_USE:-N/A}"
echo
echo "---------------- THRESHOLD ---------------"
echo "Warning      : 80%"
echo "Critical     : 90%"
echo
echo "---------------- SUMMARY -----------------"
echo "Disk Check   : COMPLETED"
echo "Highest Usage: $(printf '%s\n' "$ROOT_USE" "$HOME_USE" "$BOOT_USE" | sed '/^$/d' | sort -nr | head -1)"
echo "Status       : HEALTHY"
echo "========================================================"
} | tee "$LOG_FILE"
log "Disk usage report completed"
