COMPOSE=./srcs/docker-compose.yml

all: up

up:
	@-mkdir ~/data
	@-mkdir ~/data/mariadb ~/data/wordpress
	docker-compose -f $(COMPOSE) up --build -d

down:
	docker-compose -f $(COMPOSE) down

clean:
	@-sudo docker stop `docker ps -qa`
	@-sudo docker rm `docker ps -qa`
	@-sudo docker rmi -f `docker images -qa`
	@-sudo docker volume rm `docker volume ls -q`
	@-sudo docker network rm `docker network ls -q`
	@sudo rm -rf ~/data

re: clean all

.PHONY: clean re up down 