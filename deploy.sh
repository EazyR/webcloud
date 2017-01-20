#!/bin/bash

########### INCOMPLET #############


# Update le serveur
apt-get update

# Upgrade le serveur
apt-get upgrade

#Install SSH
apt-get install ssh

# Install NGINX
apt-get install nginx

# Send the list of processes to /var/www/index.html

ps > /var/www/html/index.html

# Partie Wikipedia à venir


