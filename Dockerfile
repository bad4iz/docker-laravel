
FROM php:7.1.2-apache


RUN apt-get update && apt-get install -y git &&\
    apt-get install -y zlib1g-dev

RUN docker-php-ext-install pdo pdo_mysql mysqli zip


RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" &&\
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" &&\
    php composer-setup.php &&\
    php -r "unlink('composer-setup.php');" &&\
    mv composer.phar /usr/local/bin/composer

#
RUN  curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install -y nodejs
#
#COPY ./composer.json /var/www/html
#COPY ./.env /var/www/html
#COPY ./database /var/www/html/database
#COPY ./storage /var/www/html/storage
#COPY ./bootstrap /var/www/html/bootstrap
#COPY ./artisan /var/www/html/artisan
#COPY ./app /var/www/html/app
#COPY ./routes /var/www/html/routes
#
#

#RUN chmod -R 777 .

#RUN composer install

RUN sed -i 's/DocumentRoot.*$/DocumentRoot \/var\/www\/html\/public/' /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod rewrite