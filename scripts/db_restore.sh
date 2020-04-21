#!/bin/sh

cat ../backups/database.sql | docker exec -i craft_db /usr/bin/mysql --user=user --password=password project