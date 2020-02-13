; Enable/Disable PHP APC
apc.enabled = {{APCU_ENABLE=1}}

; APC Number of Shared Memory Segments
; APC is configured with mmap it only uses 1 shm_segment,
; then you could remove apc.shm_segments or use following
apc.shm_segments={{APCU_SHM_SEGMENTS=1}}

; APC Size of Each Shared Memory Segments
; If you use just one memory segment, then set this value to total
; memory what you want to use. This value depends on available RAM
; size and required cache size. So first this could be 128 Mb and
; when you see real usage then it’s easy to increase on decrease
; this limit.
apc.shm_size = {{APCU_SHM_SIZE=128M}}

;
;
apc.num_files_hint={{APCU_NUM_FILE_HINT=7000}}

;
;
apc.user_entries_hint={{APCU_USER_ENTRIES_HINT=4096}}

; APC Cache Entries Time to Live (ttl)
; PHP file cache
apc.ttl = {{APCU_TTL=3600}}

; APC Cache Entries Time to Live (ttl)
; User cache
apc.user_ttl={{APCU_USER_TTL=7200}}

; APC Cache Entries Time to Live (ttl)
; Garbage collection
apc.gc_ttl={{APCU_GC_TTL=3600}}

; Max File Size on APC Cache
; Normally it’s wise cache only "small" files and this value is
; good to set example to default 1 Mb.
apc.max_file_size={{APCU_MAX_FILE_SIZE=1M}}

; APC Stat (Check) the script if it has been modified
; This apc.stat could be powerful and dangerous option.
; Default value on, which force APC to stat (check) the script on
; each request to determine if it has been modified. In some cases,
; if you have files that are rarely modified, or if the project
; contains "too many" included files (per page load), such as a
; monstrous e-commerce project, then it’s very good to disable apc.stat.
; If you disable apc.stat then cache should be cleared every time you
; modified files.
apc.stat={{APCU_STAT=1}}
