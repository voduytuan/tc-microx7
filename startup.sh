#!/bin/bash

echo "RUNNING..."

/var/config.sh

#start phpfpm
service php7.0-fpm start

# Call parent entrypoint (CMD)
/sbin/my_init

