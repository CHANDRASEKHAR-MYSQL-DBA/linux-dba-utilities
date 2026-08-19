#!/bin/bash
# Common style: readable DBA report, logging, help, and exit status.
LOG_DIR="${LOG_DIR:-./logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/cpu_usage.log"

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
CPU_COUNT=$(nproc)
CPU_MODEL=$(lscpu | awk -F: '/Model name/ {gsub(/^[ \t]+/,"",$2); print $2; exit}')
LOAD=$(awk '{print $1", "$2", "$3}' /proc/loadavg)
CPU_LINE=$(top -bn1 | awk -F'[, ]+' '/Cpu\(s\)/ {print $2" user, "$4" system, "$8" idle"; exit}')
TOP=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -6)
{
echo "========================================================"
echo "                 CPU USAGE REPORT"
echo "========================================================"
echo
echo "Date        : $DATE"
echo "Hostname    : $HOSTNAME"
echo "CPU Count   : $CPU_COUNT"
echo "CPU Model   : $CPU_MODEL"
echo
echo "---------------- LOAD AVERAGE ------------"
echo "1 Minute    : $(awk '{print $1}' /proc/loadavg)"
echo "5 Minutes   : $(awk '{print $2}' /proc/loadavg)"
echo "15 Minutes  : $(awk '{print $3}' /proc/loadavg)"
echo
echo "---------------- CPU USAGE ---------------"
echo "Overall     : $CPU_LINE"
echo
echo "---------------- TOP PROCESSES -----------"
printf '%s\n' "$TOP"
echo
echo "---------------- SUMMARY -----------------"
echo "CPU Check   : COMPLETED"
echo "Status      : CHECKED"
echo "========================================================"
} | tee "$LOG_FILE"
log "CPU usage report completed"
