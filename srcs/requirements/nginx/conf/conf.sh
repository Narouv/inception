#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj $CERTIFICATE

echo '
server {
	listen 443 ssl;
	listen [::]:443 ssl;

	ssl on;
	ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
	ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

	ssl_protocols TLSv1.2 TLSv1.3;
	ssl_prefer_server_ciphers off;

	server_name rnauke.42.fr www.rnauke.42.fr;

	index index.php;
	root /var/www/html;

	location ~ [^/]\.php(/|$) { 
			try_files $uri =404;
			fastcgi_pass wordpress:9000;
			include fastcgi_params;
			fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		}

}' > /etc/nginx/sites-available/default


nginx -g "daemon off;"