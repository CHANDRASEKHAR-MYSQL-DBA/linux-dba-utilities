# Cron Automation

This directory contains Cron examples for automating Linux and MariaDB DBA tasks.

## Automation Examples

### System Health Monitoring

Runs the system health script on a scheduled basis.

```cron
0 8 * * * /path/to/linux-dba-utilities/system/system_health.sh
