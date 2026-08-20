# MariaDB Backup and Recovery

This directory contains utilities for MariaDB backup creation, backup verification, backup retention management, restore testing, and automated backup validation.

## Utilities

### backup.sh

Creates a logical MariaDB backup using `mysqldump`.

Example:

```bash
./backup.sh
```

Backups are stored in the configured `backup_files/` directory.

Example backup location:

```text
backup/backup_files/
└── mariadb_YYYY-MM-DD_HHMMSS.sql
```

The current Rocky Linux test environment uses:

```text
/chand/linux/linux-dba-utilities/backup/backup_files
```

When deploying to another environment, update the configured backup path in the script as required.

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

The Rocky Linux test environment used:

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

The test dataset was used to validate backup restoration and data integrity in a temporary database.

---

## Testing Environment

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

---

## Safety

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
