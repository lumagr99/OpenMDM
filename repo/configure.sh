#!/bin/bash

PYTHON3_DEFAULT_PATH=$(which python3)

echo -ne "Please enter the path to Python 3.4 "

if [ ! -z ${PYTHON3_DEFAULT_PATH} ]
then
    echo -ne "[default ${PYTHON3_DEFAULT_PATH}] "
fi
read PYTHON3_PATH
if [ -z ${PYTHON3_PATH} ]
then
    PYTHON3_PATH=${PYTHON3_DEFAULT_PATH}
fi
CHECK_VERSION=$(${PYTHON3_PATH} -c 'import sys; print(sys.version_info[:2])' 2>/dev/null)

if [ "${CHECK_VERSION}" != "(3, 10)" ]
then
    echo "Python version: ${CHECK_VERSION}"
    echo  "Invalid Python interpreter, version 3.4 required"
    exit -1
fi
SITE_PACKAGE=$(${PYTHON3_PATH} -c 'import site; print(site.getsitepackages()[0])')

# start mariadb (service mariadb start)
# echo "Starting MariaDB ..."
# service mysql start

# Run Django migrations and create tables
echo "Creating tables ..."
${PYTHON3_PATH} manage.py makemigrations public_gate
${PYTHON3_PATH} manage.py migrate

# Create a superuser non-interactively
echo "Creating super user..."
${PYTHON3_PATH} manage.py createsuperuser
