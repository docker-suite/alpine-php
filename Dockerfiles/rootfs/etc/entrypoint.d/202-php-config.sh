#!/usr/bin/env bash

# Generate php config file from template
[ -f /etc/entrypoint.d/php.ini.cnf/setup ] && (chmod +x /etc/entrypoint.d/php.ini.cnf/setup; /etc/entrypoint.d/php.ini.cnf/setup)

# Generate php-fpm config file from template
[ -f /etc/entrypoint.d/php-fpm.cnf/setup ] && (chmod +x /etc/entrypoint.d/php-fpm.cnf/setup; /etc/entrypoint.d/php-fpm.cnf/setup)
