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

    kubectl_version=1.32.0

    echo "Installing kubectl..."
    wget https://dl.k8s.io/v$kubectl_version/bin/linux/amd64/kubectl
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

# Install Python kubernetes module (required for kubernetes.core)
echo "Installing Python Kubernetes modules..."
sudo apt update && sudo apt install -y python3-pip python3-kubernetes

# # Try to install via apt first (most reliable system integration)
# sudo apt install -y  python3-openshift 2>/dev/null || true

# # Install via pip with appropriate flags based on pip version
# if python3 -m pip --version | grep -q "pip 23"; then
#     # For newer pip versions (23+) that require --break-system-packages
#     echo "Using newer pip version with --break-system-packages flag"
#     sudo python3 -m pip install kubernetes openshift netaddr --break-system-packages
# else
#     # For older pip versions
#     echo "Using older pip version"
#     sudo python3 -m pip install kubernetes openshift netaddr
# fi

./set-ips-in-inventory.sh