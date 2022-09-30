# rke2-vagrant
Autonomous deployment of kubernetes using Vagrant Vm's and Rke2 Distribution

## Install dependencies 
```bash
sudo apt update
sudo apt install vagrant
sudo apt install git-all
```

## VM Setup

| Parameter        | Description           | 
| ------------- |:-------------:| 
| provider | VM provider (libvirt, virtualbox, vmware, ...) | 
| role | Role of the node (master, master_ha, worker, load_balancer)      |   
| name |  Name of the node  |   
| box | Vagrant box = [OS](https://app.vagrantup.com/boxes/search) of the node |
| memory | Amount of memory in bytes |
| cpu | Amount of CPU|
| ip (master) | Private IP of the master|
