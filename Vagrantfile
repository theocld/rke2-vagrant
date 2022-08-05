# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
configuration = YAML.load_file('config.yaml')
machines = configuration['machines']

ENV['VAGRANT_NO_PARALLEL'] = 'yes'
ENV['VAGRANT_DEFAULT_PROVIDER'] = configuration['provider']


Vagrant.configure("2") do |config|

  machines.each do |machine|
    case machine['role']
      when "master"
        master_ip = machine['ip'].to_s
        puts master_ip
        puts "Hello"
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
          node.vm.network "private_network", ip: machine['ip']
          node.vm.provision "shell", path: "install_server.sh", privileged: false
          node.vm.provision "shell", path: "prepare_kubernetes.sh", privileged: false
        when "worker"
          node.vm.network "private_network", type: "dhcp"
          node.vm.provision "file", source: "config_agent.yml" , destination: "~/config_agent.yaml"
          node.vm.provision "shell", path: "install_agent.sh", privileged: false, args: [master_ip]
      end
    end
  end

end
