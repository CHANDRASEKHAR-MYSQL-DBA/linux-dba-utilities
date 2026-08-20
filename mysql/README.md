# MySQL / MariaDB Administration Scripts

This directory contains Bash utilities for common MySQL and MariaDB database administration and operational monitoring tasks.

## Scripts

### mysql_status.sh

Checks MySQL/MariaDB service status and basic database connectivity.

```bash
./mysql_status.sh
```

Checks include:

- Database service status
- Database connectivity
- Server availability

### database_size.sh

Reports database and table storage usage.

```bash
./database_size.sh
```

Provides:

- Database size
- Table size information
- Storage usage details

### replication_status.sh

Checks MySQL/MariaDB replication health.

```bash
./replication_status.sh
```

Checks include:

- Replication status
- I/O thread status
- SQL thread status
- Replication errors

### slow_query_report.sh

Generates a report from MySQL/MariaDB slow query information.

```bash
./slow_query_report.sh
```

Provides:

- Slow-running queries
- Query execution details
- Performance analysis information

### user_audit.sh

Audits database users and privileges.

```bash
./user_audit.sh
```

Checks include:

- Database users
- User privileges
- Account information

### process_monitor.sh

Monitors MariaDB processes and connection health.

```bash
./process_monitor.sh
```

Monitoring checks include:

- MariaDB service status
- Total connections
- Active connections
- Sleeping connections
- Maximum connection usage
- Connection health status
- Long-running queries
- Top running sessions

## Connection Health Thresholds

The process monitor evaluates connection usage using configured thresholds:

```text
Usage < 70%             → HEALTHY
70% <= Usage < 85%      → WARNING
Usage >= 85%            → CRITICAL
```

## Example Output

```text
========================================================
             MARIADB PROCESS MONITOR
========================================================

---------------- SERVICE ----------------
MariaDB     : RUNNING

---------------- CONNECTIONS ----------------
Total Connections  : 8
Active Connections : 1
Max Connections    : 151
Usage              : 5.30%

---------------- SESSIONS ----------------
Sleeping Connections : 7

---------------- LONG RUNNING ----------------

---------------- SUMMARY ----------------
Process Monitor     : COMPLETED
Total Connections   : 8
Active Connections  : 1
Sleeping Connections: 7
Long Running Queries: 0
Connection Usage    : 5.30%
Connection Status   : HEALTHY
Status              : SUCCESS
Connection Message  : Connection usage is within normal range

========================================================
```

A sample execution output is available in:

```text
examples/process_monitor_output.txt
```

## Requirements

Before running the scripts, ensure:

- MySQL or MariaDB server is installed
- Database service is running
- MySQL/MariaDB client package is available
- The user has the required database privileges

Check the client:

```bash
mysql --version
```

Check MariaDB:

```bash
systemctl status mariadb
```

## Permissions

Make the scripts executable before execution:

```bash
chmod +x *.sh
```

## Testing Environment

The scripts were tested on:

```text
Operating System : Rocky Linux 9.8
Database         : MariaDB 10.11.8
Architecture     : x86_64
Shell            : Bash
Virtualization   : Oracle VirtualBox
```

## Safety Notes

- Test scripts in a non-production environment before production usage.
- Do not store database passwords inside scripts.
- Use secure authentication methods.
- Review SQL commands before execution.
- Review privileges before running administrative operations.

## Related Components

The repository also contains:

- `dba_health_check.sh` for consolidated DBA health reporting
- `alerts/alert_manager.sh` for threshold-based alerts
- `log_manager.sh` for local log retention management
- `backup/` for backup and recovery operations
- `system/` for Linux server health monitoring

## Author

CHANDRASEKHAR-MYSQL-DBA
