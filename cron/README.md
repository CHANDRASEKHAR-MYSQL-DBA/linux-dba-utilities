# Cron Automation

This directory contains Cron examples for automating Linux and MariaDB DBA tasks.

## Automation Examples

### MariaDB Backup

Runs the MariaDB logical backup daily at 02:00.

```cron
0 2 * * * /path/to/linux-dba-utilities/backup/backup.sh >> /path/to/linux-dba-utilities/logs/database_backup_cron.log 2>&1
```

### Latest Backup Verification

Verifies the latest backup at 02:15.

```cron
15 2 * * * /path/to/linux-dba-utilities/backup/verify_latest_backup.sh >> /path/to/linux-dba-utilities/logs/backup_verify_cron.log 2>&1
```

### Backup Rotation

Removes backups older than the configured retention period at 03:00.

```cron
0 3 * * * /path/to/linux-dba-utilities/backup/backup_rotation.sh >> /path/to/linux-dba-utilities/logs/backup_rotation_cron.log 2>&1
```

### Log Cleanup

Removes log files older than 7 days every Sunday at 04:00.

```cron
0 4 * * 0 find /path/to/linux-dba-utilities/logs -type f -name "*.log" -mtime +7 -delete
```

### MariaDB Process Monitoring

Runs the process and connection monitor every 5 minutes.

```cron
*/5 * * * * /path/to/linux-dba-utilities/mysql/process_monitor.sh >> /path/to/linux-dba-utilities/logs/process_monitor_cron.log 2>&1
```

### System Health Monitoring

Runs the Linux system health script daily at 08:00.

```cron
0 8 * * * /path/to/linux-dba-utilities/system/system_health.sh >> /path/to/linux-dba-utilities/logs/system_health_cron.log 2>&1
```

---

## Tested Automation Workflow

The Rocky Linux test environment uses the following workflow:

```text
02:00 → MariaDB backup
02:15 → Latest backup verification
03:00 → Backup rotation
04:00 Sunday → Log cleanup
Every 5 minutes → MariaDB process monitoring
08:00 → Linux system health check
```

The tested repository path was:

```text
/chand/linux/linux-dba-utilities
```

Replace this path when deploying the utilities to another server.

---

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

# MariaDB process monitor every 5 minutes
*/5 * * * * /path/to/linux-dba-utilities/mysql/process_monitor.sh >> /path/to/linux-dba-utilities/logs/process_monitor_cron.log 2>&1

# Daily Linux system health check at 08:00
0 8 * * * /path/to/linux-dba-utilities/system/system_health.sh >> /path/to/linux-dba-utilities/logs/system_health_cron.log 2>&1
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

Generated SQL backup files and runtime logs should remain local and should not be committed to GitHub.
