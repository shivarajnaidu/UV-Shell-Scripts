#!/bin/sh

# **************************************************************************
# Copyright (c) 2016 yuvaraj 
# Licensed under the MIT license 
# See https://github.com/shivarajnaidu/UV-Shell-Scripts/blob/master/LICENSE
# This script will install ArangoDB on Ubuntu 
# **************************************************************************

#to produce colored output in STDOUT
red="$(tput setaf 1)"
green="$(tput setaf 2)"
blue="$(tput setaf 4)"
reset="$(tput sgr0)"
bold="$(tput bold)"

sudo apt-get install apt-transport-https

installed_os_version="$(lsb_release -sr)"
echo "$installed_os_version"

if [ "$installed_os_version" = "14.04" ]; then
	cd
	wget https://www.arangodb.com/repositories/arangodb3/xUbuntu_14.04/Release.key
	sudo apt-key add - < Release.key
	echo 'deb https://www.arangodb.com/repositories/arangodb3/xUbuntu_14.04/ /' | sudo tee /etc/apt/sources.list.d/arangodb.list
elif [ "$installed_os_version" = "16.04" ]; then
	cd
	wget https://www.arangodb.com/repositories/arangodb3/xUbuntu_16.04/Release.key
	sudo apt-key add - < Release.key
	echo 'deb https://www.arangodb.com/repositories/arangodb3/xUbuntu_16.04/ /' | sudo tee /etc/apt/sources.list.d/arangodb.list
fi

if [ "$?" = "0" ]; then
sudo apt-get update
sudo apt-get -y install arangodb3
fi

[ "$?" = "0" ] && {
    echo ""
	echo "Now You Can Start To Use ArangoDB"
	echo "To Know More About Using ArangoDB"
}
