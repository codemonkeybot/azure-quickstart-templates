#!/bin/bash

echo "Install started for User:  $1"

#############
# Parameters
#############

AZUREUSER=$1
HOMEDIR="/home/$AZUREUSER"
VMNAME=`hostname`
echo "User: $AZUREUSER"
echo "User home dir: $HOMEDIR"
echo "vmname: $VMNAME"

echo "Installing  plasma KDE for User:  $1"
sudo apt-get -q -y update

export  LANG=en_US.UTF-8

sudo apt-get -q -y --no-install-recommends install gnupg locales && \
    echo "$LANG UTF-8" >> /etc/locale.gen && \
    locale-gen 

sudo apt update && \
    apt upgrade -y && \
    apt install -y plasma-desktop

sudo apt remove -y bluedevil && \
    sed -i 's/.*kdeinit/###&/' /usr/bin/startkde

sudo apt-get -q -y update
sudo apt-get -q -y upgrade

echo "Installed KDE for User:  $1"

echo "Installing  Firefox for User:  $1"
sudo apt-get -q -y --no-install-recommends install firefox

echo "Installing  Dolphin for User:  $1"
sudo apt-get -q -y --no-install-recommends install dolphin

echo "Installing AZUL Java for User:  $1"
    
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 
    
sudo apt-add-repository "deb http://repos.azulsystems.com/ubuntu stable main" 
    
sudo apt-get -q -y update 

sudo apt-get -q -y dist-upgrade 

sudo apt-get -q -y --no-install-recommends install zulu-8=8.46.0.19 
    
sudo rm -rf /var/lib/apt/lists/*

echo "Installed AZUL Java $1"

echo "Installing Software-Properites for User:  $1"

apt-get install -q -y software-properties

echo "Software-Properties installed for User:  $1"

echo "Installing X2Go Server for User:  $1"

sudo dpkg --configure -a

sudo apt-add-repository -y ppa:x2go/stable

sudo apt-get -q -y update

sudo apt-get -q -y upgrade

sudo apt-get install -q -y x2goserver x2goserver-xsession

echo "Installed X2Go Server for User:  $1"

echo "Installing JMeter 5.3 for User:  $1"

sudo mkdir -p /tmp/dependencies  

sudo curl -L --silent https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.3.tgz >  /tmp/dependencies/apache-jmeter-5.3.tgz  

sudo mkdir -p /opt  

sudo tar -xzf /tmp/dependencies/apache-jmeter-5.3.tgz -C /opt  

sudo rm -rf /tmp/dependencies

sudo ufw allow from any to any port 9091 proto tcp

echo "Completed Install of JMeter 5.3 for User:  $1"

echo "Installing Konsole for User:  $1"
sudo apt-get install -q -y konsole

echo "Completed Install of Konsole for User:  $1"

echo "Installing kgpg for User:  $1"
sudo apt-get install -q -y kgpg
echo "Completed Install of kgpg for User:  $1"

#echo "Suppress Screen Lockout Timeout - SSH Keys In Use $1"
#sudo echo -e "export LOCKPRG=/bin/true" >> ~/.bashrc

####################
# Setup Chrome
####################
echo "Installing Google Chrome for User: $1"
cd /tmp
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -y --allow-downgrades --allow-remove-essential --allow-change-held-packages install -f
rm /tmp/google-chrome-stable_current_amd64.deb
date
echo "Completed Install Google Chrome for User: $1"
echo "Success for User: $1"
exit 0
