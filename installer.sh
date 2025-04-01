#!/bin/bash

# Script: Install UniFi Network Controller on Ubuntu 24.04
# Author: [Your Name/Organization]
# Date: 2024-10-27
# Description: This script automates the installation of the UniFi Network Controller on Ubuntu 24.04.

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update -y && sudo apt upgrade -y

# Install OpenJDK 17 JRE (Headless)
echo "Installing OpenJDK 17 JRE (headless)..."
sudo apt install openjdk-17-jre-headless -y

# Hold OpenJDK 17 JRE to prevent automatic upgrades that might break UniFi
echo "Holding OpenJDK 17 JRE to prevent automatic upgrades..."
sudo apt-mark hold openjdk-17-jre-headless

# Install libssl1.1 (required for older UniFi versions)
echo "Installing libssl1.1..."
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb

# Add MongoDB 4.4 repository key
echo "Adding MongoDB 4.4 repository key..."
curl https://pgp.mongodb.com/server-4.4.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg >/dev/null

# Add MongoDB 4.4 repository
echo "Adding MongoDB 4.4 repository..."
echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list > /dev/null

# Update package lists after adding repositories
echo "Updating package lists..."
sudo apt update -y

# Install MongoDB 4.4 server
echo "Installing MongoDB 4.4 server..."
sudo apt install mongodb-org-server -y

# Install curl (if not already present)
echo "Installing curl..."
sudo apt install curl -y

# Add UniFi repository key
echo "Adding UniFi repository key..."
curl https://dl.ui.com/unifi/unifi-repo.gpg | sudo tee /usr/share/keyrings/ubiquiti-archive-keyring.gpg >/dev/null

# Add UniFi repository
echo "Adding UniFi repository..."
echo 'deb [signed-by=/usr/share/keyrings/ubiquiti-archive-keyring.gpg] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list > /dev/null

# Update package lists after adding UniFi repository
echo "Updating package lists..."
sudo apt update -y

# Install UniFi Network Controller
echo "Installing UniFi Network Controller..."
sudo apt install unifi -y

# Check UniFi service status
echo "Checking UniFi service status..."
systemctl status unifi

echo "UniFi Network Controller installation complete."
