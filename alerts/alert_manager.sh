#!/bin/bash

LOG_DIR="/chand/linux/linux-dba-utilities/logs"
ALERT_LOG="$LOG_DIR/alerts.log"

mkdir -p "$LOG_DIR"


send_alert()
{
    MESSAGE="$1"
    LEVEL="$2"

    echo "================================================" >> "$ALERT_LOG"
    echo "TIME     : $(date '+%Y-%m-%d %H:%M:%S')" >> "$ALERT_LOG"
    echo "SEVERITY : $LEVEL" >> "$ALERT_LOG"
    echo "MESSAGE  : $MESSAGE" >> "$ALERT_LOG"
    echo "================================================" >> "$ALERT_LOG"

    echo
    echo "ALERT GENERATED"
    echo "Severity : $LEVEL"
    echo "Message  : $MESSAGE"
}


case "$1" in

mysql_down)

send_alert \
"MariaDB service is DOWN" \
"CRITICAL"

;;

high_connections)

send_alert \
"Database connection usage is high" \
"WARNING"

;;

long_query)

send_alert \
"Long running query detected" \
"WARNING"

;;

backup_failed)

send_alert \
"MariaDB backup failed" \
"CRITICAL"

;;

*)

echo "Usage:"
echo "./alert_manager.sh mysql_down"
echo "./alert_manager.sh high_connections"
echo "./alert_manager.sh long_query"
echo "./alert_manager.sh backup_failed"

;;

esac
