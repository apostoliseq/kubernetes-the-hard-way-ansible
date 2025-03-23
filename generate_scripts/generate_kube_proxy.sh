#!/bin/bash

source ./common_vars.sh

cat > ${CERT_BASE_DIR}/kube-proxy-csr.json << EOF
{
    "CN": "system:kube-proxy",
    "key": {
        "algo": "rsa",
        "size": 2048

    },
    "names": [
        {
            "C": "Greece",
            "L": "Evoia",
            "O": "system:node-proxier",
            "OU": "Kubernetes The Hard Way",
            "ST": "Chalcis"
        }
    ]
}
EOF

# Generete the kube-proxy certificate, signed by the CA created in generate_ca.sh
# Process the output and write the certificate and key to files
## kube-proxy.pem: The kube-proxy certificate
## kube-proxy-key.pem: The private key for the kube-proxy
## kube-proxy.csr: The Certificate Signing Request
cfssl gencert \
    -ca=${CA_CERT} \
    -ca-key=${CA_KEY} \
    -config=${CA_CONFIG} \
    -profile=${PROFILE} \
    ${CERT_BASE_DIR}/kube-proxy-csr.json | cfssljson -bare ${CERT_BASE_DIR}/kube-proxy
