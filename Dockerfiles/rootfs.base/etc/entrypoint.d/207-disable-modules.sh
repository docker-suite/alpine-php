#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu


# Disable PHP Modules
disable_modules() {

    local modules="$1"
    local config_dir="${PHP_INI_DIR}/conf.d"

    if [[ -n "$modules" ]]; then

        NOTICE "Disabling the following PHP modules: ${modules}"

        for module in ${modules//,/ }
        do
            # Find all config files that enable that module
            files="$( grep -Er "^(zend_)?extension.*(=|/)${module}\.so" "${config_dir}" || true )"

            for file in $files; do
                # Get filename
                file="$( echo "${file}" | awk -F':' '{ print $1 }' )"
                # Remove file
                LOG_RUN "rm ${file}"
            done
        done
    fi
}

disable_modules "$(env_get "DISABLE_MODULES")"
