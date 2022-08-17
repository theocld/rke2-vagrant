#!/bin/bash

echo "Importation des charts helm et creation de l'environement Rancher"
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl create namespace cattle-system

echo "Installation du gestionnaire de certificat"
kubectl create namespace cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.yaml
kubectl get -o yaml --all-namespaces \
issuer,clusterissuer,certificates,certificaterequests > cert-manager-backup.yaml
helm uninstall cert-manager
kubectl delete -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml
kubectl apply --validate=false -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.12.0

kubectl apply -f cert-manager-backup.yaml

echo "Installation de Rancher"
helm install rancher rancher-stable/rancher  \
  --namespace cattle-system \
  --set hostname=172.31.16.95.sslip.io \
  --set bootstrapPassword=admin
