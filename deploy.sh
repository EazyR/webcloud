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

# Install apache2

apt-get install apache2

# apt-get install -y ruby

# gem install jekyll


# Install GIT

apt-get install git

# Delete the auto generated html file of the server
rm -f var/www/html*

# Get into our html repertory
cd /var/www/html/

# clone our git project in the html repertory

git clone https://github.com/EazyR/webcloud.git

cd /var/www/html/webcloud


# Send the list of processes to /var/www/index.html

#ps > /var/www/html/index.html

######## Définir des rappels avec crontab #########

crontab cron.txt

######" Déployer un blog avec Jekyll #######



########### Wikipedia on server ###########

# DL Kiwix for x86_64 architectures : Si c'est déjà DL, pass
if [-f "/var/www/html/webcloud/kiwix-linux-x86_64.tar"]; 
then
  echo "kiwix déjà téléchargé"
else
wget http://download.kiwix.org/bin/kiwix-linux-x86_64.tar.bz2


#Unzip the .bz2 file and extract the content of the .tar archive
bunzip2 kiwix-linux-x86_64.tar.bz2
tar xvf kiwix-linux-x86_64.tar
fi

#DL the .zim file : Si c'est déjà DL, pass
if [-f "/var/www/html/webcloud/wikipedia_fr_medicine_nopic_2016-10.zim"];
then 
  echo "zim déjà téléchargé"
  else
wget https://download.kiwix.org/zim/wikipedia/wikipedia_fr_medicine_nopic_2016-10.zim
fi

# Use the kiwix serve command to serve the .zim file on port 80 : Rajouter un if / else. Si le processus est déjà lancé, le tuer puis le relancer.
ps -aux | grep kiwix-serve > a
if [$a !=null]
then
 echo "kiwix déjà lancé"
else
./kiwix/bin/kiwix-serve --port=80 wikipedia_fr_medicine_nopic_2016-10.zim
fi


