#!/bin/bash
echo "Memory Usage"
free -h
echo
cat /proc/meminfo | head -20
