# MySQL Administration Scripts


This directory contains shell scripts for MySQL and MariaDB database administration tasks.


These utilities help DBAs perform common operational activities such as:


- Database status monitoring
- Backup validation
- Replication health checks
- Slow query analysis
- User auditing
- Process and connection monitoring




# Scripts


## mysql_status.sh


Checks MySQL/MariaDB service status and basic database availability.


Example:


```bash
./mysql_status.sh

Checks:

Database service status
Database connectivity
Server availability
database_size.sh

Displays database and table size information.

Example:

./database_size.sh

Provides:

Database size
Table size information
Storage usage details
replication_status.sh

Checks MySQL/MariaDB replication health.

Example:

./replication_status.sh

Checks:

Replication status
IO thread status
SQL thread status
Replication errors
slow_query_report.sh

Generates a report from MySQL/MariaDB slow query logs.

Example:

./slow_query_report.sh

Provides:

Slow running queries
Query execution details
Performance analysis information
user_audit.sh

Audits database users and privileges.

Example:

./user_audit.sh

Checks:

Database users
User privileges
Account information
process_monitor.sh

Monitors MariaDB processes and connection health.

Example:

./process_monitor.sh
Monitoring Checks

The script checks:

MariaDB service status
Total connections
Active connections
Sleeping connections
Maximum connection usage
Connection health status
Long running queries
Top running sessions
Connection Health Threshold

The script evaluates connection usage based on configured limits.

Usage < 70%
Status : HEALTHY




Usage >= 70% and < 85%
Status : WARNING




Usage >= 85%
Status : CRITICAL
Example Output
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

Sample execution output is available:

examples/process_monitor_output.txt
Requirements

Before running the scripts, ensure:

MySQL or MariaDB server is installed
Database service is running
MySQL client package is available
User has required database privileges

Example:

mysql --version

Example:

systemctl status mariadb
Permissions

Make scripts executable before execution.

Example:

chmod +x *.sh
Testing Environment

Scripts were tested on:

Operating System : Rocky Linux 9.8
Database         : MariaDB 10.11.8
Architecture     : x86_64
Virtualization   : Oracle VirtualBox
Project Structure
mysql/
│
├── README.md
│
├── mysql_status.sh
├── database_size.sh
├── replication_status.sh
├── slow_query_report.sh
├── user_audit.sh
└── process_monitor.sh
Safety Notes
Test scripts in a non-production environment before production usage.
Do not store database passwords inside scripts.
Use secure authentication methods.
Review SQL commands before execution.
Author

CHANDRASEKHAR-MYSQL-DBA
