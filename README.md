# Linux DBA Utilities

A practical collection of Linux shell scripts for MySQL and MariaDB database administration, system monitoring, backup and recovery, logging, alerting, and Cron automation.

The project is built and tested in a Rocky Linux lab environment with MariaDB and is intended as a practical DBA automation, operations, and learning toolkit.

---

## Features

### Linux System Monitoring

- System health monitoring
- CPU usage monitoring
- Memory and swap monitoring
- Disk usage monitoring
- Load average monitoring
- Network connectivity checks
- MariaDB service status checks

### MySQL / MariaDB Administration

- MariaDB server status monitoring
- Database size reporting
- Replication status monitoring
- Slow query reporting
- Database user auditing
- Process and connection monitoring
- Long-running query detection
- Connection usage thresholds

### DBA Health Dashboard

- Consolidated MariaDB health check
- Connection usage reporting
- Database count reporting
- Long-running query detection
- Latest backup availability check
- Overall database health status
- Local runtime logging

### Backup & Recovery

- Logical MariaDB backup using `mysqldump`
- Backup verification
- Automatic latest-backup verification
- Backup rotation and retention
- Restore testing
- Restore data validation
- Automatic cleanup of test databases

### Alert Management

- MariaDB service failure alerts
- High connection usage alerts
- Long-running query alerts
- Backup failure alerts
- Centralized alert logging
- Integration with DBA health and backup monitoring scripts

### Logging

- Centralized runtime logs
- DBA health check logs
- Process monitoring logs
- Backup logs
- System health logs
- Alert logs
- Log cleanup utility with retention support

Runtime logs and generated backup files remain local and are excluded from GitHub.

### Automation

- Cron job examples
- Scheduled MariaDB backups
- Scheduled system health checks
- Scheduled process monitoring
- Scheduled backup verification
- Scheduled backup rotation
- Log cleanup automation

### Documentation & Examples

- Script-specific README files
- Sample execution outputs
- Human-readable DBA reports
- Practical Linux and MariaDB administration examples

---

## Technologies

- Linux
- Rocky Linux
- Bash Shell
- MySQL
- MariaDB
- Cron
- systemctl
- mysqldump
- MySQL / MariaDB command-line client
- Git / GitHub

---

## Repository Structure

```text
linux-dba-utilities/
│
├── alerts/
│   ├── README.md
│   └── alert_manager.sh
│
├── system/
│   ├── README.md
│   ├── system_health.sh
│   ├── cpu_usage.sh
│   ├── memory_usage.sh
│   ├── disk_usage.sh
│   └── uptime.sh
│
├── mysql/
│   ├── README.md
│   ├── mysql_status.sh
│   ├── database_size.sh
│   ├── replication_status.sh
│   ├── slow_query_report.sh
│   ├── user_audit.sh
│   └── process_monitor.sh
│
├── backup/
│   ├── README.md
│   ├── backup.sh
│   ├── backup_verify.sh
│   ├── backup_rotation.sh
│   ├── restore_test.sh
│   └── verify_latest_backup.sh
│
├── cron/
│   ├── README.md
│   ├── crontab_examples.md
│   ├── database_backup.cron
│   ├── log_cleanup.cron
│   ├── process_monitor.cron
│   └── system_health.cron
│
├── examples/
│   ├── README.md
│   └── sample execution outputs
│
├── logs/
│   └── README.md
│
├── dba_health_check.sh
├── log_manager.sh
├── .gitignore
├── LICENSE
└── README.md
```

---

## Installation

Clone the repository:

```bash
git clone https://github.com/CHANDRASEKHAR-MYSQL-DBA/linux-dba-utilities.git
```

Enter the repository:

```bash
cd linux-dba-utilities
```

Make the scripts executable:

```bash
chmod +x system/*.sh
chmod +x mysql/*.sh
chmod +x backup/*.sh
chmod +x alerts/*.sh
chmod +x dba_health_check.sh log_manager.sh
```

---

## Usage

### DBA Health Check

Run the consolidated health report:

```bash
./dba_health_check.sh
```

The report checks MariaDB service status, connections, database count, long-running queries, backup availability, and overall database health.

### System Monitoring

```bash
cd system
./system_health.sh
./cpu_usage.sh
./memory_usage.sh
./disk_usage.sh
```

### MySQL / MariaDB Administration

```bash
cd mysql
./mysql_status.sh
./database_size.sh
./replication_status.sh
./slow_query_report.sh
./user_audit.sh
./process_monitor.sh
```

### Backup & Recovery

```bash
cd backup
./backup.sh
./backup_verify.sh ./backup_files/<backup_file>.sql
./verify_latest_backup.sh
./backup_rotation.sh
./restore_test.sh ./backup_files/<backup_file>.sql
```

### Alert Management

The alert manager supports four alert types:

```bash
cd alerts
./alert_manager.sh mysql_down
./alert_manager.sh high_connections
./alert_manager.sh long_query
./alert_manager.sh backup_failed
```

Alerts are written to the local `logs/alerts.log` file.

### Log Management

List local log files:

```bash
./log_manager.sh list
```

Clean logs older than the configured retention period:

```bash
./log_manager.sh cleanup
```

---

## Cron Automation

The tested Rocky Linux workflow is:

```text
02:00 → MariaDB backup
02:15 → Latest backup verification
03:00 → Backup rotation
04:00 Sunday → Log cleanup
Every 5 minutes → MariaDB process monitoring
08:00 → Linux system health check
```

Example:

```cron
*/5 * * * * /path/to/linux-dba-utilities/mysql/process_monitor.sh >> /path/to/linux-dba-utilities/logs/process_monitor_cron.log 2>&1
```

See the `cron/` directory for complete Cron examples.

---

## Logging

Utilities generate runtime logs during execution. Runtime logs are stored locally and are intentionally not committed to the repository because they may contain environment-specific information.

The repository includes logging documentation, while generated `.log` files remain local.

---

## Examples

The `examples/` directory contains sample execution outputs generated while testing the utilities on Rocky Linux with MariaDB.

Examples cover system health, MariaDB monitoring, process monitoring, backup and recovery, and Cron execution.

---

## Testing Environment

The utilities have been tested in a Linux lab environment using:

```text
Operating System : Rocky Linux 9.8
Database         : MariaDB 10.11.8
Shell            : Bash
Virtualization   : Oracle VirtualBox
Architecture     : x86_64
```

The test environment is used for development, validation, and demonstration purposes.

---

## Project Roadmap

### Phase 1 — System & Database Utilities

- [x] Linux system health monitoring
- [x] CPU monitoring
- [x] Memory monitoring
- [x] Disk monitoring
- [x] MariaDB server status
- [x] Database size reporting
- [x] Replication status monitoring
- [x] Slow query reporting
- [x] User auditing

### Phase 2 — Backup & Recovery

- [x] MariaDB logical backup
- [x] Backup verification
- [x] Automated latest-backup verification
- [x] Backup rotation
- [x] Restore testing
- [x] Restore data validation

### Phase 3 — Automation

- [x] System health Cron job testing
- [x] Automated database backup testing
- [x] Automated latest-backup verification testing
- [x] Automated backup rotation testing
- [x] Log cleanup automation
- [x] Process monitoring Cron testing
- [x] Cron execution testing

### Phase 4 — Advanced DBA Monitoring

- [x] Process list monitoring
- [x] Connection monitoring
- [x] Long-running query detection
- [x] MariaDB service monitoring
- [x] Filesystem monitoring
- [x] Threshold-based connection alerts
- [x] Centralized runtime logging
- [x] DBA health dashboard
- [x] Alert management framework
- [x] Backup failure alerts

### Phase 5 — Advanced Automation

- [ ] Email notifications
- [ ] HTML health reports
- [ ] Configuration file support
- [ ] Advanced replication monitoring
- [ ] Replication failure testing
- [ ] Additional MySQL/MariaDB administration utilities

---

## Author

Chandrasekhar Chittimoju

---

## License

This project is licensed under the MIT License.
