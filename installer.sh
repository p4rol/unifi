#!/bin/bash
 
# This script installs the unifi wifi controller on ubuntu 24.04

sudo apt update -y && sudo apt upgrade -y
sudo apt install openjdk-17-jre-headless -y
sudo apt-mark hold openjdk-17-jre-headless

wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb

curl https://pgp.mongodb.com/server-4.4.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg >/dev/null
echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list > /dev/null

sudo apt update -y

sudo apt install mongodb-org-server -y
sudo apt install curl -y

curl https://dl.ui.com/unifi/unifi-repo.gpg | sudo tee /usr/share/keyrings/ubiquiti-archive-keyring.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/ubiquiti-archive-keyring.gpg] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list > /dev/null

sudo apt update -y

sudo apt install unifi -y

systemctl status unifi
