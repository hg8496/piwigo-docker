FROM php:5-apache

RUN apt-get update && \
    apt-get install -y libfreetype6-dev \
                       libjpeg62-turbo-dev \
                       libpng12-dev \
                       imagemagick \
                       wget \
                       unzip \
                       mediainfo \
                       libav-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd mysql && \
    wget -q -O piwigo.zip http://piwigo.org/download/dlcounter.php?code=latest && \
    unzip piwigo.zip && \
    mv piwigo/* /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    rm -r piwigo*

VOLUME ["/var/www/html/galleries", "/var/www/html/themes", "/var/www/html/plugins", "/var/www/html/local"]

