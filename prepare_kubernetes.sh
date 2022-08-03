#!/bin/bash

echo "Accès à kubectl"
sudo cp /var/lib/rancher/rke2/bin/kubectl /usr/local/bin
sudo chmod +x /usr/local/bin/kubectl
sudo echo export PATH="/usr/local/bin:$PATH" >> .bashrc
source ~/.bashrc

echo "Activation du cluster"
sudo cp /etc/rancher/rke2/rke2.yaml $HOME
sudo chown $(id -u):$(id -g) $HOME/rke2.yaml
export KUBECONFIG=$HOME/rke2.yaml
