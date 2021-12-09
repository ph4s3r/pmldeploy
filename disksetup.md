
# Attaching a new disk

# Find the drive letter
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"

# Assuming it is sdc

sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs /dev/sdc1
sudo partprobe /dev/sdc1

# Mount

sudo mkdir /datadrive
sudo mount /dev/sdc1 ~/dev/pathml-tutorial/wsi_data/

# Add UUID to fstab

sudo vim /etc/fstab

# Add UUID=33333333-3b3b-3c3c-3d3d-3e3e3e3e3e3e   /datadrive   xfs   defaults,nofail   1   2
# With the proper UUID

# Source:
# https://docs.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal

# Give permissions (needs to be done after adding files as well if vsftpd umask is set to default 022)

sudo chmod -R 777 ~/dev/pathml-tutorial/wsi_data/
