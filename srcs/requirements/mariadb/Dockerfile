FROM debian:bookworm

RUN	apt-get update -y && apt-get install dialog -y && apt-get install mariadb-server -y

COPY conf/conf.sh /

RUN chmod +x conf.sh

CMD [ "./conf.sh" ]