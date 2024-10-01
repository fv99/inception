FROM debian:bullseye

RUN apt-get update -y && apt-get install nginx openssl -y

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/key1.crt \
       -keyout /etc/nginx/ssl/key1.key \
       -subj "/C=CZ/ST=Prague/L=Prague/O=42prague.com/OU=fvonsovs/CN=fvonsovs/"

COPY ./conf/default /etc/nginx/sites-available/.
#COPY ./tools/script.sh / 

ENTRYPOINT ["nginx", "-g", "daemon off;"]