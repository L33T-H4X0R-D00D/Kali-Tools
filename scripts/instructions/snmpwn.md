Instructions
=
*Version 2018073118*

Contents
=
- Introduction
- How to add a host (target) with addhost.sh
- How to run SNMPWN with runsnmpwn.sh
- Advanced Instructions

Introduction
=
SNMPWN is an SNMP User/Password enumeration tool. In this use case, SNMPWN is leveraged to ensure a device is online, that the user exists, and then tries to brute force the password. The results can be used in different attacks and utilized in other scripts within the Kali Tools package.

This takes place across all three different SNMP authentication methods: 
- noauthNopriv
- authnoPriv
- authPriv

Using SNMPWN is fairly straightforward, and we have created additional scripts that are automatically built into the Kali-Tools main package to simplify things for those not fully comfortable with GNU/Linux.

The two scripts included can be found under the `Scripts` folder on the desktop. The full path is `Desktop/Scripts/Tools/snmpwn` 

The included scripts are as follows:
- `addhost.sh`
- `runsnmpwn.sh`

How to use addhost.sh
=
`addhost.sh` is a script that is added to the tools folder during the Kali-Tools main install. It provides the ability to add different host IP addresses for targets of the SNMPWN tool. When installing Kali-Tools, you will be asked to provide a target IP address for SNMPWN to try attacking. Should the need arise to add additional hosts later, this script will allow you a simple and interactive way to do so.

Once you have navigated to the `Scripts/Tools` directory on the desktop, simply run `addhost.sh` inside the terminal and follow the on-screen instructions. Once the IP address has been added, you will receive a message that adding the IP was successful. The script will prompt you again for adding additional IP addresses. You may repeat this process as many times as needed.

Technical Details about addhost.sh
=
SNMPWN has several files that it uses for its data feed. The file targeted by `addhost.sh` is the Hosts file, located under `usr/share/snmpwn`

Any IP addresses listed in the `hosts.txt` file will be probed by SNMPWN.
You can manually edit that file to add or remove hosts/targets if needed.

How to use runsnmpwn.sh
=
Navigate to `/Desktop/Scripts/Tools/` and double click `runsnmpwn.sh`. Select the "Run in Terminal" option. This script will run the actual SNMPWN tool, using the following dependent files:
- hosts.txt
- users.txt
- passwords.txt

If any of the username and password combinations are successful in gaining access, they will be listed in the report shown when the script is finished. Be sure to copy out and save this data as there is currently no report export option.

Advanced Instructions
=
To run SNMPWN manually, ensure that you're in the correct directory, which is `/usr/share/snmpwn` by default and run the following command in the terminal:
```
./snmpwn.rb -h hosts.txt -u users.txt -p passwords.txt -e passwords.txt
```
As listed before, the dependent files are located under `usr/share/snmpwn`

The users and passwords files come pre-filled with common usernames and passwords. You can edit these or add on your favorite dictionary for more brute force combinations. The hosts file can be filled out with entire network ranges, subnets, or single IP addresses.
