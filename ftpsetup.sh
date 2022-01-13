#!/bin/sh

echo "Hi, please enter the external ip address to use (yes it is needed..) :"

read ip

echo "Working... Please don`t forget to open ports 20,21 and 30000->30100 for passive mode"

sudo apt install -y vsftpd

# Making a backup of original config

sudo cp /etc/vsftpd.conf  /etc/vsftpd.conf_default

vim /etc/vsftpd.conf

seccomp_sandbox=NO
allow_writeable_chroot=YES
pasv_address=$ip
pasv_enable=Yes
pasv_min_port=30000
pasv_max_port=30100
port_enable=YES
write_enable=YES
listen_ipv6=NO
listen=YES

:wq

# Launch and enable

sudo systemctl start vsftpd

sudo systemctl enable vsftpd

sudo systemctl restart vsftpd

echo "connect to the ftp server and download directories with wget -r -nH --cut-dirs=1 -nc ftp://gomboc:passwordhere@uvm.westeurope.cloudapp.azure.com/dev/pml_data/"

sudo systemctl status vsftpd
