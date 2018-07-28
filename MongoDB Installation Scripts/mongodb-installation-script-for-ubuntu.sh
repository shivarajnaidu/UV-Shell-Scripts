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
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update

if [ -d "/data/db/" ]; 
	then
	sudo chmod -R 777 /data/
else
	sudo mkdir -p /data/db/
	sudo chmod -R 777 /data/
fi

# sudo apt-get install -y --allow-unauthenticated libcurl3
sudo apt-get install -y --allow-unauthenticated mongodb-org

if [ "$(lsb_release -sr)" = "14.04" ]; then
	echo "$bold $green $(lsb_release -sd) $reset" 
	sudo service mongod start
else
	echo "$bold $green $(lsb_release -sd) $reset" 
	cat << EOF | sudo tee /etc/systemd/system/mongodb.service &> /dev/null
	[Unit]
	Description=High-performance, schema-free document-oriented database
	After=network.target

	[Service]
	User=mongodb
	ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

	[Install]
	WantedBy=multi-user.target
EOF

	[ "$?" = "0" ] && sudo systemctl enable mongodb
	[ "$?" = "0" ] && sudo systemctl start mongodb || echo "$red $bold It seems something went wrong.."

fi

echo ""
echo "$red $bold If You Experience Any Problem While Installing MongoDB....
Please Feel Free To File The Issue At $blue https://github.com/shivarajnaidu/UV-Shell-Scripts"
echo "$reset"
echo "$green $bold Follow Us at $blue fb.com/opensourceinside $reset"
echo ""
