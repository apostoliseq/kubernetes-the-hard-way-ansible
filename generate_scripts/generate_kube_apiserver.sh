#!/bin/bash

source ./common_vars.sh

cat > ${CERT_BASE_DIR}/kube-apiserver-csr.json << EOF
{
    "CN": "system:kube-apiserver",
    "key": {
        "algo": "rsa",
        "size": 2048

    },
    "names": [
        {
            "C": "Greece",
            "L": "Evoia",
            "O": "Kubernetes",
            "OU": "Kubernetes The Hard Way",
            "ST": "Chalcis"
        }
    ]
}
EOF

# Generete the kube-apiserver certificate, signed by the CA created in generate_ca.sh
# Process the output and write the certificate and key to files
## kube-apiserver.pem: The kube-apiserver certificate
## kube-apiserver-key.pem: The private key for the kube-apiserver
## kube-apiserver.csr: The Certificate Signing Request
cfssl gencert \
    -ca=${CA_CERT} \
    -ca-key=${CA_KEY} \
    -config=${CA_CONFIG} \
    -hostname=${CERT_HOSTNAME} \
    -profile=${PROFILE} \
    ${CERT_BASE_DIR}/kube-apiserver-csr.json | cfssljson -bare ${CERT_BASE_DIR}/kube-apiserver
