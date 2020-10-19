#!/bin/bash

SUIDLIST=$(find / -type f -perm /4000 2>/dev/null)
OUTPUTFILE=~/research/sysinfo.txt
IPADDR=$(hostname -I | cut -f1 -d" ")

if [ $UID -ne 0 ]
then
   echo "Please run this as root."
exit
fi

if [ ! -d ~/research ]
then
   mkdir ~/research
   echo "created ~/research"
else
   echo "~/research already exists, moving along..."
fi

if [ ! -f ~/research/sysinfo.txt ]
then
   echo "~/research/sysinfo.txt doesn't exist, moving along..."
else
   rm ~/research/sysinfo.txt
   echo "~/research/sysinfo.txt removed"
fi
#
#
#
echo -e "\n###################################" >> $OUTPUTFILE
echo "Activity File Shell Script - " >> $OUTPUTFILE
date >> $OUTPUTFILE
echo -e "\n###################################" >> $OUTPUTFILE
echo -e "\n----------" >> $OUTPUTFILE
echo -e "\nUNAME info: " >> $OUTPUTFILE
uname -a >> $OUTPUTFILE
echo -e "\n----------" >> $OUTPUTFILE
echo -e "\nIP address: $IPADDR" >> $OUTPUTFILE
echo -e "\n----------" >> $OUTPUTFILE
echo -e "\nHostname: $HOSTNAME" >> $OUTPUTFILE
echo -e "\n----------" >> $OUTPUTFILE
echo -e "\nDNS servers: " >> $OUTPUTFILE
cat /etc/resolv.conf | tail -1 >> $OUTPUTFILE
echo -e "\n----------" >> $OUTPUTFILE
echo -e "\nMemory info: " >> $OUTPUTFILE
free -m >> $OUTPUTFILE
echo -e "\n----------" >> $OUTPUTFILE
echo -e "\nCPU info: " >> $OUTPUTFILE
lscpu | grep CPU >> $OUTPUTFILE
echo -e "\n----------" >> $OUTPUTFILE
echo -e "\nDisk usage: " >> $OUTPUTFILE
df -H | head -4 >> $OUTPUTFILE
echo -e "\n----------" >> $OUTPUTFILE
echo -e "\nCurrently logged on users: \n $(users)" >> $OUTPUTFILE
echo -e "\n----------" >> $OUTPUTFILE
echo -e "\nSUID files: " >> $OUTPUTFILE
echo "$SUIDLIST" >> $OUTPUTFILE
#find / -type f -perm /4000 2>/dev/null >> $OUTPUTFILE
echo -e "\n----------" >> $OUTPUTFILE
echo -e "\nTop 10 Processes:" >> $OUTPUTFILE
ps -aux --sort -%mem | head >> $OUTPUTFILE
echo "Ran successfully."
