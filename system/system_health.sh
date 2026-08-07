#!/bin/bash
# System Health Report
LOG=system_health.log
{
echo "===== System Health ====="
date
echo "Hostname: $(hostname)"
echo "Uptime:"; uptime
echo "CPU:"; top -bn1 | head -5
echo "Memory:"; free -h
echo "Disk:"; df -h
echo "Load:"; cat /proc/loadavg
} | tee -a "$LOG"
