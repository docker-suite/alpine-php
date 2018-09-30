# Php
FROM craftdock/alpine-runit:latest

LABEL maintainer="Hexosse <hexosse@gmail.com>" \
      description="Minimal Alpine image with php7 and runit process supervisor."

ENV PHP_VERSION=7.3

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
    && apk-install --repository http://repos.php.earth/alpine/v3.8 \
        php7.3 \
        php7.3-fpm \
        # # php libs
        # php7.3-apcu \
        # php7.3-bcmath \
        # php7.3-common \
        # php7.3-ctype \
        # php7.3-curl \
        # php7.3-dom \
        # php7.3-fileinfo \
        # php7.3-gd \
        # php7.3-iconv \
        # php7.3-json \
        # php7.3-mbstring \
        # php7.3-memcached \
        # php7.3-mysqli \
        # php7.3-opcache \
        # php7.3-openssl \
        # php7.3-pdo \
        # php7.3-pdo_mysql \
        # php7.3-pgsql \
        # php7.3-pdo_sqlite \
        # php7.3-phar \
        # php7.3-redis \
        # php7.3-session \
        # php7.3-simplexml \
        # php7.3-sqlite3 \
        # php7.3-tokenizer \
        # php7.3-xml \
        # php7.3-xmlreader \
        # php7.3-xmlwriter \
        # php7.3-zip \
        # php7.3-zlib \
        # # Composer
        # composer \
        # php7.3-composer \
    # # symblink php7 to php
    # && ln -s "/etc/php/$PHP_VERSION/" /etc/php7 \
    # # Create default webroot folder
    # && mkdir -p /var/www \
    # && chown www-data:www-data /var/www \
	# Clear apk's cache
	&& apk-cleanup

# Copy scripts
COPY /rootfs /

# Expose php-fpm port
EXPOSE 9000
