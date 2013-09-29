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
  echo "Mising second argument which is the name of the requirements file"
  return -1
fi

ENV_NAME="$1"
REQ_FILE="$2"
TEMPLATE="/Users/jaikirdatt/Development/Python/Django/template/itemplate"
APPTEMPLATE="/Users/jaikirdatt/Development/Python/Django/template/iapptemplate"

#Create the virtual environment
mkvirtualenv $ENV_NAME --no-site-packages

#workon the newly created environment
workon $ENV_NAME

#install requirements
pip install -r $REQ_FILE

echo "Enter 'Y' to create your django project here:"
pwd
read answer

if [ "$answer" = 'Y' ]
then
  mkdir "$1"_project
  django-admin.py startproject "$1" --template=$TEMPLATE "$1"_project
  cd "$1"_project/"$1"
  python manage.py startapp "$1"app --template=$APPTEMPLATE
fi



