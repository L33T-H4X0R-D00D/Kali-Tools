#!/bin/bash
#Version 20170912.1
#This script assumes you're logged in as root using the Kali 2017.2 VM provided by Offensive Security here: https://www.offensive-security.com/kali-linux-vmware-virtualbox-image-download/.
#A browser will be opened to the Java, and Nessus download page allowing you to pick which version to install.
#After the download is complete the script will complete the install from the downloads directory.
#This script is setup to make it easy to comment out the components you do not wish to install, not be the most efficient use of space.
#This script creates a directory on the desktop with scripts that update tools, scripts that run tools, and some basic instructions for tools.


#Create directory structure.
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

#Create directory structure.
mkdir /root/Desktop/Scripts && mkdir /root/Desktop/Scripts/instructions && mkdir /root/Desktop/Scripts/tools && mkdir /root/Desktop/Scripts/update

#Java download.
firefox http://www.java.com/en/download/linux_manual.jsp

#Nessus download.
firefox http://www.tenable.com/products/nessus/select-your-operating-system

#GoPhish download.
firefox https://github.com/gophish/gophish/releases

#Install Java without modifying sources.
cd /root/Downloads/
tar -zxvf jre*.tar.gz
rm jre*.tar.gz
mv jre* /opt
cd /opt/jre*
update-alternatives --install /usr/bin/java java /opt/jre*/bin/java 1
update-alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.s­o mozilla-javaplugin.so /opt/jre*/lib/amd64/libnpjp2.so 1
update-alternatives --set java /opt/jre*/bin/java
update-alternatives --set javac /opt/jre*/bin/javac
update-alternatives --set mozilla-javaplugin.so /opt/jre*/lib/amd64/libnpjp2.so
java -version
sleep 10s

#Roll SSH keys
cd /etc/ssh/ && mkdir old #Move to the SSH directory and make a new directory for the old keys.
mv ssh_host_* old #Move the original keys to the old directory.
dpkg-reconfigure openssh-server #Create new SSH keys.

#Update system and install tools.
apt update && apt upgrade -y && apt dist-upgrade -y
apt install tor -y
apt install filezilla filezilla-common -y
apt install alien rpm nsis openvas -y
apt install htop nethogs gdebi git bleachbit clamav -y #System utilities.
apt install python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential -y #For pwntools.



#Perform initial OpenVAS setup.
openvas-mkcert
openvas-mkcert-client -n -i
#Update OpenVAS NVT, CERT, and SCAP data.
greenbone-nvt-sync
greenbone-certdata-sync
greenbone-scapdata-sync
#Start OpenVAS services and create DB.
systemctl start openvas-scanner
openvasmd --rebuild --progress
openvasmd --create-user=admin --role=Admin --new-password=toor #Create new openvas user of "admin" with a password of "toor".
openvassd
openvasmd
gsad
openvas-check-setup
sleep 10s

#Create OpenVAS startup script
mkdir /root/Desktop/Scripts/tools/openvas/
echo '#!/bin/bash' >> /root/Desktop/Scripts/tools/openvas/start.sh
echo openvassd >> /root/Desktop/Scripts/tools/openvas/start.sh
echo openvasmd >> /root/Desktop/Scripts/tools/openvas/start.sh
echo gsad >> /root/Desktop/Scripts/tools/openvas/start.sh
echo greenbone-nvt-sync >> /root/Desktop/Scripts/tools/openvas/start.sh
echo greenbone-certdata-sync >> /root/Desktop/Scripts/tools/openvas/start.sh
echo greenbone-scapdata-sync >> /root/Desktop/Scripts/tools/openvas/start.sh
echo openvas-check-setup >> /root/Desktop/Scripts/tools/openvas/start.sh
echo sleep 10s >> /root/Desktop/Scripts/tools/openvas/start.sh
echo firefox https://127.0.0.1/l >> /root/Desktop/Scripts/tools/openvas/start.sh
chmod +x /root/Desktop/Scripts/tools/openvas/start.sh

#Install Nessus
gdebi -n /root/Downloads/Nessus*.deb

#Create Nessus startup script
mkdir /root/Desktop/Scripts/tools/nessus/
echo '#!/bin/bash' >> /root/Desktop/Scripts/tools/nessus/start.sh
echo /etc/init.d/nessusd start  >> /root/Desktop/Scripts/tools/nessus/start.sh
echo firefox https://127.0.0.1:8834/  >> /root/Desktop/Scripts/tools/nessus/start.sh
chmod +x /root/Desktop/Scripts/tools/nessus/start.sh

#Fix any broken installs.
apt install -f && apt autoremove && apt autoclean #Cleanup


#Install Exploit Pack.
git clone https://github.com/juansacco/exploitpack.git /usr/share/exploitpack

#Create Exploit Pack startup script.
mkdir /root/Desktop/Scripts/tools/exploitpack/
echo '#!/bin/bash' >> /root/Desktop/Scripts/tools/exploitpack/start.sh
echo cd /usr/share/exploitpack >> /root/Desktop/Scripts/tools/exploitpack/start.sh
echo java -jar ExploitPack.jar >> /root/Desktop/Scripts/tools/exploitpack/start.sh
chmod +x /root/Desktop/Scripts/tools/exploitpack/start.sh


#Install Veil Evasion 3.
git clone https://github.com/Veil-Framework/Veil.git /usr/share/Veil
cd /usr/share/Veil/setup
#./setup.sh -s
./setup.sh -c


#Install GoPhish
cd /root/Downloads
unzip 'gophish-*.zip' -d /usr/share/
cd /usr/share/gophis*
chmod 755 ./gophish



#Create GoPhish startup script and credentials document.
mkdir /root/Desktop/Scripts/tools/gophish/
echo './gophish & firefox https://localhost:3333 &' >> /root/Desktop/Scripts/tools/gophish/start.sh
echo Username: admin  >> /root/Desktop/Scripts/tools/gophish/login.txt
echo Password: gophish >> /root/Desktop/Scripts/tools/gophish/login.txt


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


















