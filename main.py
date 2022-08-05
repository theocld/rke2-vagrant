import argparse
import os
import yaml
from yaml.loader import SafeLoader
from time import sleep

parser = argparse.ArgumentParser()
parser.add_argument("-c", "--config", help="The path to the config file", default='config.yaml')
args = parser.parse_args()

file_name = args.config
config_file = open(file_name, encoding='utf8', errors='ignore')
config_dict = yaml.load(config_file, Loader=SafeLoader)

with open('Vagrantfile', 'r') as f :
    provider = config_dict['provider']
    master-ip-address = config_dict['Master-Ip-Address']
    workers_count = config_dict['topology']['workers_count']
    master_memory = config_dict['topology']['master']['memory']
    master_cpu = config_dict['topology']['master']['cpu']
    worker_memory = config_dict['topology']['worker']['memory']
    worker_cpu = config_dict['topology']['worker']['cpu']
    filedata = f.read()
    newdata = filedata.replace('{{Provider}}', str(provider))
    newdata = newdata.replace('{{Master-Ip-Address}}', str(Master-Ip-Address))
    newdata = newdata.replace('{{WorkerCount}}', str(workers_count))
    newdata = newdata.replace('{{MasterMemory}}', str(master_memory))
    newdata = newdata.replace('{{MasterCPU}}', str(master_cpu))
    newdata = newdata.replace('{{WorkerMemory}}', str(worker_memory))
    newdata = newdata.replace('{{WorkerCPU}}', str(worker_cpu))
    with open('Vagrantfile', 'w') as f:
        f.write(newdata)

# Vagrant up
os.system('sudo vagrant up')
print('Vagrant up finished')
sleep(3)

# Reload the master
#os.system('sudo vagrant reload master')
#print('Master reloaded')
#sleep(3)

# Get the join command on the master
print("Getting the join command")
output_txt = ""
command = "sudo vagrant ssh master -c 'sudo kubeadm token create --print-join-command'"
output = os.popen(command)
sleep(10)
output_txt = output.read()
output_txt = "sudo " + output_txt
print(output_txt)

# Run the join command on workers
for i in range(1, workers_count+1):
    print("Joining worker"+str(i))
    joint_output_txt = ""
    join_command = "sudo vagrant ssh worker" + str(i) + " -c '" + output_txt + "'"
    joint_output = os.popen(join_command)
    joint_output_txt = joint_output.read()
    print(joint_output_txt)
    
    
