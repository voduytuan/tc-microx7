FROM voduytuan/docker-nginx-php7:latest

RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y python-setuptools

# Install supervisord
RUN easy_install supervisor

# tweak php-fpm config (base on 20MB/process and 1800MB Memory, not include about 200MB for system services)
RUN sed -i -e "s/pm.max_children = 5/pm.max_children = 80/g" /etc/php/7.0/fpm/pool.d/www.conf && \
sed -i -e "s/pm.start_servers = 2/pm.start_servers = 8/g" /etc/php/7.0/fpm/pool.d/www.conf && \
sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 8/g" /etc/php/7.0/fpm/pool.d/www.conf && \
sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 20/g" /etc/php/7.0/fpm/pool.d/www.conf && \
sed -i -e "s/;pm.max_requests = 500/pm.max_requests = 500/g" /etc/php/7.0/fpm/pool.d/www.conf


# supervisord config
ADD supervisord.conf /etc/supervisord.conf

# nginx vhost config
ADD default /etc/nginx/sites-available/default

# create log directory for supervisord
RUN mkdir /var/log/supervisor/

# Create private folder for download config
RUN mkdir /var/www/private


# Copy startup script for getting environment information such as config...
ADD startup.sh      /var/startup.sh
RUN chmod +x /var/startup.sh

# Copy update script to download config
ADD config.sh      /var/config.sh
RUN chmod +x /var/config.sh

CMD [ "/var/startup.sh" ]
