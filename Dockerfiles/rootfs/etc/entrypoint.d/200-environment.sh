#!/usr/bin/env bash

# Make sure default log folder exist
mkdir -p /var/log/php7
chown www-data:www-data /var/log/php7

# Make sure tmp folder exist
mkdir -p /tmp/php/upload
chown www-data:www-data /tmp/php/upload
