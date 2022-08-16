#!/bin/bash

echo "Importation des charts helm et creation de l'environement Rancher"
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl create namespace cattle-system

echo "Installation du gestionnaire de certificat"
kubectl create namespace cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml
kubectl delete ValidatingWebhookConfiguration --all
kubectl delete service cert-manager-webhook -n cert-manager

echo "Installation de Rancher"
helm install rancher rancher-stable/rancher  \
  --namespace cattle-system \
  --set hostname=172.31.16.95.sslip.io \
  --set bootstrapPassword=admin
