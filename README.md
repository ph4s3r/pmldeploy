

mkdir -p ~/dev/deployscript && cd ~/dev/deployscript
git clone https://github.com/ph4s3r/gomboc.git
cd gomboc

echo "alias run=\"bash ~/dev/pmldeploy/run.sh\"" >> ~/.bashrc
source ~/.profile

bash deploy.sh

# The jupyter notebook can run with just hitting "run"

