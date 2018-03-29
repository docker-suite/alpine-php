#!/bin/sh

# Generate php config file from template
[ -f /etc/entrypoint.d/php.ini.cnf/setup ] && (chmod +x /etc/entrypoint.d/php.ini.cnf/setup; /etc/entrypoint.d/php.ini.cnf/setup)
