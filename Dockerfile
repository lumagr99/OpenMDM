FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

# Update der Paketliste und Installation von Python 3.11 und curl
RUN apt-get update && apt-get install -y \
    software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y \
    python3.11 \
    python3.11-dev \
    python3.11-distutils \
    build-essential \
    curl \
    gnupg \
    wget \
    git \
    libssl-dev \
    libffi-dev \
    default-libmysqlclient-dev \
    libldap2-dev \
    libsasl2-dev

# Setze Python 3.11 als Standardversion für 'python3'
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Lade das get-pip.py-Skript herunter und installiere pip für Python 3.11
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

# Aufräumen von APT-Caches
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Erstelle ein Verzeichnis für das Projekt
WORKDIR /opt

# Kopiere die Daten aus dem lokalen /repo Ordner ins Docker-Image
COPY repo /opt/OpenMDM

# Wechsle in das Verzeichnis des kopierten Projekts
WORKDIR /opt/OpenMDM

# Windows Umbrüche entfernen
RUN sed -i 's/\r$//' configure.sh

# Setze die Ausführungsberechtigung für das Konfigurationsskript
RUN chmod +x configure.sh

# Installiere benötigte Python-Pakete mit pip
RUN pip3 install --no-cache-dir \
    setuptools==57.5.0 \
    mysqlclient==2.1.0 \
    django==2.2.7 \
    django-bootstrap4 \
    django_forms_bootstrap \
    django-admin-bootstrapped \
    django-auth-ldap==2.2.0 \
    python-ldap \
    pymongo==3.11.0 \
    mongoengine==0.21.0

# Kopiere das Initialisierungsskript für MongoDB
COPY init-mongo.js /docker-entrypoint-initdb.d/

# Exponiere den Port 8000 für Django
EXPOSE 8000

# Befehl zum Starten des Django-Servers
CMD ./configure.sh && python3 manage.py runserver "0.0.0.0:8000"
