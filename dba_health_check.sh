#!/bin/bash
LOG_DIR="/chand/linux/linux-dba-utilities/logs"
LOG_FILE="$LOG_DIR/dba_health_check.log"

mkdir -p "$LOG_DIR"

exec > >(tee -a "$LOG_FILE") 2>&1

echo "========================================================"
echo "              MYSQL DBA HEALTH CHECK REPORT"
echo "========================================================"

echo
echo "Date        : $(date '+%Y-%m-%d %H:%M:%S')"
echo "Hostname    : $(hostname)"
echo "OS          : $(cat /etc/redhat-release 2>/dev/null)"

echo
echo "---------------- SYSTEM ----------------"

if systemctl is-active --quiet mariadb; then
    echo "MariaDB Service     : RUNNING"
    DB_STATUS="PASS"
else
    echo "MariaDB Service     : DOWN"
    DB_STATUS="FAIL"
fi


echo
echo "---------------- CONNECTIONS ----------------"

TOTAL_CONNECTIONS=$(mysql -N -B -e \
"SHOW STATUS LIKE 'Threads_connected';" 2>/dev/null | awk '{print $2}')

MAX_CONNECTIONS=$(mysql -N -B -e \
"SHOW VARIABLES LIKE 'max_connections';" 2>/dev/null | awk '{print $2}')


if [ -z "$TOTAL_CONNECTIONS" ]; then
    TOTAL_CONNECTIONS=0
fi

if [ -z "$MAX_CONNECTIONS" ]; then
    MAX_CONNECTIONS=0
fi


echo "Current Connections : $TOTAL_CONNECTIONS"
echo "Max Connections     : $MAX_CONNECTIONS"


if [ "$MAX_CONNECTIONS" -gt 0 ]; then
    USAGE=$(awk "BEGIN {printf \"%.2f\",($TOTAL_CONNECTIONS/$MAX_CONNECTIONS)*100}")
else
    USAGE="0.00"
fi

echo "Usage               : ${USAGE}%"



echo
echo "---------------- DATABASE ----------------"

DATABASE_COUNT=$(mysql -N -B -e \
"SELECT COUNT(*) FROM information_schema.SCHEMATA;" 2>/dev/null)

echo "Database Count      : ${DATABASE_COUNT:-0}"



echo
echo "---------------- LONG QUERIES ----------------"

LONG_QUERY=$(mysql -N -B -e "
SELECT COUNT(*)
FROM information_schema.PROCESSLIST
WHERE COMMAND <> 'Sleep'
AND TIME >= 60;
" 2>/dev/null)

echo "Long Running Query  : ${LONG_QUERY:-0}"



echo
echo "---------------- BACKUP ----------------"

BACKUP_DIR="/chand/linux/linux-dba-utilities/backup/backup_files"

if [ -d "$BACKUP_DIR" ]; then

    LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/*.sql 2>/dev/null | head -1)

    if [ -n "$LATEST_BACKUP" ]; then
        echo "Latest Backup       : $(basename $LATEST_BACKUP)"
        echo "Backup Status       : AVAILABLE"
    else
        echo "Backup Status       : NOT FOUND"
    fi

else
    echo "Backup Directory    : NOT FOUND"
fi



echo
echo "---------------- SUMMARY ----------------"

if [ "$DB_STATUS" = "PASS" ]; then
    echo "Database Health     : HEALTHY"
else
    echo "Database Health     : CRITICAL"
fi

echo "Overall Status      : COMPLETED"

echo "========================================================"
