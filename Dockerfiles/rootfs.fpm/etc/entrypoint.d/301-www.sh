#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# folder
www_dir="/var/www"

# Create folder if necessary
if [ ! -d "$www_dir" ]; then
    DEBUG "Creating www folder: $www_dir"
    mkdir -p $www_dir
fi
