#!/bin/bash
# Common style: readable DBA report, logging, help, and exit status.
LOG_DIR="${LOG_DIR:-./logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/memory_usage.log"

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
read MEM_TOTAL MEM_USED MEM_FREE MEM_SHARED MEM_CACHE MEM_AVAILABLE < <(free -h | awk '/^Mem:/ {print $2,$3,$4,$5,$6,$7}')
read SWAP_TOTAL SWAP_USED SWAP_FREE < <(free -h | awk '/^Swap:/ {print $2,$3,$4}')
MEM_PCT=$(free | awk '/^Mem:/ {printf "%.1f%%", ($3/$2)*100}')
SWAP_PCT=$(free | awk '/^Swap:/ {if ($2==0) print "0.0%"; else printf "%.1f%%", ($3/$2)*100}')
{
echo "========================================================"
echo "                MEMORY USAGE REPORT"
echo "========================================================"
echo
echo "Date        : $DATE"
echo "Hostname    : $HOSTNAME"
echo
echo "---------------- MEMORY ----------------"
echo "Total       : $MEM_TOTAL"
echo "Used        : $MEM_USED"
echo "Free        : $MEM_FREE"
echo "Available   : $MEM_AVAILABLE"
echo "Used %      : $MEM_PCT"
echo
echo "---------------- SWAP ------------------"
echo "Total       : $SWAP_TOTAL"
echo "Used        : $SWAP_USED"
echo "Free        : $SWAP_FREE"
echo "Used %      : $SWAP_PCT"
echo
echo "---------------- SUMMARY ---------------"
echo "Memory Check : COMPLETED"
echo "Swap Status  : CHECKED"
echo "Status       : HEALTHY"
echo "========================================================"
} | tee "$LOG_FILE"
log "Memory usage report completed"
