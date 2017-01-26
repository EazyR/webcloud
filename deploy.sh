#!/bin/bash

#####################################################################
#																	#
#	Script de déploiement - Richard Disaro & Guillaume Papinutti	#
#																	#
#####################################################################


###### Installations et Mises à jour ######

# Met à jour le serveur
echo "xxx apt-get update xxx"
apt-get update > ~/latest-update.log

# Installe les mises à jour
echo "xxx apt-get upgrade xxx"
apt-get upgrade > ~/latest-upgrade.log

# Installe NGINX
apt-get install -y nginx

# Installe GIT

apt-get install git

# On supprime les fichiers html créés automatiquement par NGINX
rm -f var/www/html*

# On se place dans notre dossier www
cd /var/www

# On y clone notre repo git et on se place dedans

if [ -d html/.git ]; then
    # On le met à jour
    echo " ### Un projet semble initialisé"
    echo " ### Mise à jour du projet ... "
    cd html
    git pull
else
    echo " ## Le projet n'a jamais été déployé pour le moment"
    echo " ## Mise en place du projet ... "

    # On supprime le dossier html
    rm -Rf html
    # Et on clone le projet dans un nouveau dossier html
    git clone https://github.com/CelesteBegassat/WebCloud.git html
fi

######## Mise à jour de la crontab #########

crontab cron.txt

# Le cron.txt indique à la crontab d'afficher à toutes les heures +5min la date, la liste des processus en cours & l'espace libre.


########### Wikipedia on server ###########

# DL Kiwix for x86_64 architectures. On ne le retélécharge pas s'il est déjà présent.
if [ -f "/var/www/html/webcloud/kiwix-linux-x86_64.tar" ]; 

then
	echo "kiwix déjà téléchargé"
else
	wget http://download.kiwix.org/bin/kiwix-linux-x86_64.tar.bz2


#Unzip le fichier .bz2 et extraction de l'archive .tar
bunzip2 kiwix-linux-x86_64.tar.bz2
tar xvf kiwix-linux-x86_64.tar

fi

#DL the .zim file. On ne le retélécharge pas s'il est déjà présent.
if [ -f "/var/www/html/webcloud/wikipedia_fr_medicine_nopic_2016-10.zim" ];

then 
	echo "zim déjà téléchargé"
else
	wget https://download.kiwix.org/zim/wikipedia/wikipedia_fr_medicine_nopic_2016-10.zim
	
fi

# Use the kiwix serve command to serve the .zim file on port 1025 : On vérifie que le processus soit déjà lancé pour ne pas le relancer pour rien.
ps cax | grep kiwix-serve > /dev/null 
if [ $? -eq 0 ]; 

then
	echo "kiwix déjà lancé"
else
	./kiwix/bin/kiwix-serve --port=1025 wikipedia_fr_medicine_nopic_2016-10.zim
	echo "kiwix vient d'être lancé"
	
fi

### Fin. ###
