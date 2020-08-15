#!/bin/sh

DB_USER=$(grep DB_USER ../.env | cut -d '=' -f 2-)
DB_PASSWORD=$(grep DB_PASSWORD ../.env | cut -d '=' -f 2-)
DB_NAME=$(grep DB_NAME ../.env | cut -d '=' -f 2-)
DB_BACKUPS=../cms/storage/backups/

LATEST_BACKUP=$(ls -t $DB_BACKUPS | head -n1)

echo "Restoring: ${LATEST_BACKUP}"

unzip -p $DB_BACKUPS/$LATEST_BACKUP | docker-compose exec -T database /usr/bin/mysql --user=$DB_USER --password=$DB_PASSWORD $DB_NAME
