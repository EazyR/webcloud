#!/bin/bash

########### INCOMPLET #############


# Update le serveur
apt-get update

# Upgrade le serveur
apt-get upgrade

#Install SSH
apt-get install -y ssh

# Install NGINX
apt-get install -y nginx

# Send the list of processes to /var/www/index.html

ps > /var/www/html/index.html


cd /var/www/html/

git clone git@github.com:eazyR/webcloud.git
cd /var/www/html/webcloud

# DL Kiwix for x86_64 architectures
wget http://download.kiwix.org/bin/kiwix-linux-x86_64.tar.bz2

#Unzip the .bz2 file and extract the content of the .tar archive
bunzip2 kiwix-linux-x86_64.tar.bz2
tar xvf kiwix-linux-x86_64.tar

#DL the .zim file 
wget https://download.kiwix.org/zim/wikipedia/wikipedia_fr_all_nopic_2016_12.zim

# Use the kiwix serve command to serve the .zim file on port 80
./kiwix/bin/kiwix-serve --port=80 wikipedia_fr_all_nopic_2016_12.zim


