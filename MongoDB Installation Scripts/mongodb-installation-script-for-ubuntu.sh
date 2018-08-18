#!/bin/sh

# **************************************************************************
# Copyright (c) 2016 yuvaraj 
# Licensed under the MIT license 
# See https://github.com/shivarajnaidu/UV-Shell-Scripts/blob/master/LICENSE
# This script will install MongoDB on Ubuntu 
# **************************************************************************

#to produce colored output in STDOUT
red="$(tput setaf 1)"
green="$(tput setaf 2)"
blue="$(tput setaf 4)"
reset="$(tput sgr0)"
bold="$(tput bold)"

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

# Add Repository Source To Solurce List Based On Verion Of Ubuntu
if [ "$(lsb_release -sr)" = "14.04" ]; then
	echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
elif [ "$(lsb_release -sr)" = "16.04" ]; then
	echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
else
	echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
fi

sudo apt-get update

if [ -d "/data/db/" ]; then
	sudo chmod -R 777 /data/
else
	sudo mkdir -p /data/db/
	sudo chmod -R 777 /data/
fi

sudo apt-get install -y --allow-unauthenticated mongodb-org

if [ "$(lsb_release -sr)" = "14.04" ]; then
	echo "$bold $green $(lsb_release -sd) $reset" 
	sudo service mongod start
else
    sudo systemctl enable mongod
    sudo systemctl start mongod
fi


echo ""
echo "$red $bold If You Experience Any Problem While Installing MongoDB....
Please Feel Free To File The Issue At $blue https://github.com/shivarajnaidu/UV-Shell-Scripts"
echo "$reset"
echo "$green $bold Follow Us at $blue fb.com/opensourceinside $reset"
echo ""
