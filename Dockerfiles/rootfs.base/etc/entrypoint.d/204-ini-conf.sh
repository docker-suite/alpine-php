#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# Define default variables to be used in core.ini
export CORE_REALPATH_CACHE_SIZE=${REALPATH_CACHE_SIZE:='4M'}
export CORE_REALPATH_CACHE_TTL=${REALPATH_CACHE_TTL:='120'}
export CORE_MEMORY_LIMIT=${CORE_MEMORY_LIMIT:='128M'}
export CORE_FILE_UPLOADS=${CORE_FILE_UPLOADS:='1'}
export CORE_UPLOAD_TMP_DIR=${CORE_UPLOAD_TMP_DIR:='/tmp/php/upload'}
export CORE_UPLOAD_MAX_FILESIZE=${CORE_UPLOAD_MAX_FILESIZE:='1G'}
export CORE_POST_MAX_SIZE=${CORE_POST_MAX_SIZE:='1G'}
export CORE_OUTPUT_BUFFERING=${CORE_OUTPUT_BUFFERING:='off'}
export CORE_MAX_INPUT_TIME=${CORE_MAX_INPUT_TIME:='-1'}
export CORE_MAX_EXECUTION_TIME=${CORE_MAX_EXECUTION_TIME:='30'}
export TIMEZONE=${TIMEZONE:='UTC'}

# core.ini
DEBUG "Generating ${PHP_INI_DIR}/conf.d/core.ini"
(export > /tmp/env && set -a && source /tmp/env && templater /etc/entrypoint.d/template/ini/core.ini.tpl > ${PHP_INI_DIR}/conf.d/core.ini)


# Define default variables to be used in opcache.ini
export OPCACHE_ENABLE=${OPCACHE_ENABLE:='1'}
export OPCACHE_ENABLE_CLI=${OPCACHE_ENABLE_CLI:='0'}
export OPCACHE_ENABLE_MEMORY_CONSUMPTION=${OPCACHE_ENABLE_MEMORY_CONSUMPTION:='128'}
export OPCACHE_INTERNED_STRINGS_BUFFER=${OPCACHE_INTERNED_STRINGS_BUFFER:='8'}
export OPCACHE_MAX_ACCELERATED_FILES=${OPCACHE_MAX_ACCELERATED_FILES:='20000'}
export OPCACHE_MAX_WESTED_PERCENTAGE=${OPCACHE_MAX_WESTED_PERCENTAGE:='5'}
export OPCACHE_USE_CWD=${OPCACHE_USE_CWD:='1'}
export OPCACHE_VALIDATE_TIMESTAMPS=${OPCACHE_VALIDATE_TIMESTAMPS:='1'}
export OPCACHE_REVALIDATE_FREQ=${OPCACHE_REVALIDATE_FREQ:='60'}
export OPCACHE_FILE_UPDATE_PROTECTION=${OPCACHE_FILE_UPDATE_PROTECTION:='2'}
export OPCACHE_REVALIDATE_PATH=${OPCACHE_REVALIDATE_PATH:='0'}
export OPCACHE_SAVE_COMMENTS=${OPCACHE_SAVE_COMMENTS:='1'}
export OPCACHE_LOAD_COMMENTS=${OPCACHE_LOAD_COMMENTS:='1'}
export OPCACHE_FAST_SHUTDOWN=${OPCACHE_FAST_SHUTDOWN:='1'}

# opcache.ini
DEBUG "Generating ${PHP_INI_DIR}/conf.d/opcache.ini"
(export > /tmp/env && set -a && source /tmp/env && templater /etc/entrypoint.d/template/ini/opcache.ini.tpl > ${PHP_INI_DIR}/conf.d/opcache.ini)


# Define default variables to be used in apcu.ini
export APCU_ENABLE=${APCU_ENABLE:='1'}
export APCU_SHM_SIZE=${APCU_SHM_SIZE:='128M'}
export APCU_TTL=${APCU_TTL:='7200'}

# apcu.ini
DEBUG "Generating ${PHP_INI_DIR}/conf.d/apcu.ini"
(export > /tmp/env && set -a && source /tmp/env && templater /etc/entrypoint.d/template/ini/apcu.ini.tpl > ${PHP_INI_DIR}/conf.d/apcu.ini)
