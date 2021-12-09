#!/bin/bash

set -ex

# Firing up an ftp server

sudo apt install -y vsftpd

# Making a backup of original config

sudo cp /etc/vsftpd.conf  /etc/vsftpd.conf_default

# Add settings to /etc/vsftpd.conf

# Need to change the IP for pasv_address!!!

seccomp_sandbox=NO
allow_writeable_chroot=YES
pasv_address=20.79.248.253
pasv_enable=Yes
pasv_min_port=30000
pasv_max_port=30100
port_enable=YES
write_enable=YES

# Enable ports 20,21 and 30000->30100 on Azure

# Launch and enable

sudo systemctl start vsftpd

sudo systemctl enable vsftpd

sudo systemctl restart vsftpd

# Copy files into ~/dev/pathml-tutorial/wsi_data