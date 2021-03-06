#!/bin/bash

# This script installs and configures local copy of ChEMBL webservices on
# myChEMBL VM.
# Author: Michal Nowotka, mnowotka@ebi.ac.uk
# Created date: 20.05.2014

# We need indigo toolkit as alternative compound rendering engine:
wget https://dl.dropboxusercontent.com/u/10967207/indigo-python-1.1.11-linux.zip
unzip indigo-python-1.1.11-linux.zip
rm indigo-python-1.1.11-linux.zip

# Install and source virtualenvwrapper because it makes our job lot easier:
echo "chemblvm" | sudo -S pip install virtualenvwrapper
source virtualenvwrapper.sh

# Use the wrapper to create new virtualenv called chembl_webservices
mkvirtualenv chembl_webservices

# Lxml runs faster when Cyhton is available:
pip install Cython

# OK, we are ready to use pip to install chembl_webservices
pip install chembl_webservices

# Because webservices on myChEMBL VM will be run against exported CHEMBL schema,
# which is only a subset of chembl_app schema we will have to install
# a compatibility layer that can handle differences between schemas:
pip install chembl_compatibility

# webservices are DB agnostic so they are not shipped with any specific DB
# driver. We have to install the driver separately, in case of myChEMBL this
# will be postgres:
pip install psycopg2

# we want our application to support CORS so we have to install django app
# which will handle this:
pip install django-cors-headers

# OK, now we are ready to configure our webservices django app.
# First, lets create new django project:
cd /home/chembl
mkdir chembl_webservices
cd chembl_webservices/
django-admin.py startproject deployment

# Now we have to download configuration files:
RAW=https://raw.githubusercontent.com/chembl/mychembl/master/webservices/conf

curl $RAW/settings.py > deployment/deployment/settings.py
curl $RAW/urls.py > deployment/deployment/urls.py
curl $RAW/wsgi.py > deployment/deployment/wsgi.py
curl $RAW/chembl_webservices.inc > deployment/deployment/chembl_webservices.inc

# Lets configure cache by creating DB table for storing the cache:
cd deployment
python manage.py createcachetable ws_cache

# We should also take care about places to store static files and logs:
mkdir deployment/static
mkdir deployment/logs

# We can collect static files now:
python manage.py collectstatic --noinput --clear





