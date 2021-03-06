#!/bin/bash

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    libbz2-dev \
    libcurl4-gnutls-dev \
    libfreetype6-dev \
    libgmp-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libpq-dev \
    libssl-dev \
    libxml2-dev \
    libzip-dev \
    libmemcached-dev \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        bz2 \
        curl \
        exif \
        gd \
        gmp \
        imap \
        intl \
        json \
        mbstring \
        mcrypt \
        opcache \
        pcntl \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        soap \
        xml \
        xmlrpc \
        zip

# MONGO, xdebug and other extensions
pecl channel-update pecl.php.net \
  && pecl install redis mongodb xdebug-2.5.5 apcu memcached \
  && docker-php-ext-enable redis mongodb xdebug apcu memcached

echo "memory_limit=512M" > /usr/local/etc/php/conf.d/zz-conf.ini
