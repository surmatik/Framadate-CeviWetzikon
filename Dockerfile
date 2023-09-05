FROM php:7.4-apache

RUN apt-get update && \
    apt-get install -y git libicu-dev libxml2-dev zip unzip zlib1g-dev g++ mariadb-client jq pandoc && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql intl && \
    a2enmod rewrite

# Framadate Folder
RUN mkdir -p /var/www/framadate
COPY ./app /var/www/framadate

# Apache Configuration
COPY apache.conf /etc/apache2/sites-available/000-default.conf 

# Framadate Configuration
COPY framadate-config.php /var/www/framadate/app/inc/config.php
COPY framadate-htaccess.txt /var/www/framadate/.htaccess

COPY ./images /var/www/framadate/images
COPY ./images/favicon.ico /var/www/framadate/favicon.ico

COPY ./tpl /var/www/framadate/tpl

COPY framadate-style.css /var/www/framadate/css/custom-style.css
RUN cat /var/www/framadate/css/custom-style.css >> /var/www/framadate/css/style.css

COPY php-create_classic_poll.php /var/www/framadate/create_classic_poll.php

COPY framadate-dejson-changes.txt /var/www/framadate/locale/framadate-dejson-changes.txt
COPY script-dejsonchanges.sh /var/www/framadate/locale/script-dejsonchanges.sh
RUN chmod +x /var/www/framadate/locale/script-dejsonchanges.sh
RUN /var/www/framadate/locale/script-dejsonchanges.sh

COPY ./docs /var/www/framadate/docs
COPY script-mdtodocspage.sh /var/www/framadate/docs/script-mdtodocspage.sh
RUN chmod +x /var/www/framadate/docs/script-mdtodocspage.sh
RUN /var/www/framadate/docs/script-mdtodocspage.sh

# Set permissions
RUN chown -R www-data:www-data /var/www/framadate/tpl_c
RUN chown -R www-data:www-data /var/www/framadate/admin/../app/inc
RUN chown -R www-data:www-data /var/www/framadate/app/inc/../../admin

# Set the work directory
WORKDIR /var/www/framadate

# Install Composer & dependencies
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer install

# Apache-Port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
