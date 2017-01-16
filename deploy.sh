#!/bin/bash

# Remplacer xxx.xxx.xxx.xxx par l'adresse IP de votre serveur.

tail -n +3 "$0" | ssh root@178.62.32.56; exit
set -eu

# Update le serveur
apt-get update

# Upgrade le serveur
apt-get upgrade

# Install NGINX
apt-get install nginx

# Send the list of processes to /var/www/index.html

ps > /var/www/html/index.html