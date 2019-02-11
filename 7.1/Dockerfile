# Php
FROM craftdock/alpine-runit:3.8

LABEL maintainer="Hexosse <hexosse@gmail.com>" \
      description="Minimal Alpine image with php7 and runit process supervisor."

ENV PHP_VERSION=7.1

# When using Composer, disable the warning about running commands as root/super user
ENV COMPOSER_ALLOW_SUPERUSER=1

# Trust this project public key to trust the php packages.
ADD https://repos.php.earth/alpine/phpearth.rsa.pub /etc/apk/keys/phpearth.rsa.pub

RUN \
	# Print executed commands
	set -x \
    # Update repository indexes
    && apk-update \
    # Add packages
    && apk-install --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
        ca-certificates \
        libcap \
        memcached \
        openssh-client \
        tar \
        zip \
        wget \
        # https://github.com/docker-library/php/issues/494
        libressl \
    # Add php packages & composer
    && apk-install --repository https://repos.php.earth/alpine/v3.8 \
        php7.1 \
        php7.1-fpm \
        # php libs
        php7.1-apcu \
        php7.1-bcmath \
        php7.1-common \
        php7.1-ctype \
        php7.1-curl \
        php7.1-dom \
        php7.1-fileinfo \
        php7.1-gd \
        php7.1-iconv \
        php7.1-json \
        php7.1-mbstring \
        php7.1-memcached \
        php7.1-mysqli \
        php7.1-opcache \
        php7.1-openssl \
        php7.1-pdo \
        php7.1-pdo_mysql \
        php7.1-pgsql \
        php7.1-pdo_sqlite \
        php7.1-phar \
        php7.1-redis \
        php7.1-session \
        php7.1-simplexml \
        php7.1-sqlite3 \
        php7.1-tokenizer \
        php7.1-xml \
        php7.1-xmlreader \
        php7.1-xmlwriter \
        php7.1-zip \
        php7.1-zlib \
        # Composer
        composer \
        php7.1-composer \
    # symblink php7 to php
    && ln -s "/etc/php/$PHP_VERSION/" /etc/php7 \
    # Create default webroot folder
    && mkdir -p /var/www \
    && chown www-data:www-data /var/www \
	# Clear apk's cache
	&& apk-cleanup

# Copy scripts
COPY /rootfs /

# Expose php-fpm port
EXPOSE 9000
