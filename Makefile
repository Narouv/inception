COMPOSE=./srcs/docker-compose.yml

all: up

up:
	mkdir ~/volumes
	mkdir ~/volumes/mariadb ~/volumes/wordpress
	docker-compose -f $(COMPOSE) up --build -d

down:
	docker-compose -f $(COMPOSE) down

clean:
	@docker stop $(docker ps -qa); \
	docker rm $(docker ps -qa); \
	docker rmi -f $(docker images -qa); \
	docker volume rm $(docker volume ls -q); \
	docker network rm $(docker network ls -q)

re: clean all

.PHONY: clean re up down