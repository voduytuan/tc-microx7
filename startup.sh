#!/bin/bash

echo "RUNNING..."

/var/config.sh


#############################################$
# Replace environment LOG IP
envtpl /etc/syslog-ng/conf.d/graylog.conf.tpl

## run supervisord
supervisord


# Call parent entrypoint (CMD)
/sbin/my_init

