#!/bin/bash

# Source the common variables
source ./common_vars.sh

# Function to copy certificates to a node
# `local` ensures the variable is only accessible within the function.
# `shift` removes the first argument ($1) from the list of arguments. After this, $@ will no longer include the node argument.
# `local certs=("$@")` - The remaining arguments are stored in an array called certs.
copy_certs() {
    local node=$1
    shift
    local certs=("$@")
    local full_certs=()

    # Construct full paths for certificates
    for cert in "${certs[@]}"; do
        full_certs+=("${cert}")
    done

    # Copy certificates to each directory
    for dir in ${CERT_CONTAINER_DIR[@]}; do
        scp -o StrictHostKeyChecking=no "${full_certs[@]}" "${node}:${dir}"
    done
}

# Copy certificates to worker nodes
for worker in "${WORKERS[@]}"; do
    echo "Copying certificates to ${worker}..."
    if [[ "${worker}" == "kube-worker-1" ]]; then
        copy_certs "${worker}" "${CA_CERT}" "${WORKER1_CERTS[@]}"
    elif [[ "${worker}" == "kube-worker-2" ]]; then
        copy_certs "${worker}" "${CA_CERT}" "${WORKER2_CERTS[@]}"
    fi
done

# Copy certificates to controller nodes
for controller in "${CONTROLLERS[@]}"; do
    echo "Copying certificates to ${controller}..."
    copy_certs "${controller}" "${CONTROLLER_CERTS[@]}"
done

echo "Certificate distribution complete."