#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# Folders
custom_src="/etc/php-fpm-custom.d"
conf_dir="$PHP_INI_DIR/php-fpm.d"

# Create source folder if necessary
if [ ! -d "${custom_src}" ]; then
    DEBUG "Creating custom conf files folder: $custom_src"
    mkdir -p $custom_src
fi

# link files
for file in $( find ${custom_src} -name '*.conf' -type f ); do
    DEBUG "Link $(basename "${file}") into: $conf_dir"
    rm -f $conf_dir/$(basename "${file}")
    ln -sf -t $conf_dir ${file}
done
