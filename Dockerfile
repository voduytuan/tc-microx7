FROM voduytuan/docker-nginx-php7:latest

RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y python-setuptools

#remove svrun phpfpm
RUN rm -rf /etc/service/phpfpm

# tweak php-fpm config (base on 20MB/process and 3800MB Memory, not include about 200MB for system services)
RUN sed -i -e "s/pm.max_children = 5/pm.max_children = 160/g" /etc/php/7.0/fpm/pool.d/www.conf && \
sed -i -e "s/pm.start_servers = 2/pm.start_servers = 16/g" /etc/php/7.0/fpm/pool.d/www.conf && \
sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 16/g" /etc/php/7.0/fpm/pool.d/www.conf && \
sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 40/g" /etc/php/7.0/fpm/pool.d/www.conf && \
sed -i -e "s/;pm.max_requests = 500/pm.max_requests = 2000/g" /etc/php/7.0/fpm/pool.d/www.conf && \
sed -i -e "s/;pm.status_path = \/status/pm.status_path = \/fpmstatus/g" /etc/php/7.0/fpm/pool.d/www.conf && \
sed -i -e "s/;ping.path = \/ping/ping.path = \/fpmping/g" /etc/php/7.0/fpm/pool.d/www.conf

# nginx vhost config
ADD default /etc/nginx/sites-available/default


# Create private folder for download config
RUN mkdir /var/www/private


# Copy startup script for getting environment information such as config...
ADD startup.sh      /var/startup.sh
RUN chmod +x /var/startup.sh

# Copy update script to download config
ADD config.sh      /var/config.sh
RUN chmod +x /var/config.sh


CMD [ "/var/startup.sh" ]
