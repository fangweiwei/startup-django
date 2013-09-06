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

#Create the virtual environment
mkvirtualenv $ENV_NAME --no-site-packages

#workon the newly created environment
workon $ENV_NAME

#install requirements
pip install -r $REQ_FILE



