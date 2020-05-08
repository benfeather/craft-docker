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
* Prune images: `docker image prune --force`

# ToDo

* Add HTTP2
* Add SSL
* Add scripts
    * Advanced Backup DB
    * Advanced Restore DB
    * Create and download a remote DB backup
    * Download assets from a remote server