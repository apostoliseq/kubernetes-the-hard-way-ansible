#!/bin/bash

# Source the common variables
source ./common_vars.sh

# Function to copy Kubeconfigs to a node
# `local` ensures the variable is only accessible within the function.
# `shift` removes the first argument ($1) from the list of arguments. After this, $@ will no longer include the node argument.
# `local kubeconfigs=("$@")` - The remaining arguments are stored in an array called kubeconfigs.
copy_kubeconfigs() {
    local node=$1
    shift
    local kubeconfigs=("$@")
    scp -o StrictHostKeyChecking=no "${kubeconfigs[@]}" "${node}:/data/certs"
}

# Copy Kubeconfigs to worker nodes
for worker in "${WORKERS[@]}"; do
    echo "Copying Kubeconfigs to ${worker}..."
    if [[ "${worker}" == "kube-worker-1" ]]; then
        copy_kubeconfigs "${worker}" "${WORKER1_KUBECONFIGS[@]}"
    elif [[ "${worker}" == "kube-worker-2" ]]; then
        copy_kubeconfigs "${worker}" "${WORKER2_KUBECONFIGS[@]}"
    fi
done

# Copy Kubeconfigs to controller nodes
for controller in "${CONTROLLERS[@]}"; do
    echo "Copying Kubeconfigs to ${controller}..."
    copy_kubeconfigs "${controller}" "${CONTROLLER_KUBECONFIGS[@]}"
done

echo "Kubeconfig distribution complete."