#!/bin/bash

# Install cfssl
if ! command -V cfssl &> /dev/null; then

    echo "Installing cfssl..."
    wget -q --show-progress --https-only --timestamping \
        https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 \
        https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64

    chmod +x cfssl_linux-amd64 cfssljson_linux-amd64

    sudo mv cfssl_linux-amd64 /usr/local/bin/cfssl
    sudo mv cfssljson_linux-amd64 /usr/local/bin/cfssljson
else
    echo "cfssl is already installed, skipping..."
fi

cfssl version

# Install kubectl
if ! command -V kubectl &> /dev/null; then

    echo "Installing kubectl..."
    wget https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kubectl

    chmod +x kubectl

    sudo mv kubectl /usr/local/bin

else
    echo "kubectl is already installed, skipping..."
fi

kubectl version --client

# Install ansible
if ! command -V ansible &> /dev/null; then

    echo "Installing ansible..."
    sudo apt update -y
    sudo apt install -y ansible

else
    echo "ansible is already installed, skipping..."
fi

ansible version 2>/dev/null

# Configure ansible
if [ ! -f ~/.ssh/ed25519-ansible ]; then
    
    echo "Configuring Ansible SSH keys..."
    ssh-keygen -f ~/.ssh/ed25519-ansible -t ed25519 -C "ansible-access" -N ""

    for ip in $(grep "kube-" /etc/hosts | awk '{print $1}'); do
        ssh-copy-id -i ~/.ssh/ed25519-ansible.pub $ip
    done

else
    echo "ansible SSH keys already exist, skipping..."
fi

./set-ips-in-inventory.sh