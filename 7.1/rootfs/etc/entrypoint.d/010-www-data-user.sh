#!/bin/sh

# Ensure www-data user exists
# 82 is the standard uid/gid for "www-data" in Alpine
$(grep -q "^www-data:" /etc/group) || addgroup -g 82 -S www-data
$(grep -q "^www-data:" /etc/passwd) || adduser -u 82 -S -D -G www-data www-data
