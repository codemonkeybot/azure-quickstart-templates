#!/bin/bash

echo "Install started: $?"

#############
# Parameters
#############

AZUREUSER=$1
HOMEDIR="/home/$AZUREUSER"
VMNAME=`hostname`
echo "User: $AZUREUSER"
echo "User home dir: $HOMEDIR"
echo "vmname: $VMNAME"

echo "Installing  plasma KDE $?"
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

echo "Installed KDE $?"

echo "Installing  Firefox $?"
sudo apt-get -q -y --no-install-recommends install firefox

echo "Installing  Dolphin $?"
sudo apt-get -q -y --no-install-recommends install dolphin

echo "Installing AZUL Java $?"
    
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 
    
sudo apt-add-repository "deb http://repos.azulsystems.com/ubuntu stable main" 
    
sudo apt-get -q -y update 

sudo apt-get -q -y dist-upgrade 

sudo apt-get -q -y --no-install-recommends install zulu-8=8.46.0.19 
    
sudo rm -rf /var/lib/apt/lists/*

echo "Installed AZUL Java $?"

echo "Installing Software-Properites: $?"

apt-get install -q -y software-properties

echo "Software-Properties installed: $?"

echo "Installing X2Go Server $?"

sudo dpkg --configure -a

sudo apt-add-repository -y ppa:x2go/stable

sudo apt-get -q -y update

sudo apt-get -q -y upgrade

sudo apt-get install -q -y x2goserver x2goserver-xsession

echo "Installed X2Go Server $?"

echo "Installing JMeter 5.3 $?"

sudo mkdir -p /tmp/dependencies  

sudo curl -L --silent https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.3.tgz >  /tmp/dependencies/apache-jmeter-5.3.tgz  

sudo mkdir -p /opt  

sudo tar -xzf /tmp/dependencies/apache-jmeter-5.3.tgz -C /opt  

sudo rm -rf /tmp/dependencies

sudo ufw allow from any to any port 9091 proto tcp

echo "Completed Install of JMeter 5.3 $?"

echo "Installing Konsole $?"
sudo apt-get install -q -y konsole

echo "Completed Install of Konsole $?"

echo "Suppress Screen Lockout Timeout - SSH Keys In Use $?"
sudo echo -e "export LOCKPRG=/bin/true" >> ~/.bashrc

####################
# Setup Chrome
####################
cd /tmp
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get -y --allow-downgrades --allow-remove-essential --allow-change-held-packages install -f
rm /tmp/google-chrome-stable_current_amd64.deb
date

echo "Success"
exit 0
