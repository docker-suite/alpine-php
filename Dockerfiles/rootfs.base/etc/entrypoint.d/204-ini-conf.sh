#!/usr/bin/env bash

# shellcheck disable=SC1091
# shellcheck disable=SC2086

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# core.ini
DEBUG "Generating ${PHP_INI_DIR}/conf.d/core.ini"
(set -a && source /etc/environment && templater /etc/entrypoint.d/template/ini/core.ini.tpl > ${PHP_INI_DIR}/conf.d/core.ini)

# opcache.ini
DEBUG "Generating ${PHP_INI_DIR}/conf.d/opcache.ini"
(set -a && source /etc/environment && templater /etc/entrypoint.d/template/ini/opcache.ini.tpl > ${PHP_INI_DIR}/conf.d/opcache.ini)

# apcu.ini
DEBUG "Generating ${PHP_INI_DIR}/conf.d/apcu.ini"
(set -a && source /etc/environment && templater /etc/entrypoint.d/template/ini/apcu.ini.tpl > ${PHP_INI_DIR}/conf.d/apcu.ini)
