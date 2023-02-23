---
title: "Setting up a LEMP server with Wordpress"
categories:
  - linux
date: 2023-02-23
layout: "post"
slug: "lemp-server"
menu:
  main:
    weight: -10
---

# Setting up a LEMP server with Wordpress

LEMP stands for Linux, Nginx (read like Engine-X), MySQL and PHP.  
You may have heard about LAMP, which uses Apache instead of Nginx.

## Getting a server

I would recommend to use [GCP](https://cloud.google.com) to rent VM.  
If you would like to host this for free, then you can choose an E2-micro instance somewhere in Iowa (your first 744 hours / month of E2-micro instances are free)  
I won't go into detail with the VM setup, but you will need to setup ssh keys, with the HTTP and HTTPS flags, and choose the OS to be Ubuntu 22.04

## Installing nginx

First update the server

```sh
sudo apt update
sudo apt upgrade -y
```

Then install Nginx

```sh
sudo apt install nginx -y
```

## Installing MySQL

```sh
sudo apt install mysql-server -y
sudo mysql -u root
```

At the mysql prompt enter

```sql
CREATE USER '<username>'@'localhost' IDENTIFIED BY '<password>';
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES on wordpress.* TO '<username>'@'localhost';
FLUSH PRIVILEGES;
QUIT
```

## Installing PHP

```sh
sudo add-apt-repository universe
sudo apt update
sudo apt install -y php-fpm php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc
sudo systemctl enable --now php8.1-fpm
```

## Configuring Nginx

Open the `/etc/nginx/sites-available/default` file with `nano` (or any other editor)

```nginx
server {
        listen 80;
        root /var/www/html;
        index index.php index.html index.htm index.nginx-debian.html;
        server_name <your_domain>;

        location / {
                try_files $uri $uri/ /index.php;
        }

        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}
```

```sh
sudo systemctl restart nginx
```

## Installing Wordpress

Download the latest Wordpress

```sh
cd /var/www/html
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xvf latest.tar.gz -C .
sudo mv wordpress/* .
sudo rm -r latest.tar.gz wordpress
sudo rm index.nginx-debian.html
```

## Configuring Wordpress

```sh
sudo cp wp-config-sample.php wp-config.php
sudo nano wp-config.php
```

And configure the DB_NAME, DB_USER and DB_PASSWORD  
Then go to [salt](https://api.wordpress.org/secret-key/1.1/salt) and paste the values in the config

And you are done
