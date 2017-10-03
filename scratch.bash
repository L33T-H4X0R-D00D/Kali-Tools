#Version 20171003.1

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






git clone https://github.com/DominikStyp/auto-reaver /root/Desktop/Scripts/tools/













#Download instructions for use from GIT.

wget -O new_setup.sh https://gist.githubusercontent.com/BeanBagKing/198683e3206eb8885a1a20f6adb6e7e6/raw  
chmod 755 new_setup.sh  
./new_setup.sh

wget --quiet -O /usr/local/bin/decode.sh https://gist.githubusercontent.com/BeanBagKing/019252de635f8748d36e47ee2d57d3b1/raw
	chmod 755 /usr/local/bin/decode.sh










