#!/bin/bash

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/restore_test.log"

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: ./restore_test.sh <backup_file>"
    exit 0
fi

if [[ -z "$1" ]]; then
    echo "ERROR: Backup file is required."
    echo "Usage: ./restore_test.sh <backup_file>"
    exit 1
fi

BACKUP_FILE="$1"
SOURCE_DB="dba_restore_source"
TEST_DB="dba_restore_test_$(date '+%Y%m%d_%H%M%S')"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

if [[ ! -f "$BACKUP_FILE" ]]; then
    echo "ERROR: Backup file does not exist: $BACKUP_FILE"
    exit 1
fi

if [[ ! -s "$BACKUP_FILE" ]]; then
    echo "ERROR: Backup file is empty."
    exit 1
fi

if ! command -v mysql >/dev/null 2>&1; then
    echo "ERROR: mysql client not found."
    exit 1
fi

CREATE_STATUS="FAILED"
RESTORE_STATUS="FAILED"
VALIDATION_STATUS="FAILED"
CLEANUP_STATUS="FAILED"

###############################################################################
# Create temporary database
###############################################################################

if mysql -e "CREATE DATABASE \`$TEST_DB\`;" 2>/dev/null; then
    CREATE_STATUS="SUCCESS"
fi

if [[ "$CREATE_STATUS" != "SUCCESS" ]]; then
    echo "ERROR: Unable to create test database."
    exit 1
fi

###############################################################################
# Restore source database into temporary database
###############################################################################

if sed \
    -e "s/\`$SOURCE_DB\`/\`$TEST_DB\`/g" \
    "$BACKUP_FILE" | mysql 2>/dev/null; then

    RESTORE_STATUS="SUCCESS"
fi

###############################################################################
# Validate restored objects and data
###############################################################################

DEPARTMENT_COUNT=0
EMPLOYEE_COUNT=0
TRANSACTION_COUNT=0
TABLE_COUNT=0

if [[ "$RESTORE_STATUS" == "SUCCESS" ]]; then

    TABLE_COUNT=$(mysql -Nse "
        SELECT COUNT(*)
        FROM information_schema.tables
        WHERE table_schema='$TEST_DB';
    " 2>/dev/null)

    DEPARTMENT_COUNT=$(mysql -Nse "
        SELECT COUNT(*)
        FROM \`$TEST_DB\`.departments;
    " 2>/dev/null)

    EMPLOYEE_COUNT=$(mysql -Nse "
        SELECT COUNT(*)
        FROM \`$TEST_DB\`.employees;
    " 2>/dev/null)

    TRANSACTION_COUNT=$(mysql -Nse "
        SELECT COUNT(*)
        FROM \`$TEST_DB\`.transactions;
    " 2>/dev/null)

    if [[ "$TABLE_COUNT" == "3" &&
          "$DEPARTMENT_COUNT" == "10" &&
          "$EMPLOYEE_COUNT" == "100000" &&
          "$TRANSACTION_COUNT" == "100000" ]]; then

        VALIDATION_STATUS="SUCCESS"
    fi
fi

###############################################################################
# Cleanup
###############################################################################

if mysql -e "DROP DATABASE IF EXISTS \`$TEST_DB\`;" 2>/dev/null; then
    CLEANUP_STATUS="SUCCESS"
fi

###############################################################################
# Final status
###############################################################################

if [[ "$CREATE_STATUS" == "SUCCESS" &&
      "$RESTORE_STATUS" == "SUCCESS" &&
      "$VALIDATION_STATUS" == "SUCCESS" &&
      "$CLEANUP_STATUS" == "SUCCESS" ]]; then

    FINAL_STATUS="SUCCESS"
    EXIT_CODE=0

else

    FINAL_STATUS="FAILED"
    EXIT_CODE=1

fi

###############################################################################
# Report
###############################################################################

cat <<EOF | tee "$LOG_FILE"

========================================================
             MARIADB RESTORE TEST REPORT
========================================================

Date        : $DATE
Backup File : $BACKUP_FILE
Source DB   : $SOURCE_DB
Test DB     : $TEST_DB

---------------- RESTORE ------------------
Create DB   : $CREATE_STATUS
Restore     : $RESTORE_STATUS
Tables      : $TABLE_COUNT

---------------- DATA VALIDATION ----------
Departments  : $DEPARTMENT_COUNT
Employees    : $EMPLOYEE_COUNT
Transactions : $TRANSACTION_COUNT

---------------- VALIDATION ---------------
Validation   : $VALIDATION_STATUS

---------------- CLEANUP ------------------
Test DB     : $TEST_DB
Cleanup     : $CLEANUP_STATUS

---------------- SUMMARY ------------------
Restore Test : $FINAL_STATUS
Status       : $FINAL_STATUS
========================================================
EOF

exit "$EXIT_CODE"
