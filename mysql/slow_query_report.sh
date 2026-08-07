#!/bin/bash
mysql -e "SHOW VARIABLES LIKE 'slow_query_log';"
mysql -e "SHOW GLOBAL STATUS LIKE 'Slow_queries';"
