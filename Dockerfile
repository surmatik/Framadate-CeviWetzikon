FROM php:7.4-apache

RUN apt-get update && \
    apt-get install -y git libicu-dev && \
    docker-php-ext-install pdo pdo_mysql intl && \
    a2enmod rewrite

# Framedate Folder
RUN mkdir -p /var/www/framadate
COPY ./app /var/www/framadate

# Costum Apache Configuration
COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/framadate/tpl_c
RUN chown -R www-data:www-data /var/www/framadate/admin/../app/inc

# Set the work directory
WORKDIR /var/www/framadate

# Install Composer & dependencies
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install

# Apache-Port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
