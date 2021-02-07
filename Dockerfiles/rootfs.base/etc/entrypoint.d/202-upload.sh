#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# folder
upload_dir="/tmp/php/upload"

# Create folder if necessary
if [[ ! -d "${upload_dir}" ]]; then
    mkdir -p ${upload_dir}
fi

# Update owner
if [[ -n "$USER" ]]; then
    chown -R "$USER" "${upload_dir}" || true
elif [[ -n "$(getent passwd www-data)" ]]; then
    chown -R www-data:www-data "${upload_dir}" || true
fi

# Update permissions
chmod -R 776 "${upload_dir}" || true
