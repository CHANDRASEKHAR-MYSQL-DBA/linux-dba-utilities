#!/bin/bash
mysql -e "SELECT User,Host FROM mysql.user ORDER BY User;"
mysql -e "SHOW GRANTS FOR CURRENT_USER();"
