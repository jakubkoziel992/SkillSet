#!/bin/bash

DB_HOST=${DB_HOST}
DB_PORT=3306

#Check if mysql has started
while ! nc -zv $DB_HOST $DB_PORT > /dev/null 2>&1 ;
do
  echo "Waiting for MYSQL Database Startup" && sleep 15
done


# Start application
exec gunicorn
