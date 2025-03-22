### SSH Overview & Setup

# Installs
- Nodes: OpenSSH server
- Workstation: OpenSSH client

# Flow
- Connect to each node from the workstation and answer "yes" to the initial connection prompt ( to find automatic way )
- Create an SSH key pair for your normal user accoumt ( with passphrase )
```
ssh-keygen -t ed25519 -C "apostoliseq default"
```
- Add the key to authorized_files' of each node
```
ssh-copy-id.sh
```
- Create an SSH key that its specific to Ansible ( no passphrase ) ~/.ssh/ansible
```
ssh-keygen -t ed25519 -C "ansible"
```
- Add the key to authorized_files' of each node
```
ssh-copy-id.sh
```

# Ansible

# Install
```
sudo apt update -y
sudo apt install ansible
```
- Create inventory file with the nodes to be managed (inventory.ini)
- Troubleshoot #1
```
ansible all --key-file ~/.ssh/ansible -i inventory.ini -m ping
```
- Create ansible config (ansible.cfg)
```
ansible all --key-file -m ping
```
```
ansible all --list-hosts
```
```
ansible all -m gather_facts
```