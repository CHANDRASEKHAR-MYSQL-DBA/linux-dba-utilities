# Logs

The DBA utility scripts generate execution logs during runtime.

## Logged Components

Examples include:

- DBA health check logs
- System health logs
- CPU monitoring logs
- Memory monitoring logs
- Disk monitoring logs
- MariaDB status logs
- MariaDB process monitoring logs
- Backup logs
- Replication monitoring logs
- Slow query reports
- User audit logs
- Alert logs
- Cron execution logs
- Log manager activity

## Log Management

The repository includes `log_manager.sh` for local log listing and retention cleanup.

List logs:

```bash
./log_manager.sh list
```

Clean logs older than the configured retention period:

```bash
./log_manager.sh cleanup
```

The default retention period used by the utility is 7 days.

## Alert Logging

The alert framework writes alert events to:

```text
logs/alerts.log
```

Alert records include the timestamp, severity, and message.

## Repository Policy

Log files are generated locally and are not committed to the repository to avoid storing environment-specific information.

Generated logs may contain hostnames, IP addresses, database activity, timestamps, and other operational details. Production logs should therefore remain outside source control.
