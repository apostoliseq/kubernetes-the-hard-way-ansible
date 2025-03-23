#!/bin/bash

# Source the common variables
source ./common_vars.sh

# # List of vm names
COMPONENTS=("${CONTROLLER1_HOST}" "${CONTROLLER2_HOST}" "${WORKER1_HOST}" "${WORKER2_HOST}"  "${LOADBALANCER_HOST}")

# Map vm names to their corresponding environment variables
# Associative arrays allow you to store key-value pairs
declare -A vm_to_var
vm_to_var=(
    ["${CONTROLLER1_HOST}"]="CONTROLLER1_IP"
    ["${CONTROLLER2_HOST}"]="CONTROLLER2_IP"
    ["${WORKER1_HOST}"]="WORKER1_IP"
    ["${WORKER2_HOST}"]="WORKER2_IP"
    ["${LOADBALANCER_HOST}"]="LOADBALANCER_IP"
)

SSH_USER="apostoliseq"

# "${!vm_to_var[@]}" returns all the keys in the associative array.
# "${vm_to_var[$vm]}" retrieves the value associated with the current key.
# vm: kube-controller-1 -> Variable: CONTROLLER1_IP
# vm: kube-controller-2 -> Variable: CONTROLLER2_IP
# vm: kube-worker-1 -> Variable: WORKER1_IP
# vm: kube-worker-2 -> Variable: WORKER2_IP
# vm: kube-loadbalancer -> Variable: LOADBALANCER_IP
# Loop through each vm and update the corresponding variable in common_vars.sh
for vm in "${!vm_to_var[@]}"; do
    # Get the corresponding variable name / node IPs
    var_name="${vm_to_var[$vm]}"

    # Get the IP address of the vm using `hostname -I`
    ip=$(ssh "$SSH_USER@$vm" "hostname -I | awk '{print \$1}'")

    # Update the variable in the temporary file
    if grep -q "^export $var_name=" "./common_vars.sh"; then
        # If the variable already exists, update its value
        sed -i "s/^export $var_name=.*/export $var_name=\"$ip\"/" "./common_vars.sh"
    else
        # If the variable doesn't exist, add it to the file
        printf "\n" >> "./common_vars.sh"
        echo "export $var_name=\"$ip\"" >> "./common_vars.sh"
    fi
done

echo "Updated ./common_vars.sh with new IP addresses."