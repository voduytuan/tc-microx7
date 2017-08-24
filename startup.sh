#!/bin/bash

echo "RUNNING..."

/var/config.sh

# Call parent entrypoint (CMD)
/sbin/my_init

