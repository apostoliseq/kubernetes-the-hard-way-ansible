#!/bin/bash

# Source the common variables
source ./common_vars.sh

# Function to copy ENCRYPTION-CONFIG to a node
# `local` ensures the variable is only accessible within the function.
# `shift` removes the first argument ($1) from the list of arguments. After this, $@ will no longer include the node argument.
# `local encryption_config=("$@")` - The remaining arguments are stored in an array called encryption_config.
copy_encryption-config() {
    local node=$1
    shift
    local encryption_config=("$@")
    for dir in ${CERT_CONTAINER_DIR[@]}; do
        echo "Copying encryption-config.yaml to $dir."
        scp -o StrictHostKeyChecking=no "${PROJECT_DIR}/encryption-config.yaml" "${node}:$dir"
    done
}

# Copy Encryption-configs to controller nodes
for controller in "${CONTROLLERS[@]}"; do
    echo "Copying encryption-config.yaml to ${controller}..."
    copy_encryption-config "${controller}"
done

echo "Kubeconfig distribution complete."