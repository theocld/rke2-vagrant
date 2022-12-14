#!/bin/bash

echo "Accès à kubectl"
sudo cp /var/lib/rancher/rke2/bin/kubectl /usr/local/bin
sudo chmod +x /usr/local/bin/kubectl
sudo echo export PATH="/usr/local/bin:$PATH" >> .bashrc
source ~/.bashrc

echo "Installation helm"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "Activation du cluster"
sudo cp /etc/rancher/rke2/rke2.yaml $HOME
sudo chown $(id -u):$(id -g) $HOME/rke2.yaml
sudo echo export KUBECONFIG=$HOME/rke2.yaml >>.bashrc
source ~/.bashrc
