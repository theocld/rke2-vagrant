#!/bin/bash

echo "Désactivation du apparmor, du firewalld et du swap"

sudo systemctl disable apparmor.service
sudo systemctl stop ufw
sudo systemctl disable ufw
sudo systemctl stop apparmor.service
sudo systemctl disable swap.target
sudo swapoff -a
