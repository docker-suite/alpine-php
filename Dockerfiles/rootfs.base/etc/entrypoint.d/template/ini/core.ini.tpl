; Performance Tuning
; https://www.php.net/manual/en/ini.core.php
;
; Determines the size of the realpath cache to be used by PHP.
; This value should be increased on systems where PHP opens many
; files, to reflect the quantity of the file operations performed.
;
; The size represents the total number of bytes in the path strings
; stored, plus the size of the data associated with the cache entry.
; This means that in order to store longer paths in the cache, the
; cache size must be larger. This value does not directly control the
; number of distinct paths that can be cached.
;
;The size required for the cache entry data is system dependen
realpath_cache_size = {{CORE_REALPATH_CACHE_SIZE=4M}}

; Duration of time (in seconds) for which to cache realpath information
; for a given file or directory. For systems with rarely changing files,
; consider increasing the value.
realpath_cache_ttl = {{CORE_REALPATH_CACHE_TTL=120}}


; Resource Limits
; https://www.php.net/manual/en/ini.core.php#ini.sect.resource-limits
;
; This sets the maximum amount of memory in bytes that a script is allowed
; to allocate. This helps prevent poorly written scripts for eating up all
; available memory on a server. Note that to have no memory limit, set
; this directive to -1.
memory_limit = {{CORE_MEMORY_LIMIT=128M}}


; File Uploads
; https://www.php.net/manual/en/ini.core.php#ini.sect.file-uploads
;
; Whether or not to allow HTTP file uploads. See also the upload_max_filesize,
; upload_tmp_dir, and post_max_size directives.
file_uploads = {{CORE_FILE_UPLOADS=1}}

; The temporary directory used for storing files when doing file upload.
; Must be writable by whatever user PHP is running as. If not specified
; PHP will use the system's default.
;
; If the directory specified here is not writable, PHP falls back to
; the system default temporary directory. If open_basedir is on, then
; the system default directory must be allowed for an upload to succeed.
upload_tmp_dir = {{CORE_UPLOAD_TMP_DIR=/tmp/php/upload}}

; The maximum size of an uploaded file.
;
; When an integer is used, the value is measured in bytes. Shorthand
; notation, as described in this FAQ, may also be used.
upload_max_filesize = {{CORE_UPLOAD_MAX_FILESIZE=1G}}


; Data Handling
; https://www.php.net/manual/en/ini.core.php#ini.sect.data-handling
;
; Sets max size of post data allowed. This setting also affects file
; upload. To upload large files, this value must be larger than
; upload_max_filesize.
post_max_size = {{CORE_POST_MAX_SIZE=1G}}


; Runtime Configuration
; https://www.php.net/manual/en/outcontrol.configuration.php
; https://www.php.net/manual/en/info.configuration.php#info.configuration
;
; You can enable output buffering for all files by setting
; this directive to 'On'. If you wish to limit the size of
; the buffer to a certain size - you can use a maximum number
; of bytes instead of 'On', as a value for this directive
; (e.g., output_buffering=4096). This directive is always Off in PHP-CLI.
output_buffering = {{CORE_OUTPUT_BUFFERING=off}}

; This sets the maximum time in seconds a script is allowed to parse input
; data, like POST and GET. Timing begins at the moment PHP is invoked at
; the server and ends when execution begins. The default setting is -1,
; which means that max_execution_time is used instead. Set to 0 to allow
; unlimited time.
max_input_time = {{CORE_MAX_INPUT_TIME=-1}}

; This sets the maximum time in seconds a script is allowed to run before
; it is terminated by the parser. This helps prevent poorly written scripts
; from tying up the server. The default setting is 30.
max_execution_time = {{CORE_MAX_EXECUTION_TIME=30}}


;
date.timezone = {{TIMEZONE=UTC}}
