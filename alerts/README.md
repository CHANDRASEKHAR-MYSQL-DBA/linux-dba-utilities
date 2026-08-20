# DBA Alert Management

This directory contains the alert utility used by the Linux and MariaDB DBA monitoring scripts.

## alert_manager.sh

`alert_manager.sh` provides a simple centralized alert interface for common DBA conditions.

Supported alert types:

```bash
./alert_manager.sh mysql_down
./alert_manager.sh high_connections
./alert_manager.sh long_query
./alert_manager.sh backup_failed
```

## Alert Conditions

| Alert | Severity | Meaning |
|---|---|---|
| `mysql_down` | CRITICAL | MariaDB service is unavailable |
| `high_connections` | WARNING | Database connection usage is high |
| `long_query` | WARNING | A long-running query was detected |
| `backup_failed` | CRITICAL | MariaDB backup operation failed |

## Logging

Alerts are written to the local runtime log:

```text
/chand/linux/linux-dba-utilities/logs/alerts.log
```

The log contains:

- Alert timestamp
- Severity
- Alert message

Runtime logs are intentionally not committed to GitHub.

## Integration

The alert manager is integrated with the repository's DBA monitoring workflow.

```text
MariaDB / Linux condition
          |
          v
Monitoring script
          |
          v
alert_manager.sh
          |
          v
alerts.log
```

Current integrations include:

- `dba_health_check.sh`
- `mysql/process_monitor.sh`
- `backup/backup.sh`

## Testing

Each alert can be tested directly from the repository:

```bash
./alerts/alert_manager.sh mysql_down
./alerts/alert_manager.sh high_connections
./alerts/alert_manager.sh long_query
./alerts/alert_manager.sh backup_failed
```

The test commands generate a visible alert message and append the event to `logs/alerts.log`.

## Safety

This is a local alert and logging framework. It does not send email or external notifications yet. External notification integrations can be added as a future enhancement.
