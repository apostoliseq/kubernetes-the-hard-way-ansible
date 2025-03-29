# #!/bin/bash

# List of vm names
components=("kube-controller-1" "kube-controller-2" "kube-worker-1" "kube-worker-2" "kube-loadbalancer")

# Loop through each vm, get the IP, and update the corresponding variable in inventory.ini
for vm in "${components[@]}"; do

    # Get the IP address from /etc/hosts
    ip=$(grep "$vm" /etc/hosts | awk '{print $1}')

    # Check if IP was found
    if [ -z "$ip" ]; then
        echo "Error: IP address for $vm not found in /etc/hosts."
        exit 1
    fi

    # Update the variable in inventory.ini
    if grep -q "^$vm ansible_host=$ip" "inventory.ini"; then
        # Line already exists and is correct, skip
        echo "$vm ansible_host=$ip is already correct in inventory.ini. Skipping."
    elif grep -q "^$vm ansible_host=" "inventory.ini"; then
        # Line exists but has the wrong IP, update it
        sed -i "/\[cluster\]/,/\[/s/^$vm ansible_host=.*/$vm ansible_host=$ip/" "inventory.ini"
        echo "Updated $vm ansible_host in inventory.ini to $ip."
    else
        # Line does not exist, add it to the [cluster] section
        cluster_end=$(grep -n "\[cluster\]" inventory.ini | cut -d: -f1)
        cluster_end=$((cluster_end + 1)) #Line after [cluster]
        sed -i "${cluster_end}i$vm ansible_host=$ip" inventory.ini
        echo "Added $vm ansible_host=$ip to inventory.ini."
    fi
done

echo "Finished updating inventory.ini."