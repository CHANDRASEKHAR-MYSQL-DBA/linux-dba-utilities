# Linux DBA Utilities

A collection of practical Linux shell scripts developed for MySQL and MariaDB database administration, system monitoring, backup management, recovery validation, and automation.

The project is built and tested in a Rocky Linux environment with MariaDB and is intended as a practical DBA automation and learning toolkit.

---

## Features

### Linux System Monitoring

- System health monitoring
- CPU usage monitoring
- Memory usage monitoring
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

### Backup & Recovery

- Logical MariaDB backup using `mysqldump`
- Backup verification
- Backup rotation and retention
- Restore testing
- Restore data validation
- Automatic cleanup of test databases

### Automation

- Cron job examples
- Scheduled system health checks
- Scheduled database backups
- Log cleanup automation

### Documentation & Examples

- Script-specific README files
- Sample execution outputs
- Human-readable reports
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

---

# Repository Structure

```text
linux-dba-utilities/
│
├── system/
│   ├── README.md
│   ├── system_health.sh
│   ├── cpu_usage.sh
│   ├── memory_usage.sh
│   └── disk_usage.sh
│
├── mysql/
│   ├── README.md
│   ├── mysql_status.sh
│   ├── database_size.sh
│   ├── replication_status.sh
│   ├── slow_query_report.sh
│   └── user_audit.sh
│
├── backup/
│   ├── README.md
│   ├── backup.sh
│   ├── backup_verify.sh
│   ├── backup_rotation.sh
│   └── restore_test.sh
│
├── cron/
│   ├── README.md
│   └── crontab_examples.md
│
├── logs/
│   └── README.md
│
├── examples/
│   ├── system_health_output.txt
│   ├── cpu_usage_output.txt
│   ├── memory_usage_output.txt
│   ├── disk_usage_output.txt
│   ├── mysql_status_output.txt
│   ├── database_size_output.txt
│   ├── backup_output.txt
│   ├── backup_verify_output.txt
│   ├── backup_rotation_output.txt
│   ├── restore_test_output.txt
│   ├── replication_status_output.txt
│   ├── slow_query_report_output.txt
│   └── user_audit_output.txt
│
├── LICENSE
└── README.md
