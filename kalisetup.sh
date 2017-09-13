#Version 20170912.1
#This script assumes you're logged in as root using the Kali VM provided by Offensive Security here: https://www.offensive-security.com/kali-linux-vmware-virtualbox-image-download/.
#A browser will be opened to the Java, and Nessus download page allowing you to pick which version to install.
#After the download is complete the script will complete the install from the downloads directory.
#This script is setup to make it easy to comment out the components you do not wish to install, not be the most efficient use of space.
#This script creates a directory on the desktop with scripts that update tools, scripts that run tools, and some basic instructions for tools.


#Install Java without modifying sources.
#Roll SSH keys.
#Update the system.
#Install TOR.
#Install Filezilla FTP client.
#Install OpenVAS and Alien/NSIS/RPM dependancies.
#Create new openvas user of "admin" with a password of "toor".
#Update OpenVAS NVT, CERT, and SCAP data.
#Install HTOP, NetHogs, Gdebi, Git, Bleachbit, and ClamAV system utilities.
#Install Nessus.
#Install Exploit Pack.
#Install Veil Evasion 3.
#Install GoPhish.
#Install pwntools CTF framework.
#Install Lynis.
#Install PRET.
#Update locate database.
#Turn off screensaver and screen lock.

#Create script on desktop to update ClamAV footprints.
#Create script on desktop to start TOR service.
#Create script on desktop to update Exploit Pack.
#Create script on desktop to update Veil Evasion 3.

#!/bin/bash

#Java download.
firefox http://www.java.com/en/download/linux_manual.jsp

#Nessus download.
firefox http://www.tenable.com/products/nessus/select-your-operating-system

#GoPhish download.
firefox https://github.com/gophish/gophish/releases

#Install Java without modifying sources.
cd /root/Downloads/
tar -zxvf jre*.tar.gz
mv jre* /opt
cd /opt/jre*
update-alternatives –install /usr/bin/java java /opt/jre*/bin/java 1
update-alternatives –install /usr/lib/mozilla/plugins/libjavaplugin.s­o mozilla-javaplugin.so /opt/jre*/lib/amd64/libnpjp2.so 1
update-alternatives –set java /opt/jre*/bin/java
update-alternatives –set javac /opt/jre*/bin/javac
update-alternatives –set mozilla-javaplugin.so /opt/jre*/lib/amd64/libnpjp2.so
java -version
pause

#Roll SSH keys
cd /etc/ssh/ && mkdir old #Move to the SSH directory and make a new directory for the old keys.
mv ssh_host_* old #Move the original keys to the old directory.
dpkg-reconfigure openssh-server #Create new SSH keys.

#Update system and install tools.
apt update && apt upgrade -y && apt dist-upgrade -y
apt install tor
apt install filezilla filezilla-common
apt install alien rpm nsis openvas
apt install htop nethogs gdebi git bleachbit clamav #System utilities.
freshclam #Update ClamAV footprints.
apt install python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential #For pwntools.


#Create new openvas user of "admin" with a password of "toor".



#Update OpenVAS NVT, CERT, and SCAP data.
greenbone-nvt-sync
greenbone-certdata-sync
greenbone-scapdata-sync


#Install Nessus
gdebi -i Nessus*.deb


#Fix any broken installs.
apt install -f


#Install Exploit Pack
git clone https://github.com/juansacco/exploitpack.git /usr/share/exploitpack
cd /usr/share/exploitpack
java -jar ExploitPack.jar



#Install Veil Evasion 3
git clone --recursive https://github.com/Veil-Framework/Veil.git /usr/share/Veil
cd /usr/share/Veil/setup
./setup.sh -c



#Install GoPhish
cd ~/Downloads
unzip gophish-v???-linux-64bit.zip -d /usr/share/
cd /usr/share/gophish-v???-linux-64bit
chmod 755 ./gophish
./gophish & firefox https://localhost:3333 &




#Install pwntools
apt install python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
pip install --upgrade pip
pip install --upgrade pwntools


#Update pwntools
pip install --upgrade pwntools


#Install Lynis
cd /usr/local
git clone https://github.com/CISOfy/lynis



#Install PRET
pip install colorama pysnmp
pip install win_unicode_console
apt install imagemagick ghostscript

#Update locate database.
updatedb


#Turn off screensaver and screen lock.
xset s off # don't activate screensaver
xset -dpms # disable DPMS (Energy Star) features.
xset s noblank # don't blank the video device


















#Download instructions for use from GIT.

wget -O new_setup.sh https://gist.githubusercontent.com/BeanBagKing/198683e3206eb8885a1a20f6adb6e7e6/raw  
chmod 755 new_setup.sh  
./new_setup.sh

wget --quiet -O /usr/local/bin/decode.sh https://gist.githubusercontent.com/BeanBagKing/019252de635f8748d36e47ee2d57d3b1/raw
	chmod 755 /usr/local/bin/decode.sh



#Download 




#Create scripts to start TOR
service tor start
proxychains iceweasel



#Update Veil Evasion 3
cd /usr/share/Veil && git pull




#Update Exploit Pack
cd /usr/share/exploitpack && git pull





#Run Lynis
lynis audit system --quick



#Scan for printers with PRET https://github.com/RUB-NDS/PRET
echo Identify the printer you wish to attack and run "pret.py <IP Address> <printer language>". Available printer languages are PS (Postscript), PJL (Printer Job Language), and PCL (Printer Command Language).
./pret.py




#Start Nessus.
/etc/init.d/nessusd start
sleep 10s
firefox https://127.0.0.1:8834/


























