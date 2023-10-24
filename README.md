# Framadate-Docker Cevi Wetzikon

Nuddle / Doodle alternative for the Cevi Wetzikon

<img src="framadate/images/framadate.png" style="width: 400px" />

## Deployment

### Github Action
With the Dockerfile and the Github Action, an image is automatically created, which is then uploaded to the GitHub Container Registry and automatically deployed on pool.cevi-wetzikon.ch via Tailscale and Portainer Webhook.

<img src="framadate/images/GithubAction.png" style="width: 600px" />



## Docker Compose
```bash
version: '3'
services:
  framadate:
    image: ghcr.io/surmatik/framadate-ceviwetzikon:latest
    ports:
      - "8081:80"
    depends_on:
      - mysql
    volumes:
      - /opt/docker/framadate-ceviwetzikon/framadate-config.php:/var/www/framadate/app/inc/config.php
  mysql:
    image: mysql:5.7
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
      - MYSQL_DATABASE=${MYSQL_DATABASE}
      - MYSQL_USER=${MYSQL_USER}
      - MYSQL_PASSWORD=${MYSQL_PASSWORD}
    volumes:
      - mysql_data:/var/lib/mysql
    command: --bind-address=0.0.0.0

volumes:
  mysql_data:
```
Environment variables:

- MYSQL_ROOT_PASSWORD
- MYSQL_DATABASE
- MYSQL_USER
- MYSQL_PASSWORD

<br><br>
To make the first deployment work, when starting the Docker Compose for the first time, the volume part for Framadate needs to be temporarily deleted since the config.php and the database creation are done via a setup on the Webserver.


## Database

The database configuration must be provided as follows during the setup on the web:

DB Server Name: mysql:host=mysql;dbname=framadate;port=3306 <br>
DB User: framadate <br>
DB Password: your_password

Framadate uses the following five tables in the MySQL database:

- fd_comment
- fd_framadate_migration
- fd_poll
- fd_slot
- fd_vote