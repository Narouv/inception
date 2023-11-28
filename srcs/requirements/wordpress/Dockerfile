FROM debian:bookworm

RUN apt-get update -y && apt install php-fpm php-mysql -y && apt install curl -y

COPY ./conf/conf.sh /

RUN chmod +x conf.sh

CMD [ "./conf.sh" ]