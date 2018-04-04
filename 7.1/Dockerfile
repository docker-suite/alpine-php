# Php repository.
# (This is a workaround when behind a proxy to prevent 'Permission denied' from php.earth repo)
FROM craftdock/alpine-base as php_repository

RUN \
	# Print executed commands
	set -x \
    # Update repository indexes
    && apk-update \
    # Add packages
    && apk-install --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
        wget \
    # Create php repository folder
    && mkdir -p /php.earth/x86_64/ \
    && cd /php.earth/x86_64/ \
    # Copy all packages from  php.earth repo to /php.earth/x86_64
    && wget -r -nd -np -k http://repos.php.earth/alpine/v3.7/x86_64/ \
	# Clear apk's cache
	&& apk-cleanup


# Php
FROM craftdock/alpine-runit:latest

LABEL maintainer="Hexosse <hexosse@gmail.com>" \
      description="Minimal Alpine image with php7 and runit process supervisor."

ENV PHP_VERSION=7.1

# Trust this project public key to trust the php packages.
ADD https://repos.php.earth/alpine/phpearth.rsa.pub /etc/apk/keys/phpearth.rsa.pub

# Copy all packages from
COPY --from=php_repository /php.earth/x86_64 /tmp/php.earth/x86_64

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
    && apk-install --repository /tmp/php.earth \
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
