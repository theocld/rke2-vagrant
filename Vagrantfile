# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
configuration = YAML.load_file('config.yaml')
machines = configuration['machines']

ENV['VAGRANT_NO_PARALLEL'] = 'yes'
ENV['VAGRANT_DEFAULT_PROVIDER'] = configuration['provider']


Vagrant.configure("2") do |config|
  
  master_ip = nil
  public_ip = nil
  machines.each do |machine|
    case machine['role']
      when "master"
        master_ip = machine['ip']
    end
    config.vm.define machine['name']  do |node|
      # The following will be executed regardless of the node role (master or worker)
      node.vm.box = machine['box']
      node.vm.hostname = machine['name']
      node.vm.provider configuration['provider'] do |p|
        p.memory = machine['memory']
        p.cpus= machine['cpu']
      end
      node.vm.provision "shell", path: "preliminary_stage_node.sh", privileged: false
      # The following depend on the node role
      case machine['role']
        when "master"
          node.vm.provision "file", source: "config_server.yml" , destination: "~/config_server.yaml"
          node.vm.provision "file", source: "install_rancher.sh" , destination: "~/install_rancher.sh"
          node.vm.network "private_network", ip: machine['ip']
          node.vm.network "public_network", ip: "172.31.16.94"
          node.vm.provision "shell", path: "install_server.sh", privileged: false
          node.vm.provision "shell", path: "prepare_kubernetes.sh", privileged: false
          node.vm.provision "shell", incline: "ip route add default via 172.31.16.1", privileged: true
        when "worker"
          node.vm.network "private_network", type: "dhcp"
          node.vm.provision "file", source: "config_agent.yml" , destination: "~/config_agent.yaml"
          node.vm.provision "shell", path: "install_agent.sh", privileged: false, args: ["#{master_ip}"]
      end
    end
  end

end
