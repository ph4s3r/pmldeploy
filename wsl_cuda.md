############################################

Install Ubuntu 20.04 on WSL manually

Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing
Add-AppxPackage .\Ubuntu.appx

# if an error comes out on installing, then either try from MS Store or run

# wsl.exe --install -d Ubuntu

wsl --set-version Ubuntu-20.04 2

sudo apt update
sudo apt upgrade -y
git clone https://github.com/ph4s3r/pmldeploy

cd pmldeploy

############################################

CUDA on WSL # https://docs.nvidia.com/cuda/wsl-user-guide/index.html

1) need to have a distro running on wsl 2

	A) check wsl version # https://askubuntu.com/questions/1177729/wsl-am-i-running-version-1-or-version-2
	ver 
	wsl -l -v
	
	B) update the v1 distro to v2 # https://docs.microsoft.com/en-us/windows/wsl/install 
	wsl --set-version Ubuntu-20.04 2
	
	C) Ensure you are on the latest WSL Kernel or at least 4.19.121+. Once again we recommend 5.10.16.3 or later for better performance and functional fixes. 
	uname -a
	
2) Install cuda enabled nvidia driver from https://developer.nvidia.com/cuda/wsl/download
	file should look like 510.06_quadro_win11_win10-dch_64bit_international.exe
	
Note:This is the only driver you need to install. Do not install any Linux display driver in WSL.


############################################

Install Docker and run GPU accelerated containers

curl https://get.docker.com | sh
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
