#!/bin/bash

# This script has been tested on Ubuntu Server 21.10
# Git and python 3.9.7 should be installed by default

set -ex

echo "alias run=\"bash ~/dev/pmldeploy/run.sh\"" >> ~/.bashrc

mkdir -p ~/dev && cd ~/dev

git clone https://github.com/markowetzlab/pathml
git clone https://github.com/markowetzlab/pathml-tutorial

# Installing Anaconda to /opt/anaconda

sudo apt-get update
sudo apt-get install -y libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 tuptime

sudo curl -fsSL https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -o /opt/Anaconda3-2021.11-Linux-x86_64.sh

sudo chmod +x /opt/Anaconda3-2021.11-Linux-x86_64.sh

sudo sh /opt/Anaconda3-2021.11-Linux-x86_64.sh -b -p /opt/anaconda

alias "conda=/opt/anaconda/bin/conda" >> ~/.bashrc

alias conda=/opt/anaconda/bin/conda

conda env create -f ~/dev/pathml/pathml-environment.yml

conda init bash

# Shell needs to be restarted

source ~/.profile

conda activate pathml-env

# Disable auto-activate base env on startup, and auto-activate pathml-env
conda config --set auto_activate_base false
echo "conda activate pathml-env" >> ~/.bashrc

conda install -y -c conda-forge pyvips
conda install -y -c conda-forge notebook

# pathml setup

cd ~/dev/pathml
pip install -e .

# Create dir for the images
mkdir -p ~/dev/pathml-tutorial/wsi_data

# Updating the pathml path in the notebook

sed -i 's/\/path\/to\/pathml-tutorial\/Pytorch-UNet/.\/Pytorch-UNet/g' ~/dev/pathml-tutorial/pathml-tutorial.ipynb
sed -i 's/\/path\/to\/wsi_data/wsi_data/g' ~/dev/pathml-tutorial/pathml-tutorial.ipynb
# Check
cat ~/dev/pathml-tutorial/pathml-tutorial.ipynb | grep /dev/pathml

# Setup the pathml-env for jupyter notebook (other option is to change the kernel on the jupyter notebook gui)
python -m ipykernel install --user --name=pathml-env

jupyter trust ~/dev/pathml-tutorial/pathml-tutorial.ipynb

# do some cleanup

conda clean -a -y

# How to kill jupyter gracefully (sends SIGTERM )

# pkill jupyter



