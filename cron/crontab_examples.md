# Daily MySQL Backup
0 2 * * * /home/mysql/backup.sh

# System Health Report
0 8 * * * /home/system/system_health.sh

# Replication Check
*/10 * * * * /home/mysql/replication_status.sh

# Disk Usage
0 */6 * * * /home/system/disk_usage.sh
