# tc-microx
Web server docker with PHP 7, Nginx. This image support send syslog-ng to graylog2 server.

Environment to connect to graylog server:

`LOG_IP`: IP Address of graylog2 server (graylog must be open port UDP 1514)

## Re-download config file from $DOWNLOAD_URL
To redownload config url, we can run `/var/config.sh` with `docker exec...` command.

Example:
```bash
docker exec -ti containername /var/config.sh
```
