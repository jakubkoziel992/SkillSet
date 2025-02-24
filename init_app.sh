#!/bin/bash
set -e

export FLASK_ENV="${app_env}"
export DB_USER="${db_user}"
export DB_PASSWORD="${db_password}"
export DB_HOST="${db_host}"
export DB_NAME="${db_name}"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
export LOG_FILE=/home/ubuntu/skillset_init_$TIMESTAMP.log

cd /home/ubuntu

echo "Installing the required applications...." > $LOG_FILE 2>&1
sudo apt update -y
sudo apt install nginx-extras -y
sudo apt install python3 -y && sudo apt install python3-pip -y

[[ $? -eq 0 ]] && echo "Succesfully installed python and nginx" >> $LOG_FILE 2>&1




#clone repository
git clone https://github.com/jakubkoziel992/SkillSet.git && echo "Repository copied succesfully" >> $LOG_FILE 2>&1

cd ./SkillSet
#checkout on branch
git checkout aws-terraform

sudo cp ./nginx/default.conf /etc/nginx/sites-available/default && echo "Copied nginx configuration" >> $LOG_FILE 2>&1
sudo nginx -s reload
#cd /etc/nginx/sites-enabled
#sudo ln -s /etc/nginx/sites-available/default



#install requirements
cd ./app
pip install -r ./requirements.txt && echo "Installed python requirements" >> $LOG_FILE 2>&1



#start application
echo "Starting application" >> $LOG_FILE 2>&1
#gunicorn -c ../gunicorn.conf.py &> /home/ubuntu/gunicorn.log &
gunicorn -c ../gunicorn.conf.py  >> /dev/null 2>&1 &

if pgrep -x "gunicorn" >> $LOG_FILE; then
    echo "Application is working" >> $LOG_FILE
    exit 0
else
    echo "Application not working" >> $LOG_FILE
    echo "Restarting application" >> $LOG_FILE
    gunicorn -c ../gunicorn.conf.py  >> $LOG_FILE 2>&1 &
fi






