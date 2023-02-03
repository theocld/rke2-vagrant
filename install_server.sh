#!/bin/bash

echo "Importation du binaire server_rke2"
curl -sfL https://get.rke2.io | sudo sh -

echo "Configuration du server node"
cp config_server.yaml config.yaml
prv_ip=$(ip a s eth0 | egrep -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d' ' -f2)
pub_ip=$(ip a s eth1 | egrep -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d' ' -f2)
sudo cat >> config.yaml << EOF
tls-san:
- $prv_ip
- $pub_ip
EOF

sudo mkdir -p /etc/rancher/rke2
sudo cp $HOME/config.yaml /etc/rancher/rke2

echo "Installation du server"
sudo systemctl enable rke2-server.service
sudo systemctl start rke2-server.service
