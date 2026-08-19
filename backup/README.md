# MariaDB Backup and Recovery

This directory contains utilities for MariaDB backup creation, backup verification, backup retention management, restore testing, and automated backup validation.

## Utilities

### backup.sh

Creates a logical MariaDB backup using `mysqldump`.

Example:

```bash
./backup.sh
```

Backups are stored in the local `backup_files/` directory.

Example backup location:

```text
backup/backup_files/
└── mariadb_YYYY-MM-DD_HHMMSS.sql
```

The script uses a script-relative backup path, so it can be executed from different directories without changing the backup destination.

---

### backup_verify.sh

Verifies that a MariaDB backup file exists, is readable, contains data, and contains valid SQL dump content.

Example:

```bash
./backup_verify.sh ./backup_files/dba_restore_source.sql
```

Checks include:

- Backup file existence
- File size
- File readability
- SQL dump content
- Validation status

Example result:

```text
========================================================
              MARIADB BACKUP VERIFY REPORT
========================================================

---------------- BACKUP ------------------
Exists      : YES
File Size   : 17M
Readable    : YES

---------------- VALIDATION ---------------
SQL Content : VALID

---------------- SUMMARY ------------------
Verification: COMPLETED
Status      : SUCCESS
========================================================
```

---

### verify_latest_backup.sh

Automatically identifies the latest `.sql` backup in `backup_files/` and verifies it using `backup_verify.sh`.

Example:

```bash
./verify_latest_backup.sh
```

The script:

- Finds the latest backup file
- Checks that the backup exists
- Checks the file size
- Verifies readability
- Validates SQL dump content
- Returns the verification status

Example:

```text
Latest backup:
/path/to/backup_files/mariadb_2026-08-19_172002.sql

========================================================
              MARIADB BACKUP VERIFY REPORT
========================================================

Verification: COMPLETED
Status      : SUCCESS
```

This utility is designed to support automated backup verification through Cron.

---

### backup_rotation.sh

Manages old backup files based on a retention period.

Default retention period:

```text
7 days
```

Example:

```bash
./backup_rotation.sh
```

The script removes backup files older than the configured retention period.

Example result:

```text
========================================================
             MARIADB BACKUP ROTATION REPORT
========================================================

Date            : 2026-08-19 17:24:38
Backup Directory: /path/to/backup_files
Retention Days  : 7

---------------- ROTATION -----------------
Old Backups     : 0
Deleted         : 0
Remaining       : 6

---------------- SUMMARY ------------------
Rotation        : COMPLETED
Status          : SUCCESS
========================================================
```

The rotation utility was tested from both the repository directory and `/tmp` to verify that it does not depend on the current working directory.

---

### restore_test.sh

Tests a MariaDB logical backup by restoring it into a temporary database and validating the restored objects and data.

Example:

```bash
./restore_test.sh ./backup_files/dba_restore_source.sql
```

The restore test validates:

- Temporary database creation
- Backup restoration
- Table count
- Department row count
- Employee row count
- Transaction row count
- Data validation
- Temporary database cleanup

Example validation:

```text
========================================================
             MARIADB RESTORE TEST REPORT
========================================================

---------------- RESTORE ------------------
Create DB   : SUCCESS
Restore     : SUCCESS
Tables      : 3

---------------- DATA VALIDATION ----------
Departments  : 10
Employees    : 100000
Transactions : 100000

---------------- VALIDATION ---------------
Validation   : SUCCESS

---------------- CLEANUP ------------------
Cleanup      : SUCCESS

---------------- SUMMARY ------------------
Restore Test : SUCCESS
Status       : SUCCESS
========================================================
```

---

## Backup Workflow

The utilities can be combined to provide a complete backup and recovery workflow.

```text
                    MariaDB
                       |
                       v
                  backup.sh
                       |
                       v
              Backup SQL File
                       |
                       v
          verify_latest_backup.sh
                       |
                       v
              backup_verify.sh
                       |
                       v
               Backup Verified
                       |
                       v
             backup_rotation.sh
                       |
                       v
              Retention Managed
                       |
                       v
                restore_test.sh
                       |
                       v
             Temporary Database
                       |
                       v
               Data Validation
                       |
                       v
                   Cleanup
```

---

## Automated Backup Workflow

The backup utilities can be automated using Linux Cron.

```text
02:00
  |
  v
backup.sh
  |
  v
backup_files/*.sql
  |
  v
02:15
  |
  v
verify_latest_backup.sh
  |
  v
backup_verify.sh
  |
  v
Backup Validation
  |
  v
03:00
  |
  v
backup_rotation.sh
  |
  v
Remove Backups Older Than 7 Days
```

---

## Cron Configuration

Example Cron configuration:

```cron
# Daily MariaDB backup at 02:00
0 2 * * * /path/to/linux-dba-utilities/backup/backup.sh >> /path/to/linux-dba-utilities/logs/database_backup_cron.log 2>&1

# Verify latest backup at 02:15
15 2 * * * /path/to/linux-dba-utilities/backup/verify_latest_backup.sh >> /path/to/linux-dba-utilities/logs/backup_verify_cron.log 2>&1

# Rotate old backups at 03:00
0 3 * * * /path/to/linux-dba-utilities/backup/backup_rotation.sh >> /path/to/linux-dba-utilities/logs/backup_rotation_cron.log 2>&1
```

The actual test environment used:

```text
/chand/linux/linux-dba-utilities
```

For another environment, replace the path with the actual repository location.

---

## Test Dataset

The restore validation was tested using the following MariaDB database:

```text
Database       : dba_restore_source
Tables         : 3
Departments    : 10 rows
Employees      : 100,000 rows
Transactions   : 100,000 rows
Total Rows     : 200,010
Backup Size    : 17 MB
```

### Data Validation

The test dataset contains:

```text
Departments
------------
10 rows

Employees
---------
100,000 rows

Transactions
------------
100,000 rows
```

Employee distribution was validated across 10 departments with 10,000 employees per department.

Transaction status distribution:

```text
COMPLETED : 90,000
FAILED    : 5,000
PENDING   : 5,000
```

The backup was successfully created and restored into a temporary test database.

---

## Testing Environment

The backup and restore utilities were tested on:

```text
Operating System : Rocky Linux 9.8
Database         : MariaDB 10.11.8
Architecture     : x86_64
Shell            : Bash
Virtualization   : Oracle VirtualBox
```

The backup automation was also tested using Linux `crond`.

---

## Backup Directory Structure

The local runtime structure is:

```text
backup/
├── README.md
├── backup.sh
├── backup_verify.sh
├── backup_rotation.sh
├── restore_test.sh
├── verify_latest_backup.sh
│
├── backup_files/
│   ├── mariadb_YYYY-MM-DD_HHMMSS.sql
│   └── ...
│
└── logs/
    └── backup.log
```

The `backup_files/` and runtime `logs/` directories contain generated files and are not intended to be committed to GitHub.

---

## Output Examples

Sample execution outputs are maintained in the repository's `examples/` directory.

Examples include:

```text
backup_output.txt
backup_verify_output.txt
backup_rotation_output.txt
restore_test_output.txt
```

Cron execution outputs can be added after capturing the corresponding Cron test runs.

These files contain sample execution results from testing the utilities on Rocky Linux with MariaDB.

---

## Cron Management

List configured Cron jobs:

```bash
crontab -l
```

Edit Cron jobs:

```bash
crontab -e
```

Check the Cron service:

```bash
systemctl status crond
```

Review Cron activity:

```bash
journalctl -u crond
```

Example Cron workflow:

```text
02:00 → MariaDB backup
02:15 → Latest backup verification
03:00 → Backup rotation
04:00 Sunday → Log cleanup
08:00 → Linux system health check
```

---

## Safety

The restore test uses a temporary database for validation and removes the temporary database after the test completes.

Always test backup and restore scripts in a non-production environment before using them on production systems.

Do not commit:

- Database passwords
- Database credentials
- Production data
- Production SQL dumps
- Runtime logs containing sensitive information

Generated backup files are excluded from the GitHub repository.

---

## Notes

These utilities are designed for:

- Linux DBA automation practice
- MySQL/MariaDB administration
- Backup and recovery testing
- Cron automation
- DBA interview preparation
- Portfolio demonstration

The scripts are intended to provide practical examples of common Linux and MariaDB DBA tasks.
