#!/bin/sh

# **************************************************************************
# Copyright (c) 2016 yuvaraj 
# Licensed under the MIT license 
# See https://github.com/shivarajnaidu/UV-Shell-Scripts/blob/master/LICENSE
# This script will install PostgreSQL on Ubuntu 
# **************************************************************************

#to produce colored output in STDOUT
red="$(tput setaf 1)"
green="$(tput setaf 2)"
blue="$(tput setaf 4)"
reset="$(tput sgr0)"
bold="$(tput bold)"

db_name="Postgre SQL"

sudo apt install apt-transport-https

installed_os_version="$(lsb_release -sr)"
echo "$installed_os_version"

print_last_text() {
	echo ""
	echo "$red $bold If You Experience Any Problem While Installing $db_name ....
	Please Feel Free To File The Issue At $blue https://github.com/shivarajnaidu/UV-Shell-Scripts"
	echo "$reset"
	echo ""
	echo "$green $bold Subscribe Our Youtube Channel at $blue https://www.youtube.com/channel/UCYsYM-ICsRYlgIxlkIo9FLQ $reset"
	echo ""
	echo "$green $bold Follow Us at $blue https://fb.com/opensourceinside $reset"
}

# Check Wheather It is suported version or not;
if [ "$installed_os_version" = "18.04" ] || [ "$installed_os_version" = "16.04" ] ; then
	echo "$bold $green $(lsb_release -sd) $reset"
	cd
else
    echo "$bold $red This Script Only Valid For Ubuntu 16.04 and 18.04 $reset"
	print_last_text
	exit 1;
fi

# Creaate A Source List File For Postgress adn Add Repository To Source List File..
if [ "$installed_os_version" = "18.04" ] ; then
	echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list &> /dev/null
elif [ "$installed_os_version" = "16.04" ] ; then
	echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list &> /dev/null
fi

if [ "$?" != "0" ]; then
  print_last_text  
  exit 1
fi

# Add Signing Key To make Source As Trusted Source..
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install postgresql

if [ "$?" != "0" ]; then
  print_last_text 
  exit 1
fi

echo ""
echo "$green $bold Now You Can Start To Use $db_name"
echo "$reset"
echo ""
echo "To Know More About Using $db_name look at $blue $bold https://opensourceinside.blogspot.in/search/?q=$db_name+installation"
echo "$reset"
echo ""

print_last_text