#!/bin/sh
docker exec craft_db /usr/bin/mysqldump --user=user --password=password project > ../backups/database.sql