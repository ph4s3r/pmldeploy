#!/bin/sh

pidof systemd && sd="TRUE" || sd="FALSE"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "Working... ${RED}Please dont forget to open ports 20,21 and 30000->30100 for passive mode${NC}"
sudo apt install -y -qq vsftpd
# Making a backup of original config
sudo cp /etc/vsftpd.conf  /etc/vsftpd.conf_default

sudo echo "
seccomp_sandbox=NO
allow_writeable_chroot=YES
pasv_address=$(curl -s icanhazip.com.)
pasv_enable=Yes
pasv_min_port=30000
pasv_max_port=30100
port_enable=YES
write_enable=YES
listen_ipv6=NO
listen=YES" | sudo tee -a /etc/vsftpd.conf > /dev/null
# Launch and enable
if [ $sd = "TRUE" ]
then
  sudo systemctl start vsftpd
  sudo systemctl enable vsftpd
  sudo systemctl status vsftpd
else
  sudo service vsftpd start
  sudo service vsftpd status
fi


printf "${GREEN}connect to the ftp server and download directories with
${RED}wget -r -nH --cut-dirs=1 -nc ftp://gomboc:passwordhere@uvm.westeurope.cloudapp.azure.com/dev/pml_data
${GREEN}where
-nc: ignoring files that already exist at destination (even if the file is different)
-nH: Is for disabling creation of directory having name same as URL i.e. abc.xyz.com
--cut-dirs: Is for ignoring number of parent directories. The value of this option will differ for your command."

printf " Upload dirs with 
${RED}ncftpput -avR -u <user> -p<password> <ftpserver> <path to put> <local folder>
${GREEN}where,

a transfer all files in ASCII mode and not in binary.
v to see output in verbose mode
R to copy folders in recursive mode.
"
