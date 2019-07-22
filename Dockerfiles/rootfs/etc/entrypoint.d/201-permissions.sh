#!/usr/bin/env bash

# Update permissions
find /var/www/ \( \! -user www-data -o \! -group www-data \) -print0 | xargs -0 -r chown www-data:www-data
