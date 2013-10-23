#!/bin/echo

if [ $# -eq 0 ]
then
  echo "No arguments supplied"
  return -1
fi

if [ -z "$1" ]
then
  echo "Missing first argument which is the environment name"
  return -1
fi

if [ -z "$2" ]
then
  echo "Mising second argument local/live"
  return -1
fi

V_ENV_NAME="$1"
ENV=$2
REQ_FILE="/Users/jaikirdatt/Development/Python/Django/shell/requirements/local_requirements.txt"
TEMPLATE="/Users/jaikirdatt/Development/Python/Django/template/itemplate"
APPTEMPLATE="/Users/jaikirdatt/Development/Python/Django/template/iapptemplate"

#Create the virtual environment
mkvirtualenv $V_ENV_NAME --no-site-packages

#workon the newly created environment
workon $V_ENV_NAME

if [ "$ENV" = 'local' ]
then
  #install requirements
  pip install -r $REQ_FILE
fi

if [ "$ENV" = 'live' ]
then
  
  #install live requirements
  REQ_FILE="/Users/jaikirdatt/Development/Python/Django/shell/requirements/live_requirements.txt"
  pip install -r $REQ_FILE
fi


echo "Enter 'Y' to create your django project here:"
pwd
read answer

if [ "$answer" = 'Y' ]
then

  #Create a directory for the project
  mkdir "$1"_project

  #Create the django project
  django-admin.py startproject "$1" --template=$TEMPLATE "$1"_project
  
  #Create the django app
  cd "$1"_project/"$1"
  python manage.py startapp "$1"app --template=$APPTEMPLATE
  
  #So we can run ./manage.py
  chmod 777 manage.py

  #init git
  cd ..
  git init
  
  #add and commit initial files
  git add *
  git commit -m "Initial commit"

  #Create postgres user
  echo "Creating a new postgres superuser:" $1
  createuser "$1" --superuser --pwprompt

  #Create a new database
  createdb "$1" --owner "$1"
  echo "postgres database created:" $1

fi



