#!/bin/bash

source ./common_vars.sh

for instance in ${WORKER1_HOST} ${WORKER2_HOST}; do
# Set the configuration for the location of the cluster
# i.e. look for the Kubenetes API at the load balancer
    kubectl config set-cluster ${CLUSTER_NAME} \
        --certificate-authority=${CA_CERT} \
        --embed-certs=true \
        --server=https://${KUBERNETES_ADDRESS}:6443 \
        --kubeconfig=${KUBECONFIG_BASE_DIR}/${instance}.kubeconfig

# Set the username and client certificate that will be used to authenticate
# i.e. instance will be using the instance.pem certificates to authenticate
    kubectl config set-credentials system:node:${instance} \
        --client-certificate=${CERT_BASE_DIR}/${instance}.pem \
        --client-key=${CERT_BASE_DIR}/${instance}-key.pem \
        --embed-certs=true \
        --kubeconfig=${KUBECONFIG_BASE_DIR}/${instance}.kubeconfig

# Set the context to default
    kubectl config set-context default \
        --cluster=${CLUSTER_NAME} \
        --user=system:node:${instance} \
        --kubeconfig=${KUBECONFIG_BASE_DIR}/${instance}.kubeconfig

# Use that default context in the kubeconfig file
    kubectl config use-context default --kubeconfig=${KUBECONFIG_BASE_DIR}/${instance}.kubeconfig
done

# kube-proxy like kubelet access the API through the load balancer
kubectl config set-cluster ${CLUSTER_NAME} \
    --certificate-authority=${CA_CERT} \
    --embed-certs=true \
    --server=https://${KUBERNETES_ADDRESS}:6443 \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-proxy.kubeconfig

kubectl config set-credentials system:node:kube-proxy \
    --client-certificate=${CERT_BASE_DIR}/kube-proxy.pem \
    --client-key=${CERT_BASE_DIR}/kube-proxy-key.pem \
    --embed-certs=true \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-proxy.kubeconfig

kubectl config set-context default \
    --cluster=${CLUSTER_NAME} \
    --user=system:node:kube-proxy \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-proxy.kubeconfig

# kube-controller-manager accesses the API on whichever server is on 
# i.e. runs on controllers with the kube-apiserver so it doesn't need to go through the load balancer
kubectl config set-cluster ${CLUSTER_NAME} \
    --certificate-authority="${CA_CERT}" \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-controller-manager.kubeconfig

kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=${CERT_BASE_DIR}/kube-controller-manager.pem \
    --client-key=${CERT_BASE_DIR}/kube-controller-manager-key.pem \
    --embed-certs=true \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-controller-manager.kubeconfig

kubectl config set-context default \
    --cluster=${CLUSTER_NAME} \
    --user=system:kube-controller-manager \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-controller-manager.kubeconfig

kubectl config use-context default --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-controller-manager.kubeconfig

# kube-scheduler accesses the API on whichever server is on 
# i.e. runs on controllers with the kube-apiserver so it doesn't need to go through the load balancer
kubectl config set-cluster ${CLUSTER_NAME} \
    --certificate-authority="${CA_CERT}" \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-scheduler.kubeconfig

kubectl config set-credentials system:kube-scheduler \
    --client-certificate=${CERT_BASE_DIR}/kube-scheduler.pem \
    --client-key=${CERT_BASE_DIR}/kube-scheduler-key.pem \
    --embed-certs=true \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-scheduler.kubeconfig

kubectl config set-context default \
    --cluster=${CLUSTER_NAME} \
    --user=system:kube-scheduler \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-scheduler.kubeconfig

kubectl config use-context default --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-scheduler.kubeconfig

# admin
kubectl config set-cluster ${CLUSTER_NAME} \
    --certificate-authority="${CA_CERT}" \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-admin.kubeconfig

kubectl config set-credentials admin \
    --client-certificate=${CERT_BASE_DIR}/admin.pem \
    --client-key=${CERT_BASE_DIR}/admin-key.pem \
    --embed-certs=true \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-admin.kubeconfig

kubectl config set-context default \
    --cluster=${CLUSTER_NAME} \
    --user=admin \
    --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-admin.kubeconfig

kubectl config use-context default --kubeconfig=${KUBECONFIG_BASE_DIR}/kube-admin.kubeconfig