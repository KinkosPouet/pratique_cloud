#!/bin/sh

set -e
set -u

USER=debian
HOSTNAME="$(hostname)"
ID=$(cat /etc/os-release | awk -F= '/^ID=/{print $2}' | tr -d '"')
VERS=$(cat /etc/os-release | awk -F= '/^VERSION_ID=/{print $2}' | tr -d '"')

export DEBIAN_FRONTEND=noninteractive
apt-get update --allow-releaseinfo-change
apt-get install -y \
   # Mettre à jour le catalogue des paquets debian
apt-get update --allow-releaseinfo-change

# Installer les prérequis pour ansible
apt-get install -y \
    apt-transport-https \
    ca-certificates \
	git	\
    curl \
    wget \
    vim \
    python3
	
# Installation ansible

apt-get install -y \
	ansible

# Installing asdf
 su - $USER -c "rm -rf ~/.asdf"
 su - $USER -c "git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0"
 su - $USER -c "echo '. \$HOME/.asdf/asdf.sh' >> ~/.bashrc"

 su - $USER -c "source \$HOME/.asdf/asdf.sh && asdf plugin add terraform"
 su - $USER -c "source \$HOME/.asdf/asdf.sh && asdf install terraform latest"
 su - $USER -c "source \$HOME/.asdf/asdf.sh && asdf global terraform latest"

# git clone du projet 
git clone https://github.com/KinkosPouet/pratique_cloud.git

echo "SUCCESS"


