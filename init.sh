#!/bin/bash

# this is a simple initialization script for cluster environment. 
# just some dependencies and useful tools in order for things to work properly. 
# the target OS is RHEL/Rocky Linux 10.1 or later

set -euxo pipefail

echo "Initializing cluster environment..."


# dependencies 
sudo dnf install -y epel-release

sleep 2

sudo /usr/bin/crb enable

sleep 1

echo "Installing dependencies..."
sudo dnf install -y \
    git \
    python3.13-pip \
    python3.13 \
    perl \
    uv \
    ansible-core \
    ansible-collection-ansible-posix \
    ansible-collection-community-general \
    ansible-collection-containers-podman

echo "creating directories"

mkdir -p $HOME/Documents/code
mkdir -p $HOME/apps/lmod
mkdir -p $HOME/apps/main/bin
mkdir -p $HOME/apps/main/lib
mkdir -p $HOME/apps/main/include
mkdir -p $HOME/apps/main/lib64
mkdir -p $HOME/apps/main/share


echo "done"
exit 0
