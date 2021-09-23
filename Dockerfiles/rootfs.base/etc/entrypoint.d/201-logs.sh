#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# Log folder
log_dir="/var/log/php/${PHP_VERSION}"
log_access="access.log"
log_error="error.log"

# Create log folder if necessary
if [[ ! -d "${log_dir}" ]]; then
    DEBUG "Creating php${PHP_VERSION} log folder: $log_dir"
    mkdir -p $log_dir
fi

# Create access log file
if [[ ! -f "${log_dir}/${log_access}" ]]; then
    DEBUG "Creating php${PHP_VERSION} access log file: ${log_dir}/${log_access}"
    touch ${log_dir}/${log_access}
fi

# Create error log file
if [[ ! -f "${log_dir}/${log_error}" ]]; then
    DEBUG "Creating php${PHP_VERSION} error log file: ${log_dir}/${log_error}"
    touch ${log_dir}/${log_error}
fi

# Update owner
if [[ -n "${USER}" ]]; then
    chown -R "${USER}" "${log_dir}" || true
elif [[ -n "$(getent passwd www-data)" ]]; then
    chown -R www-data:www-data "${log_dir}" || true
fi

# Update permissions
chmod -R 776 "${log_dir}" || true
