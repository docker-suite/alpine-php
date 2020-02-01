#!/usr/bin/env bash

# shellcheck disable=SC2015

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu

# Variables to be used in www.conf
[ -n "$(env_get "PHP_FPM_PM")" ]                        && env_set "PHP_FPM_PM" "$(env_get "PHP_FPM_PM")" || true
[ -n "$(env_get "PHP_FPM_PM_CATCH_WORKERS_OUTPUT")" ]   && env_set "PHP_FPM_PM_CATCH_WORKERS_OUTPUT" "$(env_get "PHP_FPM_PM_CATCH_WORKERS_OUTPUT")" || true
[ -n "$(env_get "PHP_FPM_PM_CLEAR_ENV")" ]              && env_set "PHP_FPM_PM_CLEAR_ENV" "$(env_get "PHP_FPM_PM_CLEAR_ENV")" || true
[ -n "$(env_get "PHP_FPM_PM_MAX_CHILDREN")" ]           && env_set "PHP_FPM_PM_MAX_CHILDREN" "$(env_get "PHP_FPM_PM_MAX_CHILDREN")" || true
[ -n "$(env_get "PHP_FPM_PM_MAX_REQUEST")" ]            && env_set "PHP_FPM_PM_MAX_REQUEST" "$(env_get "PHP_FPM_PM_MAX_REQUEST")" || true
[ -n "$(env_get "PHP_FPM_PM_MAX_SPARE_SERVERS")" ]      && env_set "PHP_FPM_PM_MAX_SPARE_SERVERS" "$(env_get "PHP_FPM_PM_MAX_SPARE_SERVERS")" || true
[ -n "$(env_get "PHP_FPM_PM_MIN_SPARE_SERVERS")" ]      && env_set "PHP_FPM_PM_MIN_SPARE_SERVERS" "$(env_get "PHP_FPM_PM_MIN_SPARE_SERVERS")" || true
[ -n "$(env_get "PHP_FPM_PM_PROCESS_IDLE_TIMEOUT")" ]   && env_set "PHP_FPM_PM_PROCESS_IDLE_TIMEOUT" "$(env_get "PHP_FPM_PM_PROCESS_IDLE_TIMEOUT")" || true
[ -n "$(env_get "PHP_FPM_PM_START_SERVER")" ]           && env_set "PHP_FPM_PM_START_SERVER" "$(env_get "PHP_FPM_PM_START_SERVER")" || true
