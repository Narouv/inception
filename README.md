*This project has been created as part of the 42 curriculum by rnauke.*

# Inception

## Description

Inception is a System Administration project from the 42 curriculum. Its goal is to broaden the knowledge of system administration by using **Docker** to virtualize multiple self-contained services, and **docker-compose** to orchestrate them into a small, self-hosted infrastructure.

The project sets up a mini-infrastructure of several dockerized services running in a virtual machine:

- **NGINX** — the only entry point of the infrastructure, serving the WordPress site over **HTTPS only** (TLSv1.2 or TLSv1.3), with a self-signed certificate.
- **WordPress** — a fully configured WordPress installation with a database, served by NGINX via **PHP-FPM** (no container pulls pre-built WordPress images: everything is built from a `debian:bookworm` base).
- **MariaDB** — the database backing WordPress, with a dedicated user and database, and **no root access from the outside**.

Each service runs in its own dedicated container, built by its own `Dockerfile`, and the containers are connected through a custom docker network. Persistent data (WordPress files and MariaDB database) is stored in bind-mounted volumes located in `~/data`, so nothing is lost when containers are removed. Containers also have `restart: unless-stopped`, meaning they recover automatically after a crash or a system reboot.

Credentials, the domain name (`rnauke.42.fr`) and other configuration values are centralized in the `srcs/.env` file.

## Instructions

### Requirements

- A **virtual machine** (e.g. VirtualBox or another hypervisor) running **Debian / Linux**
- **Docker** and **docker-compose**

### Installation

```sh
# Clone the repository
git clone https://github.com/Narouv/inception.git
cd inception

# Make the domain point to your VM
echo "127.0.0.1 rnauke.42.fr" | sudo tee -a /etc/hosts

# Build and start the whole infrastructure
make
```

The first `make` creates the `~/data/mariadb` and `~/data/wordpress` directories, then builds the three images and starts the containers in the background.

### Usage

Once everything is up, browse to **https://rnauke.42.fr** to reach the WordPress site. Since the TLS certificate is self-signed, your browser will warn you about it — that is expected.

### Makefile targets

| Target | Description |
|---|---|
| `make` / `make up` | Create the data directories and build + launch the infrastructure |
| `make down` | Stop and remove the containers |
| `make clean` | Stop and remove all containers, images, volumes, networks, and the `~/data` directory |
| `make re` | `clean` then `up` — full rebuild from scratch |

## Resources

- [Docker documentation](https://docs.docker.com/) — Dockerfiles, images, networks, volumes
- [Docker Compose overview](https://docs.docker.com/compose/) — service orchestration, `docker-compose.yml`
- [NGINX documentation](https://nginx.org/en/docs/) — server configuration, TLS configuration
- [WordPress documentation](https://developer.wordpress.org/) — installation and CLI (`wp-cli`) usage
- [MariaDB documentation](https://mariadb.com/documentation/) — database server setup and user management
- [PHP-FPM documentation](https://www.php.net/manual/fr/install.fpm.php) — FastCGI process manager

### Use of AI

AI assistance was not used in this project
