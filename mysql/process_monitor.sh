#!/bin/bash
LOG_DIR="/chand/linux/linux-dba-utilities/logs"
LOG_FILE="$LOG_DIR/process_monitor.log"

mkdir -p "$LOG_DIR"

exec > >(tee -a "$LOG_FILE") 2>&1

echo "========================================================"
echo "             MARIADB PROCESS MONITOR"
echo "========================================================"

echo
echo "Date        : $(date '+%Y-%m-%d %H:%M:%S')"
echo "Hostname    : $(hostname)"
echo "Database    : MariaDB"

echo
echo "---------------- SERVICE ----------------"
if systemctl is-active --quiet mariadb; then
    echo "MariaDB     : RUNNING"
else
    echo "MariaDB     : NOT RUNNING"
fi

TOTAL_CONNECTIONS=$(mysql -N -B -e "SHOW STATUS LIKE 'Threads_connected';" 2>/dev/null | awk '{print $2}')
ACTIVE_CONNECTIONS=$(mysql -N -B -e "SHOW STATUS LIKE 'Threads_running';" 2>/dev/null | awk '{print $2}')
MAX_CONNECTIONS=$(mysql -N -B -e "SHOW VARIABLES LIKE 'max_connections';" 2>/dev/null | awk '{print $2}')

if [ -z "$TOTAL_CONNECTIONS" ]; then
    TOTAL_CONNECTIONS=0
fi

if [ -z "$ACTIVE_CONNECTIONS" ]; then
    ACTIVE_CONNECTIONS=0
fi

if [ -z "$MAX_CONNECTIONS" ]; then
    MAX_CONNECTIONS=0
fi

if [ "$MAX_CONNECTIONS" -gt 0 ]; then
    CONNECTION_USAGE=$(awk "BEGIN {printf \"%.2f\", ($TOTAL_CONNECTIONS/$MAX_CONNECTIONS)*100}")
else
    CONNECTION_USAGE="0.00"
fi

echo
echo "---------------- CONNECTIONS ----------------"
echo "Total Connections  : $TOTAL_CONNECTIONS"
echo "Active Connections : $ACTIVE_CONNECTIONS"
echo "Max Connections    : $MAX_CONNECTIONS"
echo "Usage              : ${CONNECTION_USAGE}%"

echo
echo "---------------- SESSIONS ----------------"
SLEEPING_CONNECTIONS=$(mysql -N -B -e \
"SELECT COUNT(*) FROM information_schema.PROCESSLIST WHERE COMMAND='Sleep';" \
2>/dev/null)

echo "Sleeping Connections : ${SLEEPING_CONNECTIONS:-0}"

echo
echo "---------------- LONG RUNNING ----------------"
mysql -e "
SELECT
    ID,
    USER,
    HOST,
    DB,
    COMMAND,
    TIME,
    STATE
FROM information_schema.PROCESSLIST
WHERE COMMAND <> 'Sleep'
  AND TIME >= 60
ORDER BY TIME DESC;
" 2>/dev/null

echo
echo "---------------- TOP PROCESSES ----------------"
mysql -e "
SELECT
    ID,
    USER,
    HOST,
    DB,
    COMMAND,
    TIME,
    STATE
FROM information_schema.PROCESSLIST
ORDER BY TIME DESC
LIMIT 10;
" 2>/dev/null

echo
echo "---------------- SUMMARY ----------------"

if awk "BEGIN {exit !($CONNECTION_USAGE >= 85)}"; then
    CONNECTION_STATUS="CRITICAL"
elif awk "BEGIN {exit !($CONNECTION_USAGE >= 70)}"; then
    CONNECTION_STATUS="WARNING"
else
    CONNECTION_STATUS="HEALTHY"
fi

if [ "$CONNECTION_STATUS" = "CRITICAL" ]; then
    CONNECTION_MESSAGE="Connection limit is critically high"
elif [ "$CONNECTION_STATUS" = "WARNING" ]; then
    CONNECTION_MESSAGE="Connection usage requires attention"
else
    CONNECTION_MESSAGE="Connection usage is within normal range"
fi

LONG_RUNNING_QUERIES=$(mysql -N -B -e "
SELECT COUNT(*)
FROM information_schema.PROCESSLIST
WHERE COMMAND <> 'Sleep'
  AND TIME >= 60;
" 2>/dev/null)

echo "Process Monitor     : COMPLETED"
echo "Total Connections   : $TOTAL_CONNECTIONS"
echo "Active Connections  : $ACTIVE_CONNECTIONS"
echo "Sleeping Connections: ${SLEEPING_CONNECTIONS:-0}"
echo "Long Running Queries: ${LONG_RUNNING_QUERIES:-0}"
echo "Connection Usage    : ${CONNECTION_USAGE}%"
echo "Connection Status   : $CONNECTION_STATUS"
echo "Status              : SUCCESS"
echo "Connection Message  : $CONNECTION_MESSAGE"
echo "========================================================"
