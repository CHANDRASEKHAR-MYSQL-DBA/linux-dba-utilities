#!/bin/bash

LOG_DIR="/chand/linux/linux-dba-utilities/logs"

RETENTION_DAYS=7

mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/log_manager.log"


log_message()
{
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $1" >> "$LOG_FILE"
}


show_logs()
{
    echo "========================================================"
    echo "              DBA LOG MANAGEMENT REPORT"
    echo "========================================================"

    echo
    echo "Log Directory : $LOG_DIR"
    echo "Retention     : $RETENTION_DAYS days"

    echo
    echo "---------------- LOG FILES ----------------"

    if [ -d "$LOG_DIR" ]; then
        ls -lh "$LOG_DIR"
    else
        echo "No log directory found"
    fi


    echo
    echo "---------------- SUMMARY ----------------"

    TOTAL_LOGS=$(find "$LOG_DIR" -type f -name "*.log" | wc -l)

    echo "Total Log Files : $TOTAL_LOGS"

    echo
    echo "Status : COMPLETED"

    echo "========================================================"
}


cleanup_logs()
{
    log_message "Starting log cleanup"

    DELETED=$(find "$LOG_DIR" \
    -type f \
    -name "*.log" \
    -mtime +$RETENTION_DAYS \
    -print -delete | wc -l)


    echo "========================================================"
    echo "              LOG CLEANUP REPORT"
    echo "========================================================"

    echo
    echo "Retention Days : $RETENTION_DAYS"
    echo "Deleted Logs   : $DELETED"

    echo
    echo "Cleanup Status : SUCCESS"

    echo "========================================================"


    log_message "Cleanup completed. Deleted files: $DELETED"
}


case "$1" in

list)
    show_logs
    ;;

cleanup)
    cleanup_logs
    ;;

*)
    echo "Usage:"
    echo "./log_manager.sh list"
    echo "./log_manager.sh cleanup"
    ;;

esac
