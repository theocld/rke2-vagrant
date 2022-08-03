#!/bin/bash

echo "Importation du binaire agent_rke2"
curl -sfL https://get.rke2.io | sudo INSTALL_RKE2_TYPE="agent" sh -

echo "Configuration de l'agent node"
cp config_agent.yaml config.yaml
sudo mkdir -p /etc/rancher/rke2
sudo cp $HOME/config.yaml /etc/rancher/rke2

echo "Installation de l'agent"
sudo systemctl enable rke2-agent.service
sudo systemctl start rke2-agent.service