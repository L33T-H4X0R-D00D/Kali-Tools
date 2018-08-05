Instructions
=
*Version 20180805*

Contents
=
- Introduction
- Using the GUI Shortcut
- Manually Launching PRET

Introduction
=
PRET (Printer Exploitation Toolkit) is a Python program developed by Jens Müller to discover and exploit vulnerabilities in USB and network printers. In Kali-Tools, we use PRET as a primary tool for vulnerability assesments and penetration tests on printers.

PRET's dependencies have been pre-installed during the `Kali-Setup.sh` script.  

A quicklaunch script is available on the desktop for easy access to the tool. 

Launching PRET with the GUI Shortcut
=
A shortcut has been created that allows you to launch directly into PRET. 
- Navigate to the directory `/Desktop/Scripts/Tools/PRET`
- Double click the `start.sh` file
- Enter the Target Printer's IP Address
- Enter the Desired Attack Language (This is case sensitive. You may enter "pcl","ps", or "pjl")

Once connected to the target device, you will be able to run PRET specific commands and attacks. A link to a full list of their commands is provided below.

Manually Launching PRET
=
An alias has been created for accessing PRET without having to enter the full path. Instead of having to type a long path each time, you can quickly access the tool by typing in just `pret` into a terminal and adding the required parameters which are outlined below.

The command `pret` is not complete by itself and requires the following additional information:
- Target IP address
- Desired Printing Control Language/Page Description Language (PJL,PCL,PS)

Here is an example of a complete PRET command using the provided alias, trying to access a printer on 192.168.1.200 via PCL.
```
pret 192.168.1.200 pcl
```
If the above command runs successfully and the host IP address is up, you should see a screen similar to this one:
```
  ________________
    _/_______________/|
   /___________/___//||   PRET | Printer Exploitation Toolkit v0.25
  |===        |----| ||    by Jens Mueller <jens.a.mueller@rub.de>
  |           |   ô| ||
  |___________|   ô| ||
  | ||/.´---.||    | ||        「 cause your device can be
  |-||/_____\||-.  | |´           more fun than paper jams 」
  |_||=L==H==||_|__|/

     (ASCII art by
     Jan Foerster)

Connection to 192.168.1.200 established
```
From there, you will be able to run PRET specific commands. A full list of commands are available on the main project's [repo](https://github.com/RUB-NDS/PRET)
