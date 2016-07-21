#!/bin/sh
sudo apt-get install apt-transport-https

if [ "$(lsb_release -sr)" == "14.04" ];
	then
wget https://www.arangodb.com/repositories/arangodb3/xUbuntu_14.04/Release.key
sudo apt-key add - < Release.key
echo 'deb https://www.arangodb.com/repositories/arangodb3/xUbuntu_14.04/ /' | sudo tee /etc/apt/sources.list.d/arangodb.list

elif [ "$(lsb_release -sr)" == "16.04" ];
	then
wget https://www.arangodb.com/repositories/arangodb3/xUbuntu_16.04/Release.key
sudo apt-key add - < Release.key
echo 'deb https://www.arangodb.com/repositories/arangodb3/xUbuntu_16.04/ /' | sudo tee /etc/apt/sources.list.d/arangodb.list
fi

sudo apt-get update
sudo apt-get install arangodb3
