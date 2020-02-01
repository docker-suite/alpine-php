; OPcache On/Off switch. When set to Off, code is not optimized.
; (default "1")
opcache.enable = {{OPCACHE_ENABLE=1}}

; Enables the OPcache for the CLI version of PHP.
; It's mostly for testing and debugging.
; (default "0")
opcache.enable_cli = {{OPCACHE_ENABLE_CLI=1}}

; The OPcache shared memory storage size.
; The amount of memory for storing precompiled PHP code in Mbytes.
; (default "64")
opcache.memory_consumption = {{OPCACHE_ENABLE_MEMORY_CONSUMPTION=128}}

; The amount of memory for interned strings in Mbytes.
; (default "4")
opcache.interned_strings_buffer = {{OPCACHE_INTERNED_STRINGS_BUFFER=8}}

; The maximum number of keys (scripts) in the OPcache hash table.
; The number is actually the first one in the following set of prime numbers
; that is bigger than the one supplied: { 223, 463, 983, 1979, 3907, 7963,
; 16229, 32531, 65407, 130987, 262237, 524521, 1048793 }. Only numbers between
; 200 and 1000000 are allowed.
; (default "2000")
opcache.max_accelerated_files = {{OPCACHE_MAX_ACCELERATED_FILES=20000}}

; The maximum percentage of "wasted" memory until a restart is scheduled.
; (default "5")
opcache.max_wasted_percentage = {{OPCACHE_MAX_WESTED_PERCENTAGE=5}}

; When this directive is enabled, the OPcache appends the current working
; directory to the script key, thus eliminating possible collisions between
; files with the same name (basename). Disabling the directive improves
; performance, but may break existing applications.
; (default "1")
opcache.use_cwd = {{OPCACHE_USE_CWD=1}}

; When disabled, you must reset the OPcache manually or restart the webserver
; for changes to the filesystem to take effect. The frequency of the check is
; controlled by the directive "opcache.revalidate_freq".
; (default "1")
opcache.validate_timestamps = {{OPCACHE_VALIDATE_TIMESTAMPS=1}}

; How often (in seconds) to check file timestamps for changes to the shared
; memory storage allocation. ("1" means validate once per second, but only once
; per request. "0" means always validate)
; (default "2")
opcache.revalidate_freq = {{OPCACHE_REVALIDATE_FREQ=2}}

; Prevents caching files that are less than this number of seconds old.
; It protects from caching of incompletely updated files. In case all file
; updates on your site are atomic, you may increase performance setting it
; to "0".
; (default "2")
opcache.file_update_protection = {{OPCACHE_FILE_UPDATE_PROTECTION=2}}

; Enables or disables file search in include_path optimization.
; If the file search is disabled and a cached file is found that uses the same
; include_path, the file is not searched again. Thus, if a file with the same
; name appears somewhere else in include_path, it won't be found. Enable this
; directive if this optimization has an effect on your applications. The
; default for this directive is disabled, which means that optimization is
; active.
; (default "0")
opcache.revalidate_path = {{OPCACHE_REVALIDATE_PATH=0}}

; If disabled, all PHPDoc comments are dropped from the code to reduce the size
; of the optimized code. Disabling "Doc Comments" may break some existing
; applications and frameworks (e.g. Doctrine, ZF2, PHPUnit)
; (default "1")
opcache.save_comments = {{OPCACHE_SAVE_COMMENTS=1}}

; If disabled, PHPDoc comments are not loaded from SHM, so "Doc Comments" may
; be always stored (save_comments=1), but not loaded by applications that don't
; need them anyway.
; (default "1")
opcache.load_comments = {{OPCACHE_LOAD_COMMENTS=1}}

; If enabled, a fast shutdown sequence is used for the accelerated code. The
; fast shutdown sequence doesn't free each allocated block, but lets the Zend
; Engine Memory Manager do the work.
; (default "0")
opcache.fast_shutdown = {{OPCACHE_FAST_SHUTDOWN=1}}
