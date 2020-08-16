# Setup
1. Open your terminal and navigate into your project's root directory 
2. Run `docker-compose up`
3. When the containers have are running open another terminal window and navigate to the `scripts` directory
4. execute the restore shell script
    * Mac/Linux: `sh restore_db.sh`
    * Windows Subsystem for Linux (WSL): `bash restore_db.sh`
5. Open your browser an go to: `http://localhost:8000/`

## Login
Make sure you change these!
* Dashboard: `http://localhost:8000/admin`
* Username: admin
* Password: password

## Useful Commands
* List images: `docker ps` or `docker-compose ps`
* Open image CLI: 
    * `docker-compose exec web /bin/ash`
    * `docker-compose exec php /bin/ash`
    * `docker-compose exec db /bin/bash`
    * `docker-compose exec redis /bin/ash`
* Prune images: `docker image prune --force`
* List PHP modules: `docker run --rm {IMAGE_NAME} php -m` or `docker exec craft_php php -m`
* Inspect redis: `redis-cli` then `monitor`

Testing permissions
* Nuke root owned files/folders: `sudo rm -R src/storage/logs/ src/vendor/ src/web/cpresources/ src/composer.lock`
* List folders and permissions: `ls -lan`

# General
## Vendor files
If you require the vendor folder to be visible in your project folder (useful for plugin development and editor auto complete) you can do this by updating the volumes of the php service in docker-compose.

Replace `vendor:/var/www/html/vendor` with `./src/vendor:/var/www/html/vendor:delegated` 
Delete `vendor` from `volumes`

Note: doing this may have performance penalties, especially if you are not running linux natively, so be careful.

## WSL2 Permissions
I had some permission issues when running Docker in WSL2 that prevented my code editor from modifying certain files once they were mounted to the php container.

To fix this, I have modified the default User ID (UID) and Group ID (GID) of www-data to match the UID/GID of the default Ubuntu user.

If your user is not the default user (ie your UID/GID is not 1000/1000) you will need to add the following args to the php service (replace 1000 with your actual UID and GID).

```
php:
    build:
        ...
        args:
            USER_ID: 1000
            GROUP_ID: 1000
```

Alternatively, if you don't want to hard code a UID/GID in the docker-compose file, you can use ENV vars:

```
php:
    build:
        ...
        args:
            USER_ID: ${USER_ID:-1000}
            GROUP_ID: ${GROUP_ID:-1000}
```

Then, export your UID/GID while executing docker-compose like so: 

`USER_ID=$(id -u) GROUP_ID=$(id -g) docker-compose up --build`

You only have to do this when building the image, after that you can run `docker-compose up` as per normal.

# ToDo
* Add HTTP2
* Add SSL
* Add scripts
    * Advanced Backup DB
    * Advanced Restore DB
    * Create and download a remote DB backup
    * Download assets from a remote server