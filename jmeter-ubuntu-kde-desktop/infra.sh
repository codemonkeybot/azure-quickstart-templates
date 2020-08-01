#!/bin/bash

logger -t devvm "Install started: $?"

logger -t devvm "Installing  plasma KDE $?"

sudo apt-get install -q -y  kubuntu-desktop

sudo apt-get -q -y update
sudo apt-get -q -y upgrade

logger -t devvm "Installed KDE $?"

logger -t devvm "Installing AZUL Java $?"

sudo apt-get -q -y --no-install-recommends install gnupg locales 

sudo locale-gen en_US.UTF-8 
    
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 
    
sudo apt-add-repository "deb http://repos.azulsystems.com/ubuntu stable main" 
    
sudo apt-get -q -y update 

sudo apt-get -q -y dist-upgrade 

sudo apt-get -q -y --no-install-recommends install zulu-8=8.46.0.19 
    
sudo rm -rf /var/lib/apt/lists/*

logger -t devvm "Installed AZUL Java $?"

logger -t devvm "Installing Software-Properites: $?"

apt-get install -q -y software-properties

logger -t devvm "Software-Properties installed: $?"

logger -t devvm "Installing X2Go Server $?"

sudo dpkg --configure -a

sudo apt-add-repository -y ppa:x2go/stable

sudo apt-get -q -y update

sudo apt-get -q -y upgrade

sudo apt-get install -q -y x2goserver x2goserver-xsession

logger -t devvm "Installed X2Go Server $?"

logger -t devvm "Installing JMeter 5.3 $?"

sudo mkdir -p /tmp/dependencies  

sudo curl -L --silent https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.3.tgz >  /tmp/dependencies/apache-jmeter-5.3.tgz  

sudo mkdir -p /opt  

sudo tar -xzf /tmp/dependencies/apache-jmeter-5.3.tgz -C /opt  

sudo rm -rf /tmp/dependencies

sudo ufw allow from any to any port 9091 proto tcp

logger -t devvm "Completed JMeter 5.3 $?"

logger -t devvm "Success"
exit 0
