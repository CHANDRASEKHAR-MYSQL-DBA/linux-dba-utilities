#!/bin/bash
mysql -e "SELECT table_schema AS Database_Name, ROUND(SUM(data_length+index_length)/1024/1024,2) AS Size_MB FROM information_schema.tables GROUP BY table_schema ORDER BY Size_MB DESC;"
