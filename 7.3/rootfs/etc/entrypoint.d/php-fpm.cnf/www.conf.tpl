; http://php.net/manual/en/install.fpm.configuration.php

[www]
user = www-data
group = www-data
; The address on which to accept FastCGI requests.
; Valid syntaxes are: 'ip.add.re.ss:port', 'port', '/path/to/unix/socket'.
;This option is mandatory for each pool.
listen = 9000
listen.owner = www-data
listen.group = www-data

; Ondemand process manager
pm = {{PHP_FPM_PM}}
; The number of child processes to be created when pm is set to 'static' and the
; maximum number of child processes when pm is set to 'dynamic' or 'ondemand'.
; This value sets the limit on the number of simultaneous requests that will be
; served. Equivalent to the ApacheMaxClients directive with mpm_prefork
; and the PHP_FCGI_CHILDREN environment variable in the original PHP FastCGI.
; The below defaults are based on a server without much resources. Don't
; forget to tweak pm.* to fit your needs.
; Note: Used when pm is set to 'static', 'dynamic' or 'ondemand'
; Note: This value is mandatory.
pm.max_children = {{PHP_FPM_PM_MAX_CHILDREN}}
; The number of seconds after which an idle process will be killed.
; Note: Used only when pm is set to 'ondemand'
; Default Value: 10s
pm.process_idle_timeout = {{PHP_FPM_PM_PROCESS_IDLE_TIMEOUT}}
; The number of requests each child process should execute before respawning.
; This can be useful to work around memory leaks in 3rd party libraries. For
; endless request processing specify '0'. Equivalent to PHP_FCGI_MAX_REQUESTS.
; Default Value: 0
pm.max_requests = {{PHP_FPM_PM_MAX_REQUEST}}
pm.start_servers = {{PHP_FPM_PM_START_SERVER}}
pm.min_spare_servers = {{PHP_FPM_PM_MIN_SPARE_SERVERS}}
pm.max_spare_servers = {{PHP_FPM_PM_MAX_SPARE_SERVERS}}

; Make sure the FPM workers can reach the environment variables for configuration
clear_env = {{PHP_FPM_PM_CLEAR_ENV}}

; Redirect worker stdout and stderr into main error log.
; If not set, stdout and stderr will be redirected to /dev/null
; according to FastCGI specs. Default value: no.
catch_workers_output = {{PHP_FPM_PM_CATCH_WORKERS_OUTPUT}}

chdir = /var/www

php_admin_flag[log_errors] = true
;php_admin_value[memory_limit] = 128M
;php_admin_value[upload_max_filesize] = 1G
;php_admin_value[post_max_size] = 1G
