

----------
![](images/1.png?raw=true)

Click "Applications", "Vulnerability Analysis", "openvas initial setup".

----------


![](images/2.png?raw=true)
The configuration will complete and provide you with the password for the OpenVAS admin account. Be sure to save this password as you will require it to log into OpenVAS.


----------






![](images/3.png?raw=true)
Browse to the local IP.  You may have to add an exception to your trusted sites. Login with the username "admin" and the password you saved in the previous step.



----------


![](images/4.png?raw=true)
Click "Configuration", "Scan Configs".

----------


![](images/5.png?raw=true)
Next to "Full and fast" click the orange sheep icon to clone the scan config.


----------


![](images/6.png?raw=true)
At the top of the screen click the blue wrench icon to edit the scan config settings.




----------



![](images/7.png?raw=true)
Rename the config from "clone" to something you will remember. Here I have appended the word "Printers" to the name.  Then click "Save".




----------


![](images/8.png?raw=true)
Click the wrench icon again.









----------


![](images/9.png?raw=true)
Scroll down in the scan config settings to the word "Settings", then click the blue wrench next to it.


----------


![](images/10.png?raw=true)
Uncheck the boxes next to the three entries shown above.  Then click "Save".





----------


![](images/11.png?raw=true)
![](images/12.png?raw=true)

Click the blue wrench icon next to "Global variable settings".

----------




![](images/13.png?raw=true)
Change the settings to "Enable generic web application scanning" to yes, "Exclude known fragile devices/ports from scan" to no, and "Exclude printers from scan" to no.  Then click "Save".




----------



![](images/14.png?raw=true)
Click "Save".

----------



![](images/15.png?raw=true)
Click "Save".





----------

![](images/16.png?raw=true)
Go to "Configuration", "Targets".



----------





![](images/17.png?raw=true)

Click the blue star icon in the top left corner of the page to create a new target.


----------


![](images/18.png?raw=true)
Create a name for the target.  Provide an IP address or IP address range for the target. Select "All TCP and Nmap 5.51 to 1000 UDP". Then click "Create".


----------



![](images/19.png?raw=true)
Go to "Scans", "Tasks".





----------


![](images/20.png?raw=true)
Click the blue star icon in the top left corner of the page to create a new scan.


----------



![](images/21.png?raw=true)
Give the scan a name. Select the scan target you created previously. Change "Alterable Task" to "yes".





----------

![](images/22.png?raw=true)
Select the scan config you created previously.  Click "Create".



----------


![](images/23.png?raw=true)
Click the green play icon to start your scan.






----------


