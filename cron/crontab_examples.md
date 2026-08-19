# DBA Cron Job Examples

This file contains example Cron schedules for automating Linux and MariaDB DBA utilities.

## Tested Automation Workflow

The current Rocky Linux test environment uses the following schedule:

```text
02:00 → MariaDB backup
02:15 → Latest backup verification
03:00 → Backup rotation
04:00 Sunday → Log cleanup
08:00 → Linux system health check
```

## Complete Example

```cron
# Daily MariaDB backup at 02:00
0 2 * * * /path/to/linux-dba-utilities/backup/backup.sh >> /path/to/linux-dba-utilities/logs/database_backup_cron.log 2>&1

# Verify latest MariaDB backup at 02:15
15 2 * * * /path/to/linux-dba-utilities/backup/verify_latest_backup.sh >> /path/to/linux-dba-utilities/logs/backup_verify_cron.log 2>&1

# Rotate old backups at 03:00
0 3 * * * /path/to/linux-dba-utilities/backup/backup_rotation.sh >> /path/to/linux-dba-utilities/logs/backup_rotation_cron.log 2>&1

# Weekly log cleanup - Sunday at 04:00
0 4 * * 0 find /path/to/linux-dba-utilities/logs -type f -name "*.log" -mtime +7 -delete

# Daily Linux system health check at 08:00
0 8 * * * /path/to/linux-dba-utilities/system/system_health.sh >> /path/to/linux-dba-utilities/logs/system_health_cron.log 2>&1
```

## Additional DBA Examples

Check MariaDB replication status every 10 minutes:

```cron
*/10 * * * * /path/to/linux-dba-utilities/mysql/replication_status.sh >> /path/to/linux-dba-utilities/logs/replication_status_cron.log 2>&1
```

Check disk usage every 6 hours:

```cron
0 */6 * * * /path/to/linux-dba-utilities/system/disk_usage.sh >> /path/to/linux-dba-utilities/logs/disk_usage_cron.log 2>&1
```

## Cron Management

List current Cron jobs:

```bash
crontab -l
```

Edit Cron jobs:

```bash
crontab -e
```

Check the Cron service on Rocky Linux:

```bash
systemctl status crond
```

Review Cron activity:

```bash
journalctl -u crond
```

## Notes

Replace `/path/to/linux-dba-utilities` with the actual installation path on the target Linux server.

In the Rocky Linux test environment, the repository path was:

```text
/chand/linux/linux-dba-utilities
```

Generated SQL backup files and runtime logs should remain local and should not be committed to GitHub.
