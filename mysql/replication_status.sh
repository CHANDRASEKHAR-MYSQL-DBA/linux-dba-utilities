#!/bin/bash
mysql -e "SHOW REPLICA STATUS\G" 2>/dev/null || mysql -e "SHOW SLAVE STATUS\G"
