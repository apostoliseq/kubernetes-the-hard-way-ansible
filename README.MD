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

# Make changes to nodes (elevated ad-hoc)
```
ansible all -m apt -a update_cache=true --become --ask-become-pass
```

# ansible-galaxy init <role>
1. `defaults/`
	- **Purpose**: Contains default variables for the role.
	- **Use Case**: Variables defined here are meant to be overridden by users. They provide sensible defaults for the role.
	- **Example**: defaults/main.yml might define a default port for a service.
2. `files/`
    - **Purpose**: Stores static files that the role may need to copy to remote systems.
    - **Use Case**: Files in this directory are typically referenced in tasks using the copy or src module.
    - **Example**: Configuration files, scripts, or binaries that need to be deployed.
3. `handlers/`
    - **Purpose**: Contains handlers, which are tasks that are triggered by notifications from other tasks.
    - **Use Case**: Handlers are often used to restart services or perform actions after a change is made.
    - **Example**: A handler to restart Apache after a configuration file is updated.
4. `meta/`
    - **Purpose**: Contains metadata about the role, such as dependencies, supported platforms, and author information.
    - **Use Case**: Used to define role dependencies and compatibility information.
    - **Example**: meta/main.yml might list other roles that this role depends on.
5. `tasks/`
    - **Purpose**: Contains the main list of tasks that the role will execute.
    - **Use Case**: This is where the core functionality of the role is defined.
    - **Example**: tasks/main.yml might include tasks to install packages, configure services, and create users.
6. `templates/`
    - **Purpose**: Stores Jinja2 templates that can be dynamically rendered and deployed to remote systems.
    - **Use Case**: Used for configuration files that need to include variables or logic.
    - **Example**: A template for an Nginx configuration file that includes variables for the server name and port.
7. `tests/`
    - **Purpose**: Contains test playbooks and inventory files for testing the role.
    - **Use Case**: Used to verify that the role works as expected.
    - **Example**: tests/test.yml might include a playbook to apply the role and validate its behavior.
8. `vars/`
    - **Purpose**: Contains variables specific to the role.
    - **Use Case**: Variables defined here are not meant to be overridden by users (unlike defaults/).
    - **Example**: vars/main.yml might define internal variables used by the role.