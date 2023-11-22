FROM debian:bookworm

RUN apt-get update -y && apt-get install nginx -y && apt-get install openssl -y

COPY ./conf/conf.sh /

RUN chmod +x conf.sh

CMD [ "./conf.sh" ]