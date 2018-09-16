# Kali-Tools
=
*Version 20180625.2*    
This is an auto configuration script for the 64 bit Kali VM provided by offensive security found [here](https://www.offensive-security.com/kali-linux-vmware-virtualbox-image-download/). This script installs and configures frequently used tools, and creates a directory on the desktop with common instructions and scripts for ease of use. The main goal was to configure a fresh Kali VM while avoiding the common pitfalls normally associated with such an endeavor.


----------
To get started:

 1. Cut and paste the setup command in a terminal window.
 2. Confirm Firefox is closed.
 3. Execute command from step 1.
 4. Firefox will open to the Java download page.  Download the appropriate version (usually "Linux x64), then close firefox.
 5. Firefox will open to the Tenable download page.  Download the appropriate version (usually "Linux -> Debian/Kali AMD64), then close firefox.
 6. Firefox will open to the GoPhish download page.  Download the appropriate version (usually "gophish xxx linux 64bit.zip), then close firefox.
 7. Occasionally during the install you may be asked to confirm settings in the terminal window where these options cannot be preset in the script.  As of 2017-10-3 there are only 2 instances where this occurs.  As such this is not a completely unattended configuration.
 8. Once complete the script will show "Setup Complete!"

----------


Setup command:
>wget https://raw.githubusercontent.com/L33T-H4X0R-D00D/Kali-Tools/master/kalisetup.sh && chmod +x ./kalisetup.sh && ./kalisetup.sh

----------

**If you wish to configure OpenVAS for scanning printers, follow the instructions in this [link](printer/config.md) once the script above is complete.**

**Note:** This is still a draft and does not follow *any* best practices whatsoever. I know there are better ways to do things.  I'm sure your way is very clever.  I'm publishing this to make my life easier when I have to rebuild a Kali VM and in some circumstances it may be used by people who are not overly familiar with GNU/Linux.  It must be very easy to troubleshoot since I will likely be doing it over the phone.  I'm always open to new ways to do something so please send me your comments.


----------
**Tool credits**    
Varmascan: *A multi-target WPS pin harvester from the [MusketTeam](https://github.com/musket33/varmacscan)*.    
Auto-reaver: *A multi-target WPS pin harvester from [DominikStyp](https://github.com/DominikStyp/auto-reaver)*.    
i8igmac-reaver: *A multi-target WPS pin harvester from [i8igmac](https://forums.hak5.org/topic/34617-how-to-reaver-dropbox-raspberry-pi/)*.    