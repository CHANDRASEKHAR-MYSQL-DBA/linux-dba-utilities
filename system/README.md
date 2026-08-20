# System Monitoring Scripts

This directory contains Linux shell scripts for monitoring server health and system resources on Rocky Linux and other Linux distributions.

## Scripts

### system_health.sh

Provides a consolidated Linux server health report covering:

- Operating system and kernel
- System uptime
- CPU count and model
- Load average
- Memory and swap usage
- Filesystem usage
- Network interface and IP address
- Internet connectivity
- MariaDB service status

Example:

```bash
./system_health.sh
```

### cpu_usage.sh

Reports CPU utilization and system load information.

Example:

```bash
./cpu_usage.sh
```

### memory_usage.sh

Reports physical memory and swap usage.

Example:

```bash
./memory_usage.sh
```

### disk_usage.sh

Reports filesystem usage and helps identify disks or mount points approaching capacity.

Example:

```bash
./disk_usage.sh
```

### uptime.sh

Displays Linux system uptime and basic availability information.

Example:

```bash
./uptime.sh
```

---

## Requirements

- Linux operating system
- Bash
- Standard Linux utilities
- `systemctl` for MariaDB service checks

The scripts are designed for operational monitoring and should be tested in a non-production environment before production use.

## Permissions

Make the scripts executable before running them:

```bash
chmod +x *.sh
```

## Testing Environment

The scripts were tested on:

```text
Operating System : Rocky Linux 9.8
Database         : MariaDB 10.11.8
Architecture     : x86_64
Shell            : Bash
Virtualization   : Oracle VirtualBox
```

## Output Examples

Sample execution output is maintained in the repository `examples/` directory.

## Logging

Some monitoring scripts write runtime information to the repository's local `logs/` directory. Generated log files are intentionally excluded from GitHub.
