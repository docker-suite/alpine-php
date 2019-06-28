#!/usr/bin/env bash

# make sure default log folder exist
mkdir -p /var/log/php7

# Generate php-fpm config file from template
[ -f /etc/entrypoint.d/php-fpm.cnf/setup ] && (chmod +x /etc/entrypoint.d/php-fpm.cnf/setup; /etc/entrypoint.d/php-fpm.cnf/setup)
