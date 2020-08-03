#!/bin/bash

logger -t devvm "Install started: $?"

logger -t devvm "Installing  plasma KDE $?"
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

logger -t devvm "Installed KDE $?"

logger -t devvm "Installing  Firefox $?"
sudo apt-get -q -y --no-install-recommends install firefox

logger -t devvm "Installing  Dolphin $?"
sudo apt-get -q -y --no-install-recommends install dolphin

logger -t devvm "Installing AZUL Java $?"
    
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

logger -t devvm "Completed Install of JMeter 5.3 $?"

logger -t devvm "Installing Kconsole $?"
sudo apt-get install -q -y kconsole

logger -t devvm "Completed Install of Kconsole $?"

logger -t devvm "Suppress Screen Lockout Timeout - SSH Keys In Use $?"
sudo echo -e "\  
export LOCKPRG='/bin/true'"\
 >> ~/.bashrc

logger -t devvm "Success"
exit 0
