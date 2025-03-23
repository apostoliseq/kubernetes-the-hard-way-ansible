#!/bin/bash

source ./common_vars.sh

cat > ${CERT_BASE_DIR}/kube-service-account-csr.json << EOF
{
    "CN": "service-accounts",
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

# Generete the kube-service-account certificate, signed by the CA created in generate_ca.sh
# Process the output and write the certificate and key to files
## kube-service-account.pem: The kube-service-account certificate
## kube-service-account-key.pem: The private key for the kube-service-account
## kube-service-account.csr: The Certificate Signing Request
cfssl gencert \
    -ca=${CA_CERT} \
    -ca-key=${CA_KEY} \
    -config=${CA_CONFIG} \
    -hostname=${CERT_HOSTNAME} \
    -profile=${PROFILE} \
    ${CERT_BASE_DIR}/kube-service-account-csr.json | cfssljson -bare ${CERT_BASE_DIR}/kube-service-account