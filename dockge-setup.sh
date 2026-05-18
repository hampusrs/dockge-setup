#!/bin/bash
# Shell script for setting up Dockge
echo "Enter username"
read USER

### Update to the latest packages ###
sudo apt update && sudo apt upgrade -y

### Install Docker ###

sudo apt install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

### Install Dockge ###
cd ~
mkdir -p dockge/stacks

cd ~/dockge

sudo docker run -d -p 5001:5001 --name Dockge --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v /home/$USER/dockge/dockge/data:/app/data -v /home/$USER/dockge/stacks:/home/$USER/dockge/stacks -e DOCKGE_STACKS_DIR=/home/$USER/dockge/stacks louislam/dockge:latest

docker compose up -d

### Set up Tailscale ###

curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

