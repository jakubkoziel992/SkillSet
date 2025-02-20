#!/bin/bash
export FLASK_ENV="${app_env}"
export DB_USER="${db_user}"
export DB_PASSWORD="${db_password}"
export DB_HOST="${db_host}"
export DB_NAME="${db_name}"

sudo apt update -y
sudo apt install python3 -y && sudo apt install python3-pip -y

#clone repository
git clone https://github.com/jakubkoziel992/SkillSet.git

cd Skillset

#checkout on branch
git checkout aws-terraform

#install requirements
pip install -r ./app/requirements.txt

#start application
python3 ./app/app.py



