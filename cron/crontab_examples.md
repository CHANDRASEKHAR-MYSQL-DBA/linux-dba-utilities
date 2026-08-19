# =========================================================
# DBA CRON JOB EXAMPLES
# =========================================================

# Daily system health check at 8:00 AM
0 8 * * * /home/dba/linux-dba-utilities/system/system_health.sh

# Daily MariaDB backup at 2:00 AM
0 2 * * * /path/to/linux-dba-utilities/backup/backup.sh

# Check replication every 10 minutes
*/10 * * * * /home/dba/linux-dba-utilities/mysql/replication_status.sh

# Check disk usage every 6 hours
0 */6 * * * /home/dba/linux-dba-utilities/system/disk_usage.sh
