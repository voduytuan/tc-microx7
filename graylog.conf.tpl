### Syslog-ng Logging Directives for Graylog2 server ###

destination d_graylog {
	udp("{{LOG_IP}}" port(1514));
};

log {
	source(s_src);
	destination(d_graylog);
};

### END Syslog-ng Logging Directives for Graylog2 server ###
