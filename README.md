# Linux DBA Utilities

A collection of practical Linux shell scripts developed for MySQL and MariaDB database administration, system monitoring, backup management, recovery validation, and automation.

The project is built and tested in a Rocky Linux lab environment with MariaDB and is intended as a practical DBA automation and learning toolkit.

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
- Automatic latest-backup verification
- Backup rotation and retention
- Restore testing
- Restore data validation
- Automatic cleanup of test databases

### Automation

- Cron job examples
- Scheduled system health checks
- Scheduled database backups
- Scheduled backup verification
- Scheduled backup rotation
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

## Repository Structure

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
│   ├── restore_test.sh
│   └── verify_latest_backup.sh
│
├── cron/
│   ├── README.md
│   ├── crontab_examples.md
│   ├── database_backup.cron
│   ├── log_cleanup.cron
│   └── system_health.cron
│
├── logs/
│   └── README.md
│
├── examples/
│   ├── README.md
│   ├── system_health_output.txt
│   ├── cpu_usage_output.txt
│   ├── memory_usage_output.txt
│   ├── disk_usage_output.txt
│   ├── mysql_status_output.txt
│   ├── database_size_output.txt
│   ├── replication_status_output.txt
│   ├── slow_query_report_output.txt
│   ├── user_audit_output.txt
│   ├── backup_output.txt
│   ├── backup_verify_output.txt
│   ├── backup_rotation_output.txt
│   ├── restore_test_output.txt
│   ├── cron_system_health_output.txt
│   ├── cron_backup_output.txt
│   ├── cron_backup_verify_output.txt
│   └── cron_backup_rotation_output.txt
│
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
```

---

## Usage

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
```

### Backup & Recovery

Backup utilities are maintained separately from the MySQL administration scripts.

```bash
cd backup
```

Create a logical backup:

```bash
./backup.sh
```

Verify a specific backup:

```bash
./backup_verify.sh ./backup_files/<backup_file>.sql
```

Verify the latest backup automatically:

```bash
./verify_latest_backup.sh
```

Rotate backups according to the configured retention period:

```bash
./backup_rotation.sh
```

Run a restore validation test:

```bash
./restore_test.sh ./backup_files/<backup_file>.sql
```

The restore test creates a temporary database, restores the backup, validates the restored data, and removes the temporary database.

---

## Cron Automation

Cron examples are maintained in the `cron/` directory.

The tested automation workflow is:

```text
02:00 → MariaDB backup
02:15 → Latest backup verification
03:00 → Backup rotation
04:00 Sunday → Log cleanup
08:00 → Linux system health check
```

Example backup Cron job:

```cron
0 2 * * * /path/to/linux-dba-utilities/backup/backup.sh >> /path/to/linux-dba-utilities/logs/database_backup_cron.log 2>&1
```

See `cron/crontab_examples.md` for the complete example configuration.

---

## Logging

The scripts generate runtime logs during execution.

Logs are stored locally and are intentionally not committed to the repository because runtime logs may contain environment-specific information.

The `logs/` directory contains documentation about the logging approach.

---

## Examples

The `examples/` directory contains sample execution outputs generated while testing the scripts on Linux.

Examples include:

- System health output
- CPU monitoring output
- Memory monitoring output
- Disk monitoring output
- MariaDB status output
- Database size output
- Backup output
- Backup verification output
- Backup rotation output
- Restore validation output
- Replication status output
- Slow query report output
- User audit output
- Cron system health output
- Cron MariaDB backup output
- Cron backup verification output
- Cron backup rotation output

Cron execution outputs are included to demonstrate the results of scheduled automation jobs.

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
- [x] Log cleanup automation example
- [x] Cron execution testing

### Phase 4 — Advanced DBA Monitoring

- [ ] Process list monitoring
- [ ] Connection monitoring
- [ ] Table size monitoring
- [ ] MariaDB service monitoring
- [ ] Filesystem monitoring
- [ ] Threshold-based alerts

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
