# Framadate-Docker Cevi Wetzikon

Ziel: eigene Nuddel / Doodle Alternative für den Cevi Wetzikon

## ToDos

Alle ToDos sind in auf [Todoist](https://todoist.com/app/project/2319220360)

## Deployment

Das Cevi Wetzikon Pool Tool kann via Docker Compose deployed werden.

Docker Compose:
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
Die ENV Variablen MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD können in einem '.env' File gespeichert werden oder in Portainer hinterlegt werden.

Achtung: Um sicherzustellen, dass die Datenbank und die Framadate Config korrekt funktionieren, sollte das Volume bei der ersten Bereitstellung von Framadate auskommentiert werden:
```bash
# volumes:
#      - /opt/docker/framadate-ceviwetzikon/framadate-config.php:/var/www/framadate/app/inc/config.php
```
Danach kann das Volume wieder entkommentiert werden, damit die Config Datei nicht bei jedem Neustart des Containers neu konfiguriert werden muss.

## Database
DB Server Name: mysql:host=mysql;dbname=framadate;port=3306 <br>
DB User: framadate <br>
DB Password: your_password


<img src="/framadate/images/framadate.png" style="width: 600px" />
