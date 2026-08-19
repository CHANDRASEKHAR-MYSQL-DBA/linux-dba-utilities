# Linux DBA Utilities

A collection of practical Linux shell scripts for MySQL and MariaDB database administration, server monitoring, backup operations, replication checks, and routine DBA automation.

The project is designed as a hands-on DBA toolkit and portfolio project, with scripts tested in a Rocky Linux 9.8 environment running MariaDB 10.11.8.

---

## Features

### Linux System Monitoring

- Linux server health monitoring
- CPU usage monitoring
- Memory and swap monitoring
- Disk/filesystem usage monitoring
- System load monitoring
- Network connectivity checks
- Running process monitoring

### MySQL / MariaDB Administration

- MariaDB server status checks
- Database size reporting
- Backup automation using `mysqldump`
- Replication status monitoring
- Slow query configuration and statistics checks
- Database user auditing

### Automation

- Cron job examples for scheduled DBA tasks
- Execution logging
- Reusable Bash scripts
- Command-line help options
- Exit status handling

### Reporting

Scripts generate structured, human-readable reports containing:

- Date and hostname
- System/database information
- Health status
- Resource utilization
- Configuration details
- Summary sections

---

## Technologies

- Linux
- Rocky Linux
- Bash Shell
- MySQL
- MariaDB
- Cron
- systemd / systemctl
- mysqldump
- Linux command-line utilities

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
│   ├── backup.sh
│   ├── replication_status.sh
│   ├── slow_query_report.sh
│   └── user_audit.sh
│
├── cron/
│   ├── README.md
│   └── crontab_examples.md
│
├── logs/
│   └── README.md
│
├── screenshots/
│   ├── system_health_output.txt
│   ├── cpu_usage_output.txt
│   ├── memory_usage_output.txt
│   ├── disk_usage_output.txt
│   ├── mysql_status_output.txt
│   ├── database_size_output.txt
│   ├── backup_output.txt
│   ├── replication_status_output.txt
│   ├── slow_query_report_output.txt
│   └── user_audit_output.txt
│
├── LICENSE
└── README.md
```

---

## Requirements

### Operating System

The scripts are intended for Linux environments such as:

- Rocky Linux
- RHEL
- CentOS
- Ubuntu

### Software

For Linux monitoring scripts:

```text
Bash
coreutils
procps
iproute
systemd
```

For MySQL/MariaDB scripts:

```text
MySQL client
or
MariaDB client
```

For backup operations:

```text
mysqldump
```

---

## Installation

Clone the repository:

```bash
git clone https://github.com/<your-username>/linux-dba-utilities.git
```

Navigate to the repository:

```bash
cd linux-dba-utilities
```

Make the scripts executable:

```bash
chmod +x system/*.sh
chmod +x mysql/*.sh
```

---

## Usage

### Linux System Health

```bash
cd system
./system_health.sh
```

Example:

```text
========================================================
             LINUX SYSTEM HEALTH REPORT
========================================================

Date        : 2026-08-19 14:46:58
Hostname    : localhost.localdomain
OS          : Rocky Linux 9.8 (Blue Onyx)
Kernel      : 5.14.0-687.10.1.el9_8.0.1.x86_64

---------------- SYSTEM ----------------
Uptime      : up 9 minutes
CPU         : 6 CPUs
CPU Model   : 13th Gen Intel(R) Core(TM) i7-1355U
Load        : 0.75, 1.79, 1.19

---------------- MEMORY ----------------
Total       : 11Gi
Used        : 3.1Gi
Available   : 8.1Gi
Swap        : 5.8Gi
Swap Used   : 0B

---------------- DISK ------------------
Root        : 19% used
Home        : 2% used
Boot        : 46% used

---------------- NETWORK ---------------
Interface   : enp0s3
IP Address  : 10.0.2.15
Internet    : OK

---------------- DATABASE --------------
MariaDB     : RUNNING

---------------- SUMMARY ---------------
System Health : CHECKED
Disk Health   : CHECKED
Memory Health : CHECKED
Network       : OK
Database      : RUNNING
========================================================
```

---

## CPU Monitoring

```bash
cd system
./cpu_usage.sh
```

The script reports:

- CPU count
- CPU model
- Load average
- CPU utilization
- Top CPU-consuming processes

---

## Memory Monitoring

```bash
cd system
./memory_usage.sh
```

The script reports:

- Total memory
- Used memory
- Free memory
- Available memory
- Memory utilization
- Swap usage

---

## Disk Monitoring

```bash
cd system
./disk_usage.sh
```

The script reports:

- Filesystem usage
- Mount points
- Usage percentage
- Warning threshold
- Critical threshold

---

# MySQL / MariaDB Utilities

## MariaDB Server Status

```bash
cd mysql
./mysql_status.sh
```

Reports:

- MariaDB version
- Service status
- Server uptime
- Connections
- Questions
- Slow queries

---

## Database Size

```bash
./database_size.sh
```

Reports database sizes using:

```sql
information_schema.tables
```

Example:

```text
---------------- DATABASES ---------------
Database                     Size (MB)
mysql                             3.35
information_schema                0.20
sys                               0.03
performance_schema                0.00
```

---

## MariaDB Backup

```bash
./backup.sh
```

The script creates a logical backup using:

```bash
mysqldump --all-databases
```

Backup files are stored in:

```text
./backup/
```

Example:

```text
Backup      : SUCCESS
Exit Code   : 0
Status      : SUCCESS
```

---

## Replication Monitoring

```bash
./replication_status.sh
```

The script checks MariaDB replication status using:

```sql
SHOW REPLICA STATUS\G
```

and falls back to:

```sql
SHOW SLAVE STATUS\G
```

depending on server compatibility.

The script can report:

- Replication configuration
- I/O thread status
- SQL thread status
- Replication lag
- Master/source host
- Replication health

> Replication is not currently configured on the standalone Rocky Linux test VM. The script correctly reports `NOT CONFIGURED` when no replication configuration exists.

---

## Slow Query Report

```bash
./slow_query_report.sh
```

Reports:

- Slow query log status
- Long query time
- Number of slow queries

---

## User Audit

```bash
./user_audit.sh
```

Reports:

- MariaDB users
- Host information
- Anonymous user count
- Basic account audit information

---

# Logging

The scripts create runtime logs under:

```text
logs/
```

Example:

```text
logs/
├── system_health.log
├── cpu_usage.log
├── memory_usage.log
├── disk_usage.log
├── mysql_status.log
├── database_size.log
├── backup.log
├── replication_status.log
├── slow_query_report.log
└── user_audit.log
```

Runtime logs are not intended to be committed to GitHub because they may contain environment-specific information.

---

# Cron Automation

The `cron/` directory contains examples for automating routine DBA tasks.

Example:

```cron
# Daily system health check
0 8 * * * /path/to/linux-dba-utilities/system/system_health.sh

# Daily MariaDB backup
0 2 * * * /path/to/linux-dba-utilities/mysql/backup.sh

# Replication check every 10 minutes
*/10 * * * * /path/to/linux-dba-utilities/mysql/replication_status.sh

# Disk usage check every 6 hours
0 */6 * * * /path/to/linux-dba-utilities/system/disk_usage.sh
```

These are examples and should be adjusted according to the server environment.

---

# Testing Environment

The initial scripts have been tested in:

```text
Operating System : Rocky Linux 9.8
Architecture     : x86_64
Database         : MariaDB 10.11.8
Virtualization   : Oracle VirtualBox
```

Tested areas include:

- Linux system health
- CPU monitoring
- Memory monitoring
- Disk monitoring
- MariaDB server status
- Database size
- MariaDB backup
- Replication status detection
- Slow query configuration
- User auditing

---

# Sample Output

Example execution reports are available under:

```text
screenshots/
```

These files demonstrate the output generated by the scripts during testing.

---

# Security Notes

- Do not hard-code database passwords in scripts.
- Avoid committing credentials, private keys, or production configuration files.
- Review generated logs before committing them to a public repository.
- Use appropriate MariaDB accounts and privileges when running DBA utilities.
- Test backup and restore procedures before using them in production.

---

# Roadmap

The project will be expanded with additional DBA automation and monitoring capabilities.

### Phase 1 - Current

- [x] Linux health monitoring
- [x] CPU monitoring
- [x] Memory monitoring
- [x] Disk monitoring
- [x] MariaDB status monitoring
- [x] Database size reporting
- [x] Backup utility
- [x] Replication status check
- [x] Slow query reporting
- [x] User auditing
- [x] Cron examples
- [x] Execution logging

### Phase 2 - Planned

- [ ] Backup rotation
- [ ] Backup verification
- [ ] Restore validation
- [ ] Table size reporting
- [ ] Processlist monitoring
- [ ] Connection monitoring
- [ ] Network status monitoring
- [ ] Service monitoring
- [ ] Filesystem monitoring
- [ ] Large file detection

### Phase 3 - Advanced Monitoring

- [ ] Threshold-based alerts
- [ ] Email notifications
- [ ] Slack notifications
- [ ] HTML health reports
- [ ] Automated health dashboards
- [ ] Advanced replication monitoring
- [ ] MySQL/MariaDB configuration checks

---

# Author

**Chandrasekhar Chittimoju**

Linux | MySQL | MariaDB | Database Administration | Bash Automation

---

## Disclaimer

This project is intended for learning, demonstration, and DBA portfolio purposes.

Always test scripts in a non-production environment before deploying them to production systems.
