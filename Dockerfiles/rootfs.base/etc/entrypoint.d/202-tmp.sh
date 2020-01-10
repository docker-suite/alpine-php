#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# folder
upload_dir="/tmp/php/upload"

# Create folder if necessary
if [ ! -d "${upload_dir}" ]; then
    mkdir -p ${upload_dir}
fi

# Update permissions
if [[ -n "$(getent passwd www-data)" ]]; then
    chown www-data:www-data "${upload_dir}"
fi
