# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) alpine-php
[![Build Status](http://jenkins.hexocube.fr/job/docker-suite/job/alpine-php/badge/icon?color=green&style=flat-square)](http://jenkins.hexocube.fr/job/docker-suite/job/alpine-php/)
![Docker Pulls](https://img.shields.io/docker/pulls/dsuite/alpine-php.svg?style=flat-square)
![Docker Stars](https://img.shields.io/docker/stars/dsuite/alpine-php.svg?style=flat-square)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dsuite/alpine-php/latest.svg?style=flat-square)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/dsuite/alpine-php/latest.svg?style=flat-square)
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![dockeri.co](https://dockeri.co/image/dsuite/alpine-php)](https://hub.docker.com/r/dsuite/alpine-php)

A php docker image built on top of [docker-suite (dsuite)][docker-suite] [dsuite/alpine-base][alpine-base].


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Available Images
<table>
  <thead>
    <tr>
      <th>Type</th>
      <th>Docker Image</th>
    </tr>
  </thead>
  <tbody>
  <tr>
    <td rowspan="4"><strong>php</strong></td>
    <td><code>dsuite/alpine-php:7.1</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.2</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.3</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.4</code></td>
  </tr>
  <tr>
    <td rowspan="4"><strong>php-dev</strong></td>
    <td><code>dsuite/alpine-php:7.1-dev</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.2-dev</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.3-dev</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.4-dev</code></td>
  </tr>
  <tr>
    <td rowspan="4"><strong>fpm</strong></td>
    <td><code>dsuite/alpine-php:7.1-fpm</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.2-fpm</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.3-fpm</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.4-fpm</code></td>
  </tr>
  <tr>
    <td rowspan="4"><strong>fpm-dev</strong></td>
    <td><code>dsuite/alpine-php:7.1-fpm-dev</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.2-fpm-dev</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.3-fpm-dev</code></td>
  </tr>
  <tr>
    <td><code>dsuite/alpine-php:7.4-fpm-dev</code></td>
  </tr>
  </tbody>
</table>


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Environment variables

A full list of [dsuite/alpine-base environment variables][alpine-base-readme-variables] are described in the [alpine-base Readme][alpine-base-readme].

<table>
 <thead>
  <tr>
   <th>Variable</th>
   <th>Default</th>
   <th>Description</th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td width="30%"><code>TIMEZONE</code></td>
   <td><code>UTC</code></td>
   <td>Set docker OS timezone as well as PHP timezone</td>
  </tr>
  <tr>
   <td><code>ENABLE_MODULES</code></td>
   <td><code>''</code></td>
   <td>Comma separated list of PHP modules to enable</td>
  </tr>
  <tr>
   <td><code>DISABLE_MODULES</code></td>
   <td><code>''</code></td>
   <td>Comma separated list of PHP modules to disable</td>
  </tr>
  <tr>
   <td colspan="3"></td>
  </tr>
  <tr>
   <td><code>CORE_REALPATH_CACHE_SIZE</code></td>
   <td><code>4M</code></td>
   <td rowspan="10"></td>
  </tr>
  <tr>
   <td><code>CORE_REALPATH_CACHE_TTL</code></td>
   <td><code>120</code></td>
  </tr>
  <tr>
   <td><code>CORE_MEMORY_LIMIT</code></td>
   <td><code>128M</code></td>
  </tr>
  <tr>
   <td><code>CORE_FILE_UPLOADS</code></td>
   <td><code>1</code></td>
  </tr>
  <tr>
   <td><code>CORE_UPLOAD_TMP_DIR</code></td>
   <td><code>/tmp/php/upload</code></td>
  </tr>
  <tr>
   <td><code>CORE_UPLOAD_MAX_FILESIZE</code></td>
   <td><code>1G</code></td>
  </tr>
  <tr>
   <td><code>CORE_POST_MAX_SIZE</code></td>
   <td><code>1G</code></td>
  </tr>
  <tr>
   <td><code>CORE_OUTPUT_BUFFERING</code></td>
   <td><code>0</code></td>
  </tr>
  <tr>
   <td><code>CORE_MAX_INPUT_TIME</code></td>
   <td><code>-1</code></td>
  </tr>
  <tr>
   <td><code>CORE_MAX_EXECUTION_TIME</code></td>
   <td><code>30</code></td>
  </tr>
  <tr>
   <td><code>CORE_HTML_ERRORS</code></td>
   <td><code>Off</code></td>
  </tr>
  <tr>
   <td><code>CORE_DISPLAY_ERRORS</code></td>
   <td><code>Off</code></td>
  </tr>
  <tr>
   <td><code>CORE_ERROR_REPORTING</code></td>
   <td><code>E_ALL</code></td>
  </tr>
  <tr>
   <td colspan="3"></td>
  </tr>
  <tr>
   <td><code>OPCACHE_ENABLE</code></td>
   <td><code>1</code></td>
   <td rowspan="14"></td>
  </tr>
  <tr>
   <td><code>OPCACHE_ENABLE_CLI</code></td>
   <td><code>0</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_ENABLE_MEMORY_CONSUMPTION</code></td>
   <td><code>128</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_INTERNED_STRINGS_BUFFER</code></td>
   <td><code>8</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_MAX_ACCELERATED_FILES</code></td>
   <td><code>20000</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_MAX_WESTED_PERCENTAGE</code></td>
   <td><code>5</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_USE_CWD</code></td>
   <td><code>1</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_VALIDATE_TIMESTAMPS</code></td>
   <td><code>1</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_REVALIDATE_FREQ</code></td>
   <td><code>60</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_FILE_UPDATE_PROTECTION</code></td>
   <td><code>2</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_REVALIDATE_PATH</code></td>
   <td><code>0</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_SAVE_COMMENTS</code></td>
   <td><code>1</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_LOAD_COMMENTS</code></td>
   <td><code>1</code></td>
  </tr>
  <tr>
   <td><code>OPCACHE_FAST_SHUTDOWN</code></td>
   <td><code>1</code></td>
  </tr>
  <tr>
   <td colspan="3"></td>
  </tr>
  <tr>
   <td><code>APCU_ENABLE</code></td>
   <td><code>1</code></td>
   <td rowspan="3"></td>
  </tr>
  <tr>
   <td><code>APCU_SHM_SEGMENTS</code></td>
   <td><code>1</code></td>
  </tr>
  <tr>
   <td><code>APCU_SHM_SIZE</code></td>
   <td><code>128M</code></td>
  </tr>
  <tr>
   <td><code>APCU_NUM_FILE_HINT</code></td>
   <td><code>7000</code></td>
  </tr>
  <tr>
   <td><code>APCU_USER_ENTRIES_HINT</code></td>
   <td><code>4096</code></td>
  </tr>
  <tr>
   <td><code>APCU_TTL</code></td>
   <td><code>3600</code></td>
  </tr>
  <tr>
   <td><code>APCU_USER_TTL</code></td>
   <td><code>7200</code></td>
  </tr>
  <tr>
   <td><code>APCU_GC_TTL</code></td>
   <td><code>3600</code></td>
  </tr>
  <tr>
   <td><code>APCU_MAX_FILE_SIZE</code></td>
   <td><code>1M</code></td>
  </tr>
  <tr>
   <td><code>APCU_STAT</code></td>
   <td><code>1</code></td>
  </tr>
  <tr>
   <td colspan="3"></td>
  </tr>
  <tr>
   <td><code>PHP_FPM_PM</code></td>
   <td><code>ondemand</code></td>
   <td rowspan="9"></td>
  </tr>
  <tr>
   <td><code>PHP_FPM_PM_MAX_CHILDREN</code></td>
   <td><code>9</code></td>
  </tr>
  <tr>
   <td><code>PHP_FPM_PM_PROCESS_IDLE_TIMEOUT</code></td>
   <td><code>10s</code></td>
  </tr>
  </tr>
  <tr>
   <td><code>PHP_FPM_PM_MAX_REQUEST</code></td>
   <td><code>200</code></td>
  </tr>
  <tr>
   <td><code>PHP_FPM_PM_START_SERVER</code></td>
   <td><code>2</code></td>
  </tr>
  <tr>
   <td><code>PHP_FPM_PM_MIN_SPARE_SERVERS</code></td>
   <td><code>1</code></td>
  </tr>
  <tr>
   <td><code>PHP_FPM_PM_MAX_SPARE_SERVERS</code></td>
   <td><code>3</code></td>
  </tr>
  <tr>
   <td><code>PHP_FPM_PM_CLEAR_ENV</code></td>
   <td><code>no</code></td>
  </tr>
  <tr>
   <td><code>PHP_FPM_PM_CATCH_WORKERS_OUTPUT</code></td>
   <td><code>yes</code></td>
  </tr>
 </tbody>
</table>


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Volumes

<table>
 <thead>
  <tr>
   <th>Volume</th>
   <th>Description</th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td width="30%"><code>/etc/php-custom.d</code></td>
   <td>Mount this directory into your host computer and add custom <code>*.ini</code> files in order to alter php behaviour</td>
  </tr>
  <tr>
   <td><code>/etc/php-fpm-custom.d</code></td>
   <td>Mount this directory into your host computer and add custom PHP-FPM <code>*.conf</code> files in order to alter PHP-FPM behaviour</td>
  </tr>
  <tr>
   <td><code>/var/log/php</code></td>
   <td>Log files will be available under this directory</td>
  </tr>
 </tbody>
</table>


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Ports

<table>
 <thead>
  <tr>
   <th>Port</th>
   <th>Description</th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td><code>9000</code></td>
   <td>PHP-FPM listening port</td>
  </tr>
 </tbody>
</table>


# How to use this image

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Use custom php ini file

```bash
docker run -v ./my_conf.ini:/etc/php-custom.d/my_conf.ini:ro -d dsuite/alpine-php:7.4
```

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Use your own php-fpm.conf file

```bash
docker run -v ./php-fpm.conf:/etc/php/7.X/php-fpm.conf:ro -d dsuite/alpine-php:7.4
```

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Use custom php-fpm config file

```bash
docker run -v ./my_pool.conf:/etc/php-fpm-custom.d/my_pool.conf:ro -d dsuite/alpine-php:7.4
```


[base]: http://smarden.org/base/
[docker-suite]: https://github.com/docker-suite/
[alpine-base]: https://github.com/docker-suite/alpine-base/
[alpine-base]: https://github.com/docker-suite/alpine-base/
[alpine-base-readme]: https://github.com/docker-suite/alpine-base/blob/master/Readme.md/
[alpine-base-readme-variables]: https://github.com/docker-suite/alpine-base/blob/master/Readme.md#-environment-variables
