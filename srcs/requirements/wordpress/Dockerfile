FROM debian:bullseye

RUN apt-get update -y && apt-get install php-fpm php-mysql curl wget -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp
RUN mkdir -p /run/php

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/.
COPY ./tools/script.sh / 

RUN chmod u+x /script.sh

ENTRYPOINT ["/script.sh"]
WORKDIR /var/www/html/

CMD ["php-fpm7.4", "-F"]