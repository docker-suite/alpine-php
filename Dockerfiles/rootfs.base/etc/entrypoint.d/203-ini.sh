#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# folder
conf_dir="$PHP_INI_DIR/conf.d"

# Create folder if necessary
if [[ ! -d "$conf_dir" ]]; then
    DEBUG "Creating conf.d folder: $conf_dir"
    mkdir -p $conf_dir
fi
