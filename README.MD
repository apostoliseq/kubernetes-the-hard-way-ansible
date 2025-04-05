# Ansible

# Install
```
sudo apt update -y
sudo apt install -y ansible
```
- Create inventory.ini with the nodes to be managed
- Troubleshoot #1
```
ansible all --key-file ~/.ssh/ansible -i inventory.ini -m ping
```
- Create ansible.cfg
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

# CONTROLLER SERVICES CHECKS
# Check etcd member list
sudo ETCDCTL_API=3 etcdctl member list \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem

# Check etcd status
sudo ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem \
  endpoint health

# Inspect the Problematic Secret in etcd
sudo ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem \
  get /registry/secrets/default/default-token-qcfzl

# Delete the Problematic Secret in etcd
sudo ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem \
  del /registry/secrets/default/default-token-qcfzl

# Check kube components status
kubectl get componentstatuses --kubeconfig data/certs/admin.kubeconfig

# Check kube-apiserver status
curl -k https://localhost:6443/version

# Check kube-apiserver healthcheck endpoint via http from controller
curl -H "Host: kubernetes.default.svc.cluster.local" -i http://127.0.0.1/healthz

# Check loadbalancer health
sudo nginx -s reload

# WORKER SERVICES CHECKS
# Check if workers have succesfully registered themselves with the cluster (FROM A CONTROLLER NODE)
kubectl get nodes