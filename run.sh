#!/bin/bash

# set -ex

# Starting jupyter host

if pgrep "jupyter" > /dev/null
then
    	echo "Jupyter notebook is already running"
else
	jupyter notebook --ip=0.0.0.0 --port=8888 --notebook-dir ~/dev/pathml-tutorial &
	sleep 5
fi


# Copy the notebook link with the token, combine with external ip:
echo "IP for public access:
echo http://$(curl -s icanhazip.com.):$(jupyter notebook list | grep http | awk '{print $1}' | awk '{split($0,a,":"); print a[3]}')
echo "IP for local access:"
echo http://127.0.0.1:$(jupyter notebook list | grep http | awk '{print $1}' | awk '{split($0,a,":"); print a[3]}')

