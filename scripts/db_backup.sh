#!/bin/sh

DB_USER=$(grep DB_USER ../.env | cut -d '=' -f 2-)
DB_PASSWORD=$(grep DB_PASSWORD ../.env | cut -d '=' -f 2-)
DB_NAME=$(grep DB_NAME ../.env | cut -d '=' -f 2-)
DB_BACKUPS=../cms/storage/backups/

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

docker-compose exec -T database /usr/bin/mysqldump --user=$DB_USER --password=$DB_PASSWORD $DB_NAME > $DB_BACKUPS/database_$TIMESTAMP.sql
