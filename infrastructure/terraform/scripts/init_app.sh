#!/bin/bash
set -e

export FLASK_ENV="${app_env}"
export DB_USER="${db_user}"
export DB_PASSWORD="${db_password}"
export DB_HOST="${db_host}"
export DB_NAME="${db_name}"
export SECRET_KEY="${secret_key}"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
export LOG_FILE=/var/log/skillset_init_$TIMESTAMP.log

function log {
	if [[ -n $1 ]]; then
		echo "$1" | tee -a "$LOG_FILE"
		return 0
	fi
        while read -r line; do
                echo "$line" | tee -a "$LOG_FILE"
        done < "/dev/stdin"
}

if [[ ! -f $LOG_FILE ]]; then
    log "Creating log_file"
    sudo mkdir -m 600 $LOG_FILE | log
fi

cd /home/ubuntu

log "Installing the required applications...."
sudo apt update -y
sudo apt update -y && sudo apt install -y  python3 python3-pip

[[ $? -eq 0 ]] && log "Succesfully installed python"

#clone repository
git clone https://github.com/jakubkoziel992/SkillSet.git | log

#install requirements
cd ./SkillSet/app
pip install -r ./requirements.txt && log "Installed python requirements"


#start application
log "Starting application"
#gunicorn -c ../gunicorn.conf.py | log
gunicorn  | log

if pgrep -x "gunicorn" > /dev/null 2>&1; then
    log "Application is working"
    exit 0
else
    log "Application not working."
    log "Restarting application."
    gunicorn  | log
fi

log "Init script finished succesfully."