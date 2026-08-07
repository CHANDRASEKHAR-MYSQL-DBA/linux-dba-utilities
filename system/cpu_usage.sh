#!/bin/bash
echo "CPU Usage"
top -bn1 | head -15
ps -eo pid,comm,%cpu --sort=-%cpu | head
