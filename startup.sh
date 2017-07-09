#!/bin/bash

echo "RUNNING..."

/var/config.sh

## run supervisord
supervisord


# Call parent entrypoint (CMD)
/sbin/my_init

