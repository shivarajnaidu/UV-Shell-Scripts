#!/bin/sh

# **************************************************************************
# Copyright (c) 2016 yuvaraj 
# Licensed under the MIT license 
# See https://github.com/shivarajnaidu/UV-Shell-Scripts/blob/master/LICENSE
# This script will install elasticsearch and will configure 
# to use it from commandline as any normal command
# **************************************************************************

#to produce colored output in STDOUT
red="$(tput setaf 1)"
green="$(tput setaf 2)"
blue="$(tput setaf 4)"
reset="$(tput sgr0)"
bold="$(tput bold)"

sudo apt-get update

[ "$(command -v unzip)" ] && echo "$green $bold unzip is already installed in this system $reset" || sudo apt-get -y install unzip
cd

#function which handles elasticsearch installation
install_elasticsearch () {

  elasticsearch_download_url="https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/2.3.5/elasticsearch-2.3.5.zip"

#Decide whether to Download ElasticSearch archive or exist already..
zip_file="elasticsearch-2.3.5.zip"

if [ -e "$zip_file" ]; then
  echo "$green $bold $zip_file File Exist $reset"
else
  echo "$green $bold Downloading ElasticSearch $reset"
  wget "$elasticsearch_download_url"
fi
echo ""
echo "$red $bold decompressing $zip_file $reset"
unzip elasticsearch-2.3.5.zip

if ls /opt/elasticsearch-2* &> /dev/null ; then
  sudo rm -r /opt/elasticsearch-2*
  sudo mv elasticsearch-2.3.5/ /opt/
else 
  sudo mv elasticsearch-2.3.5/ /opt/
fi

[ "$?" = "0" ] && echo "$green $bold decompressing $zip_file completed $reset"

elasticsearch_bin_simu_link="/bin/elasticsearch"

if [ -L "$elasticsearch_bin_simu_link" ]; then
  	# echo "Link Already Exists"
  	sudo rm "$elasticsearch_bin_simu_link"
    sudo ln -s /opt/elasticsearch-2.3.5/bin/elasticsearch /bin/
  else
    sudo ln -s /opt/elasticsearch-2.3.5/bin/elasticsearch /bin/
  fi


  if [ "$?" = "0" ]; then
    echo ""
    echo "$green $bold Symbolic Link created for elasticsearch $reset"
    echo ""
    echo "$green Now You Can Start ElasticSearch Just By Typing $bold 'elasticsearch' $reset $green in your 
    or By $bold '/opt/elasticsearch-2.3.5/bin/elasticsearch'$reset $green  In Your command-line"
  fi

}

#installing OpenJDK 8
# echo "installing OpenJDK 8"
is_java_istalled="$(command -v java)"
installed_os_version="$(lsb_release -sr)"

echo ""

if [ "$installed_os_version" = "14.04" ]; then
 # echo "Your System Is Ubuntu $installed_os_version" 
 sudo add-apt-repository -y ppa:openjdk-r/ppa
 echo "$bold $green adding ppa $reset"
 sudo apt-get update
 echo "$bold $green installing openjdk-8-jdk in $(lsb_release -sd) $reset"
 sudo apt-get -y install openjdk-8-jdk openjdk-8-jre && install_elasticsearch
elif [ "$installed_os_version" = "16.04" ]; then
 # echo "Your System Is Ubuntu $installed_os_version"
 echo "$bold $green installing openjdk-8-jdk in $(lsb_release -sd) $reset"
 sudo apt-get -y install openjdk-8-jdk openjdk-8-jre && install_elasticsearch
fi

[ "$?" = "0" ] && [ "$is_java_istalled" ] && {
  echo ""
  echo "$bold $red It seems that You Have Already Installed Version of JAVA in Your System.. Please Set OpenJDK 8 as Default Version..
  Otherwise you may encounter problems while starting elasticsearch"
  echo ""
  echo "$green You can configure multiple versions of java by running following command.."
  echo "sudo update-alternatives --config java"
  echo "select apropriate version of JAVA"
  echo "to verify the java version run.. 'java -version' $reset "
  echo ""
}

echo ""
echo "$red $bold If You Experience Any Problem While Installing ElasticSearch....
Please Feel Free To File The Issue At $blue https://github.com/shivarajnaidu/UV-Shell-Scripts"
echo "$reset"
echo "$green $bold Follow Us at $blue fb.com/opensourceinside $reset"
echo ""
