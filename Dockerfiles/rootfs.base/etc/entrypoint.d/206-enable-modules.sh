#!/usr/bin/env bash

# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
set -eu


# Enable PHP Modules
enable_modules() {

    local modules="$1"
    local config_dir="${PHP_INI_DIR}/conf.d"
	local modules_path="$( php -i | grep ^extension_dir | awk -F '=>' '{print $2}' | xargs )"

    if [[ -n "$modules" ]]; then

        NOTICE "Enabling the following PHP modules: ${modules}"

        for module in ${modules//,/ }
        do
			# Does the module exist?
			if [[ -f "${modules_path}/${module}.so" ]]; then
				# Exceptions to load speficially
				if [[ "${module}" = "ioncube" ]]; then
                    LOG_RUN "echo 'zend_extension=${modules_path}/ioncube.so' > '${config_dir}/docker-ext-php-ext-ioncube.ini'"
				# Generic Load
				else
                    LOG_RUN "docker-php-ext-enable ${module} || true"
				fi
			else
				WARNING "Enabling PHP Module: '${module}' does not exist"
			fi
        done
    fi
}

enable_modules "$(env_get "ENABLE_MODULES")"
