# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'
ENV['VAGRANT_DEFAULT_PROVIDER'] = '{{Provider}}'

Vagrant.configure("2") do |config|

  
  config.vm.define "master" do |master|
    master.vm.box = "generic/ubuntu2110"
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "{{Master-Ip-Address}}"
    master.vm.provision "file", source: "config_server.yml" , destination: "~/config_server.yaml"
    master.vm.provision "shell", path: "preliminary_stage_node.sh", privileged: false
    master.vm.provision "shell", path: "install_server.sh", privileged: false
    master.vm.provision "shell", path: "prepare_kubernetes.sh", privileged: false
    master.vm.provider "{{Provider}}" do |p|
      p.memory = {{MasterMemory}}
      p.cpus= {{MasterCPU}}
    end
  end

  WorkerCount = {{WorkerCount}}

  (1..WorkerCount).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.box = "generic/ubuntu2110"
      worker.vm.hostname = "worker#{i}"
      worker.vm.network "private_network", type: "dhcp"
      worker.vm.provision "file", source: "config_agent.yml" , destination: "~/config_agent.yaml"
      worker.vm.provision "shell", path: "preliminary_stage_node.sh", privileged: false
      worker.vm.provision "shell", path: "install_agent.sh", privileged: false, args: [{{Master-Ip-Address}}]
      worker.vm.provision "shell", path: "prepare_kubernetes.sh", privileged: false
      worker.vm.provider "{{Provider}}" do |p|
        p.memory = {{WorkerMemory}}
        p.cpus= {{WorkerCPU}}
      end
    end  
  end

end

