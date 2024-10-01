#!/bin/sh

#check if wp-config.php exist
if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	sed -i "s/username_here/$DB_USER/g" wp-config-sample.php
	sed -i "s/password_here/$DB_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$DB_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$DB_DATABASE/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	wp config set WP_REDIS_HOST redis
  	wp config set WP_REDIS_PORT 6379 --raw
 	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME
 	wp config set WP_REDIS_CLIENT phpredis
	wp plugin install redis-cache --activate
    wp plugin update --all
	wp redis enable

fi

exec "$@"