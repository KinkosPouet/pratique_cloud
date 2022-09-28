#!/bin/sh

set -e
set -u

USER=debian
HOSTNAME="$(hostname)"
ID=$(cat /etc/os-release | awk -F= '/^ID=/{print $2}' | tr -d '"')
VERS=$(cat /etc/os-release | awk -F= '/^VERSION_ID=/{print $2}' | tr -d '"')

export DEBIAN_FRONTEND=noninteractive
# Mettre à jour le catalogue des paquets debian
apt-get update --allow-releaseinfo-change

# Installer les prérequis pour ansible
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    vim \
    python3 \
    gnupg2 \
    fzf \
    software-properties-common \
    docker \
    docker.io \
    docker-compose

echo "SUCCESS"


