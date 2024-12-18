#!/bin/bash

host_ansible="$(grep 'ansible_host:' ./ansible/inventory/hosts.yml | awk '{print $2}' | tr -d \")"
cd ansible/
ansible-playbook -i inventory/hosts.yml prepare.yaml
ansible-playbook -i inventory/hosts.yml prepare-kubespray.yaml
ssh ubuntu@"$host_ansible" "cd kubespray/; /home/ubuntu/.local/bin/ansible-playbook -i inventory/mycluster/inventory.yml cluster.yml -b &"
ansible-playbook -i inventory/hosts.yml kube-conf.yaml