#!/bin/bash

BKP_PATH="/tmp"

# Remove OLD backups
rm -rf $BKP_PATH/icinga_backup.sql

# Make a New Backup
docker exec mydb /usr/bin/mysqldump -u root --password=root --events mysql > $BKP_PATH/icinga_backup.sql 
