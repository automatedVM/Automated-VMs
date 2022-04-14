Prerequisets:
- Run PowerShell as an Administrator
- VMware® Workstation 16 Pro, Version: 16.2.3 build-19376536
- Modify network IPs/subnet based on your desires 

Please be in Vagrant folder and execute the below commands in PowerShell:

#Build Splunk:
Vagrant up logger

#Build Elk:
Vagrant up elk

#Build DC:
Vagrant up dc

#Build WEF:
Vagrant up wef

#Build Exchange:
Vagrant up exchange

#Build Win10:
Vagrant up win10