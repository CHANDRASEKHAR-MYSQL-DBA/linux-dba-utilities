#!/bin/bash
mysql -e "STATUS;" || { echo "Unable to connect"; exit 1; }
systemctl status mariadb --no-pager 2>/dev/null || systemctl status mysql --no-pager
