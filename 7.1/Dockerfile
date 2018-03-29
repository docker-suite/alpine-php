FROM craftdock/alpine-runit:latest

LABEL maintainer="Hexosse <hexosse@gmail.com>" \
      description="Minimal Alpine image with php7 and runit process supervisor."


RUN set -x \
    # Ensure www-data user exists
    # 82 is the standard uid/gid for "www-data" in Alpine
    && addgroup -g 82 -S www-data && adduser -u 82 -S -D -G www-data www-data \
    # Create default webroot folder
    && mkdir -p /var/www \
    && chown www-data:www-data /var/www

# trust this project public key to trust the php packages.
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

RUN \
	# Print executed commands
	set -x \
    # Add codecasts.rocks php repository
    && echo "@php http://php.codecasts.rocks/v3.7/php-7.1" >> /etc/apk/repositories \
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
        # https://github.com/docker-library/php/issues/494
        libressl \
    # Add php packages
    && apk-install --update \
        php7@php `# Contains: fileinfo, SimpleXML, tokenizer, xmlwriter` \
        php7-fpm@php \
        # php libs
        php7-apcu@php \
        php7-bcmath@php \
        php7-common@php \
        php7-ctype@php \
        php7-curl@php \
        php7-dom@php \
        php7-gd@php \
        php7-iconv@php \
        php7-json@php \
        php7-mbstring@php \
        php7-memcached@php \
        php7-mysqli@php \
        php7-opcache@php \
        php7-openssl@php \
        php7-pdo@php \
        php7-pdo_mysql@php \
        php7-pgsql@php \
        php7-pdo_sqlite@php \
        php7-phar@php \
        php7-redis@php \
        php7-session@php \
        php7-sqlite3@php \
        php7-xml@php \
        php7-xmlreader@php \
        php7-zip@php \
        php7-zlib@php \
    # symblink php7 to php
    && ln -sf /usr/bin/php7 /usr/bin/php \
    # symlink php-fpm7 to php-fpm
    && ln -sf /usr/sbin/php-fpm7 /usr/sbin/php-fpm \
    # Add composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	# Clear apk's cache
	&& apk-cleanup

# Add composer vendor to the PATH
ENV PATH "/var/www/.composer/vendor/bin:$PATH"

# Copy scripts
COPY /rootfs /

# Expose php-fpm port
EXPOSE 9000
