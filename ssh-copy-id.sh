#!/bin/bash

for ip in 192.168.225.146 192.168.225.147 192.168.225.148 192.168.225.149 192.168.225.150; do
    for key in ~/.ssh/id_ed25519.pub ~/.ssh/ansible.pub ~/.ssh/apost.pub; do
        ssh-copy-id -i $key $ip
    done
done