#!/bin/bash

# Keys: Workstation, ansible, Windows
for ip in kube-controller-1 kube-controller-2 kube-worker-1 kube-worker-2 kube-loadbalancer; do
    for key in ~/.ssh/id_ed25519.pub ~/.ssh/ansible.pub ~/.ssh/apost.pub; do
        ssh-copy-id -i $key $ip
    done
done