#! /bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y install jq nodejs npm s3cmd

npm i

# if u r on the server
# crontab -e
# @reboot cd /home/user/2023-data_export_from-ftp-to-json && git pull && ./src/handler.sh
# @reboot cd /home/user/2023-data_export_from-ftp-to-json && git pull && S3_BUCKET=ftp-to-json ./src/handler.sh

