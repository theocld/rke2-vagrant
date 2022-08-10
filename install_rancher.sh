#!/bin/bash

echo "Importation des charts helm et creation de l'environement Rancher"
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update

echo "Installation du gestionnaire de certificat"
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.7.1

echo "Installation de Rancher"
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=172.31.16.94.sslip.io \
  --set bootstrapPassword=admin
