# rke2-vagrant
Autonomous deployment of kubernetes using Vagrant Vm's and Rke2 Distribution.

## Install dependencies and import the project
```bash
sudo apt update
sudo apt install vagrant
sudo apt install git-all
git clone https://github.com/theocld/rke2-vagrant.git
cd rke2-vagrant
```
## Deploy your kubernetes cluster
If you want a default 3 nodes cluster ( 1 master 2 workers), you can now run this command to deploy your virtual infrastructure and automatically install kubernetes on it. But if you prefer to customize your cluster first, follow the next steps before running vagrant up.

```bash
sudo vagrant up
```

## VM Setup
Modify the config.yaml file to configure the virtual infrastructure (Use Vim for example). Each dash corresponds to a machine. Duplicate or delete the key/value blocks according to your wishes.

| Parameter        | Description           | 
| ------------- |:-------------:| 
| provider | VM provider (libvirt, virtualbox, vmware, hyperv) | 
| role | Role of the node (master, master_ha, worker, load_balancer)      |   
| name |  Name of the node  |   
| box | Vagrant box = [OS](https://app.vagrantup.com/boxes/search) of the node |
| memory | Amount of memory in bytes |
| cpu | Amount of CPU|
| ip (master) | Private IP of the master|

## Configure rke2 server node 
Modify the config_server.yml file to configure your master(s). The list of existing parameters and their possible values can be found on this [link](https://docs.rke2.io/reference/server_config).

#### Exemple of config_server.yml :

```
write-kubeconfig-mode: "0644"
tls-san:
  - "foo.local"
node-label:
  - "foo=bar"
  - "something=amazing"
```
## Configure rke2 agent node
Same way with config_agent.yml. Check this [link](https://docs.rke2.io/reference/linux_agent_config) instead.

## Access to a specific node
```bash
sudo vagrant ssh {name_of_your_node}
```

## Delete your cluster 
```bash
sudo vagrant destroy -f
```
