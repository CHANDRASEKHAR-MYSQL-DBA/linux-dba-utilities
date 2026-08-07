#!/bin/bash
echo "Disk Usage"
df -h
echo
du -sh /* 2>/dev/null | sort -h
