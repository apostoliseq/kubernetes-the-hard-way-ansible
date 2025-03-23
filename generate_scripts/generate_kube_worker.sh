#!/bin/bash

source ./common_vars.sh

cat > ${CERT_BASE_DIR}/${WORKER1_HOST}-csr.json << EOF
{
    "CN": "system:node:${WORKER1_HOST}",
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "Greece",
            "L": "Evoia",
            "O": "system:nodes",
            "OU": "Kubernetes The Hard Way",
            "ST": "Chalcis"
        }
    ]
}
EOF

# Generete the kube-worker-1 certificate, signed by the CA created in generate_ca.sh
# Process the output and write the certificate and key to files
## kube-worker-1.pem: The kube-worker-1 certificate
## kube-worker-1-key.pem: The private key for the kube-worker-1
## kube-worker-1.csr: The Certificate Signing Request
cfssl gencert \
    -ca=${CA_CERT} \
    -ca-key=${CA_KEY} \
    -config=${CA_CONFIG} \
    -hostname=${WORKER1_HOST} \
    -profile=${PROFILE} \
    ${CERT_BASE_DIR}/${WORKER1_HOST}-csr.json | cfssljson -bare ${CERT_BASE_DIR}/${WORKER1_HOST}

cat > ${CERT_BASE_DIR}/${WORKER2_HOST}-csr.json << EOF
{
    "CN": "system:node:${WORKER2_HOST}",
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "Greece",
            "L": "Evoia",
            "O": "system:nodes",
            "OU": "Kubernetes The Hard Way",
            "ST": "Chalcis"
        }
    ]
}
EOF

# Generete the kube-worker-2 certificate, signed by the CA created in generate_ca.sh
# Process the output and write the certificate and key to files
## kube-worker-2.pem: The kube-worker-2 certificate
## kube-worker-2-key.pem: The private key for the kube-worker-2
## kube-worker-2.csr: The Certificate Signing Request
cfssl gencert \
    -ca=${CA_CERT} \
    -ca-key=${CA_KEY} \
    -config=${CA_CONFIG} \
    -hostname=${WORKER2_HOST} \
    -profile=${PROFILE} \
    ${CERT_BASE_DIR}/${WORKER2_HOST}-csr.json | cfssljson -bare ${CERT_BASE_DIR}/${WORKER2_HOST}