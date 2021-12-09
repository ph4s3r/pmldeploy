

mkdir -p ~/dev/pmldeploy & cd ~/dev/pmldeploy

git clone https://github.com/ph4s3r/pmldeploy.git

cd gomboc

echo "alias run=\"bash ~/dev/pmldeploy/run.sh\"" >> ~/.bashrc

source ~/.profile

sh deploy.sh

# The jupyter notebook can run with just hitting "run"

