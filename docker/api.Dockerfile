
FROM php:7.4.33-fpm

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
   build-essential \
   zip \
   vim \
   unzip \
   git \
   curl \
   wget \
   less

RUN apt-get install -y --no-install-recommends \
   libjpeg62-turbo-dev \
   libfreetype6-dev \
   locales \
   imagemagick \
   freetds-bin \
   freetds-dev \
   freetds-common \
   libmemcached-dev \
   libxml2-dev \
   libpng-dev \
   libzip-dev \
   libssl-dev \
   libgmp-dev \
   libgraphicsmagick1-dev \
   libxslt-dev \
   libaio1 \
   libmcrypt-dev \
   libreadline-dev \
   build-essential \
   libmagickwand-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
   pdo_mysql \
   gd \
   zip \
   calendar \
   exif \
   gettext \
   pcntl \
   mysqli \
   shmop \
   soap \
   bcmath \
   sockets \
   sysvmsg \
   sysvsem \
   sysvshm \
   xsl \
   opcache

RUN pecl -v install https://pecl.php.net/get/imagick-3.7.0.tgz; \
   docker-php-ext-enable imagick;

# echo "extension=imagick.so" >> /usr/local/etc/php/conf.d/imagick.ini; 

COPY --from=composer:1.10.26 /usr/bin/composer /usr/bin/composer

ADD php /var/www

RUN chown -R www-data:www-data /var/www
