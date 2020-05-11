# Setup
1. Open your terminal and navigate into your project's root directory 
2. Run `docker-compose up`
3. When the containers have are running open another terminal window and navigate to the `scripts` directory
4. execute the `db_restore.sh` shell script
    * Mac: `sh db_backup.sh`
    * Windows Subsystem for Linux (WSL): `bash db_backup.sh`
5. Open your browser an go to: `http://localhost:8000/`

## Login
Make sure you change these!
* Dashboard: `http://localhost:8000/admin`
* Username: admin
* Password: password

## Useful Commands
* List images: `docker ps` or `docker-compose ps`
* Open image CLI: 
    * `docker exec -it craft_web /bin/ash`
    * `docker exec -it craft_php /bin/ash`
    * `docker exec -it craft_db /bin/bash`
    * `docker exec -it craft_redis /bin/ash`
* Prune images: `docker image prune --force`
* List PHP modules: `docker run --rm {IMAGE_NAME} php -m` or `docker exec craft_php php -m`
* Inspect redis: `redis-cli` then `monitor`

# General
## Vendor files
If you require the vendor folder to be visible in your project folder (useful for plugin development and editor auto complete) you can do this by updating the volumes of the php service in docker-compose.

Replace `vendor:/var/www/html/vendor` with `./cms/vendor:/var/www/html/vendor:delegated` 
Delete `vendor` from `volumes`

Note: doing this may have performance penalties, especially if you are not running linux natively, so be careful.

# ToDo
* Add HTTP2
* Add SSL
* Add scripts
    * Advanced Backup DB
    * Advanced Restore DB
    * Create and download a remote DB backup
    * Download assets from a remote server