#!/bin/bash

echo "Importation du binaire server_rke2"
curl -sfL https://get.rke2.io | sudo sh -

echo "Configuration du server node"
cp config_server.yml config.yaml
sudo mkdir -p /etc/rancher/rke2
sudo cp $HOME/config.yaml /etc/rancher/rke2

echo "Installation du server"
sudo systemctl enable rke2-server.service
sudo systemctl start rke2-server.service
