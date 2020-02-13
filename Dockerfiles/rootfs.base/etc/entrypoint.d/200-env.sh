#!/usr/bin/env bash

# shellcheck disable=SC2015

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# Variables to be used in core.ini
[ -n "$(env_get "CORE_REALPATH_CACHE_SIZE")" ]          && env_set "CORE_REALPATH_CACHE_SIZE" "$(env_get "CORE_REALPATH_CACHE_SIZE")" || true
[ -n "$(env_get "CORE_REALPATH_CACHE_TTL")" ]           && env_set "CORE_REALPATH_CACHE_TTL" "$(env_get "CORE_REALPATH_CACHE_TTL")" || true
[ -n "$(env_get "CORE_MEMORY_LIMIT")" ]                 && env_set "CORE_MEMORY_LIMIT" "$(env_get "CORE_MEMORY_LIMIT")" || true
[ -n "$(env_get "CORE_FILE_UPLOADS")" ]                 && env_set "CORE_FILE_UPLOADS" "$(env_get "CORE_FILE_UPLOADS")" || true
[ -n "$(env_get "CORE_UPLOAD_TMP_DIR")" ]               && env_set "CORE_UPLOAD_TMP_DIR" "$(env_get "CORE_UPLOAD_TMP_DIR")" || true
[ -n "$(env_get "CORE_UPLOAD_MAX_FILESIZE")" ]          && env_set "CORE_UPLOAD_MAX_FILESIZE" "$(env_get "CORE_UPLOAD_MAX_FILESIZE")" || true
[ -n "$(env_get "CORE_POST_MAX_SIZE")" ]                && env_set "CORE_POST_MAX_SIZE" "$(env_get "CORE_POST_MAX_SIZE")" || true
[ -n "$(env_get "CORE_OUTPUT_BUFFERING")" ]             && env_set "CORE_OUTPUT_BUFFERING" "$(env_get "CORE_OUTPUT_BUFFERING")" || true
[ -n "$(env_get "CORE_MAX_INPUT_TIME")" ]               && env_set "CORE_MAX_INPUT_TIME" "$(env_get "CORE_MAX_INPUT_TIME")" || true
[ -n "$(env_get "CORE_MAX_EXECUTION_TIME")" ]           && env_set "CORE_MAX_EXECUTION_TIME" "$(env_get "CORE_MAX_EXECUTION_TIME")" || true
[ -n "$(env_get "TIMEZONE")" ]                          && env_set "TIMEZONE" "$(env_get "TIMEZONE")" || true

# Variables to be used in opcache.ini
[ -n "$(env_get "OPCACHE_ENABLE")" ]                    && env_set "OPCACHE_ENABLE" "$(env_get "OPCACHE_ENABLE")" || true
[ -n "$(env_get "OPCACHE_ENABLE_CLI")" ]                && env_set "OPCACHE_ENABLE_CLI" "$(env_get "OPCACHE_ENABLE_CLI")" || true
[ -n "$(env_get "OPCACHE_ENABLE_MEMORY_CONSUMPTION")" ] && env_set "OPCACHE_ENABLE_MEMORY_CONSUMPTION" "$(env_get "OPCACHE_ENABLE_MEMORY_CONSUMPTION")" || true
[ -n "$(env_get "OPCACHE_INTERNED_STRINGS_BUFFER")" ]   && env_set "OPCACHE_INTERNED_STRINGS_BUFFER" "$(env_get "OPCACHE_INTERNED_STRINGS_BUFFER")" || true
[ -n "$(env_get "OPCACHE_MAX_ACCELERATED_FILES")" ]     && env_set "OPCACHE_MAX_ACCELERATED_FILES" "$(env_get "OPCACHE_MAX_ACCELERATED_FILES")" || true
[ -n "$(env_get "OPCACHE_MAX_WESTED_PERCENTAGE")" ]     && env_set "OPCACHE_MAX_WESTED_PERCENTAGE" "$(env_get "OPCACHE_MAX_WESTED_PERCENTAGE")" || true
[ -n "$(env_get "OPCACHE_USE_CWD")" ]                   && env_set "OPCACHE_USE_CWD" "$(env_get "OPCACHE_USE_CWD")" || true
[ -n "$(env_get "OPCACHE_VALIDATE_TIMESTAMPS")" ]       && env_set "OPCACHE_VALIDATE_TIMESTAMPS" "$(env_get "OPCACHE_VALIDATE_TIMESTAMPS")" || true
[ -n "$(env_get "OPCACHE_REVALIDATE_FREQ")" ]           && env_set "OPCACHE_REVALIDATE_FREQ" "$(env_get "OPCACHE_REVALIDATE_FREQ")" || true
[ -n "$(env_get "OPCACHE_FILE_UPDATE_PROTECTION")" ]    && env_set "OPCACHE_FILE_UPDATE_PROTECTION" "$(env_get "OPCACHE_FILE_UPDATE_PROTECTION")" || true
[ -n "$(env_get "OPCACHE_REVALIDATE_PATH")" ]           && env_set "OPCACHE_REVALIDATE_PATH" "$(env_get "OPCACHE_REVALIDATE_PATH")" || true
[ -n "$(env_get "OPCACHE_SAVE_COMMENTS")" ]             && env_set "OPCACHE_SAVE_COMMENTS" "$(env_get "OPCACHE_SAVE_COMMENTS")" || true
[ -n "$(env_get "OPCACHE_LOAD_COMMENTS")" ]             && env_set "OPCACHE_LOAD_COMMENTS" "$(env_get "OPCACHE_LOAD_COMMENTS")" || true
[ -n "$(env_get "OPCACHE_FAST_SHUTDOWN")" ]             && env_set "OPCACHE_FAST_SHUTDOWN" "$(env_get "OPCACHE_FAST_SHUTDOWN")" || true

# Variables to be used in apcu.ini
[ -n "$(env_get "APCU_ENABLE")" ]                       && env_set "APCU_ENABLE" "$(env_get "APCU_ENABLE")" || true
[ -n "$(env_get "APCU_SHM_SEGMENTS")" ]                 && env_set "APCU_SHM_SEGMENTS" "$(env_get "APCU_SHM_SEGMENTS")" || true
[ -n "$(env_get "APCU_SHM_SIZE")" ]                     && env_set "APCU_SHM_SIZE" "$(env_get "APCU_SHM_SIZE")" || true
[ -n "$(env_get "APCU_NUM_FILE_HINT")" ]                && env_set "APCU_NUM_FILE_HINT" "$(env_get "APCU_NUM_FILE_HINT")" || true
[ -n "$(env_get "APCU_USER_ENTRIES_HINT")" ]            && env_set "APCU_USER_ENTRIES_HINT" "$(env_get "APCU_USER_ENTRIES_HINT")" || true
[ -n "$(env_get "APCU_TTL")" ]                          && env_set "APCU_TTL" "$(env_get "APCU_TTL")" || true
[ -n "$(env_get "APCU_USER_TTL")" ]                     && env_set "APCU_USER_TTL" "$(env_get "APCU_USER_TTL")" || true
[ -n "$(env_get "APCU_GC_TTL")" ]                       && env_set "APCU_GC_TTL" "$(env_get "APCU_GC_TTL")" || true
[ -n "$(env_get "APCU_MAX_FILE_SIZE")" ]                && env_set "APCU_MAX_FILE_SIZE" "$(env_get "APCU_MAX_FILE_SIZE")" || true
[ -n "$(env_get "APCU_STAT")" ]                         && env_set "APCU_STAT" "$(env_get "APCU_STAT")" || true
