#!/bin/bash

source ./common_vars.sh

cat > ${CERT_BASE_DIR}/kube-controller-manager-csr.json << EOF
{
    "CN": "system:kube-controller-manager",
    "key": {
        "algo": "rsa",
        "size": 2048

    },
    "names": [
        {
            "C": "Greece",
            "L": "Evoia",
            "O": "system:kube-controller-manager",
            "OU": "Kubernetes The Hard Way",
            "ST": "Chalcis"
        }
    ]
}
EOF

# Generete the kube-controller-manager certificate, signed by the CA created in generate_ca.sh
# Process the output and write the certificate and key to files
## kube-controller-manager.pem: The kube-controller-manager certificate
## kube-controller-manager-key.pem: The private key for the kube-controller-manager
## kube-controller-manager.csr: The Certificate Signing Request
cfssl gencert \
    -ca=${CA_CERT} \
    -ca-key=${CA_KEY} \
    -config=${CA_CONFIG} \
    -profile=${PROFILE} \
    ${CERT_BASE_DIR}/kube-controller-manager-csr.json | cfssljson -bare ${CERT_BASE_DIR}/kube-controller-manager