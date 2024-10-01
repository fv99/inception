FROM debian:bullseye

RUN apt-get update -y && apt-get install mariadb-server -y

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/script.sh / 
RUN chmod u+x /script.sh

ENTRYPOINT ["./script.sh"]