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

Navigate to the system directory:

```bash
cd system
```

Run the system health check:

```bash
./system_health.sh
```

Run individual monitoring scripts:

```bash
./cpu_usage.sh
./memory_usage.sh
./disk_usage.sh
```

---

## MySQL / MariaDB Administration

Navigate to the MySQL directory:

```bash
cd mysql
```

Check MariaDB server status:

```bash
./mysql_status.sh
```

Check database sizes:

```bash
./database_size.sh
```

Check replication status:

```bash
./replication_status.sh
```

Generate a slow query report:

```bash
./slow_query_report.sh
```

Audit database users:

```bash
./user_audit.sh
```

---

## Backup & Recovery

Backup utilities are maintained separately from the MySQL administration scripts.

Navigate to the backup directory:

```bash
cd backup
```

### Create a Backup

```bash
./backup.sh
```

The script creates a logical MariaDB backup using `mysqldump`.

### Verify a Backup

```bash
./backup_verify.sh ./backup/dba_restore_source.sql
```

The verification script checks:

- Backup file existence
- File readability
- SQL content
- Backup validation status

### Backup Rotation

```bash
./backup_rotation.sh
```

The rotation script manages old backup files according to the configured retention period.

### Restore Test

```bash
./restore_test.sh ./backup/dba_restore_source.sql
```

The restore test:

1. Creates a temporary test database
2. Restores the backup
3. Validates the restored tables
4. Validates row counts
5. Removes the temporary database

Example validation:

```text
Tables       : 3
Departments  : 10
Employees    : 100000
Transactions : 100000

Restore Test : SUCCESS
Status       : SUCCESS
```

The restore workflow was tested using a MariaDB test dataset containing approximately 200,010 rows.

---

## Cron Automation

Cron examples are maintained in the `cron/` directory.

```bash
cd cron
```

The Cron section demonstrates how DBA scripts can be scheduled for:

- System health checks
- Database backups
- Backup rotation
- Log cleanup

Example backup Cron job:

```cron
0 2 * * * /path/to/linux-dba-utilities/backup/backup.sh
```

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

These files demonstrate the expected output format of the utilities.

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
- [x] Backup rotation
- [x] Restore testing
- [x] Restore data validation

### Phase 3 — Automation

- [ ] System health Cron job
- [ ] Automated database backup
- [ ] Automated backup rotation
- [ ] Log cleanup automation
- [ ] Cron execution examples

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
