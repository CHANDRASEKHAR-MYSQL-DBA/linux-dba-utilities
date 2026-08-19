# MariaDB Backup and Recovery

This directory contains utilities for MariaDB backup creation, backup verification, backup retention management, and restore validation.

## Utilities

### backup.sh

Creates a logical MariaDB backup using `mysqldump`.

Example:

```bash
./backup.sh
```

The backup file is stored in the configured backup directory.

---

### backup_verify.sh

Verifies that a MariaDB backup file exists, is readable, contains data, and contains valid SQL dump content.

Example:

```bash
./backup_verify.sh ./backup/dba_restore_source.sql
```

Checks include:

- Backup file existence
- File size
- File readability
- SQL dump content

Example result:

```text
Exists      : YES
File Size   : 17M
Readable    : YES
SQL Content : VALID
Status      : SUCCESS
```

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

Custom backup directory and retention period:

```bash
./backup_rotation.sh ./backup 14
```

The script reports:

- Number of old backups
- Number of deleted backups
- Number of remaining backups
- Rotation status

---

### restore_test.sh

Tests a MariaDB logical backup by restoring it into a temporary database and validating the restored objects and data.

Example:

```bash
./restore_test.sh ./backup/dba_restore_source.sql
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
Tables       : 3
Departments  : 10
Employees    : 100000
Transactions : 100000
Validation   : SUCCESS
Cleanup      : SUCCESS
```

---

## Backup Workflow

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

---

## Testing Environment

The backup and restore utilities were tested on:

```text
Operating System : Rocky Linux 9.8
Database         : MariaDB 10.11.8
Architecture     : x86_64
Virtualization   : Oracle VirtualBox
```

---

## Output Examples

Execution outputs are available in the repository's `screenshots/` directory.

Examples include:

```text
backup_output.txt
backup_verify_output.txt
backup_rotation_output.txt
restore_test_output.txt
```

---

## Safety

The restore test uses a temporary database for validation and removes the temporary database after the test completes.

Always test backup and restore scripts in a non-production environment before using them on production systems.

Do not commit database passwords, credentials, or sensitive production data to the repository.
