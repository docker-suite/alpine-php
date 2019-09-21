# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) alpine-php7
[![Build Status](http://jenkins.hexocube.fr/job/docker-suite/job/alpine-php7/badge/icon?color=green&style=flat-square)](http://jenkins.hexocube.fr/job/docker-suite/job/alpine-php7/)
![Docker Pulls](https://img.shields.io/docker/pulls/dsuite/alpine-php7.svg?style=flat-square)
![Docker Stars](https://img.shields.io/docker/stars/dsuite/alpine-php7.svg?style=flat-square)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dsuite/alpine-php7/latest.svg?style=flat-square)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/dsuite/alpine-php7/latest.svg?style=flat-square)
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat-square)](https://opensource.org/licenses/MIT)

A php7 docker image built on top of the latest [Alpine runit][alpine-runit] container with [runit][runit] process supervisor.


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Ports
- 9000

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Available environment variables

Name                                | Default value
------------------------------------|-------------------------------------------------
PHP_FPM_PM                          | `ondemand`
PHP_FPM_PM_MAX_CHILDREN             | `9`
PHP_FPM_PM_PROCESS_IDLE_TIMEOUT     | `10s`
PHP_FPM_PM_MAX_REQUEST              | `200`
PHP_FPM_PM_START_SERVER             | `2`
PHP_FPM_PM_MIN_SPARE_SERVERS        | `1`
PHP_FPM_PM_MAX_SPARE_SERVERS        | `3`
PHP_FPM_PM_CLEAR_ENV                | `no`
PHP_FPM_PM_CATCH_WORKERS_OUTPUT     | `yes`
CORE_REALPATH_CACHE_SIZE            | `4M`
CORE_REALPATH_CACHE_TTL             | `120`
CORE_MEMORY_LIMIT                   | `128M`
CORE_FILE_UPLOADS                   | `1`
CORE_UPLOAD_TMP_DIR                 | /tmp/php/upload
CORE_UPLOAD_MAX_FILESIZE            | `1G`
CORE_POST_MAX_SIZE                  | `1G`
CORE_OUTPUT_BUFFERING               | `0`
CORE_MAX_INPUT_TIME                 | `-1`
CORE_MAX_EXECUTION_TIME             | `30`
TIMEZONE                            | `UTC`
OPCACHE_ENABLE                      | `1`
OPCACHE_ENABLE_CLI                  | `0`
OPCACHE_ENABLE_MEMORY_CONSUMPTION   | `128`
OPCACHE_INTERNED_STRINGS_BUFFER     | `8`
OPCACHE_MAX_ACCELERATED_FILES       | `20000`
OPCACHE_MAX_WESTED_PERCENTAGE       | `5`
OPCACHE_USE_CWD                     | `1`
OPCACHE_VALIDATE_TIMESTAMPS         | `1`
OPCACHE_REVALIDATE_FREQ             | `60`
OPCACHE_FILE_UPDATE_PROTECTION      | `2`
OPCACHE_REVALIDATE_PATH             | `0`
OPCACHE_SAVE_COMMENTS               | `1`
OPCACHE_LOAD_COMMENTS               | `1`
OPCACHE_FAST_SHUTDOWN               | `1`
APCU_ENABLE                         | `1`
APCU_SHM_SIZE                       | `128M`
APCU_TTL                            | `7200`


[alpine-runit]: https://github.com/docker-suite/alpine-runit/
[runit]: http://smarden.org/runit/
