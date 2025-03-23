#!/bin/bash

source ./common_vars.sh

cat > ${CERT_BASE_DIR}/kube-scheduler-csr.json << EOF
{
    "CN": "system:kube-scheduler",
    "key": {
        "algo": "rsa",
        "size": 2048

    },
    "names": [
        {
            "C": "Greece",
            "L": "Evoia",
            "O": "system:kube-scheduler",
            "OU": "Kubernetes The Hard Way",
            "ST": "Chalcis"
        }
    ]
}
EOF

# Generete the kube-scheduler certificate, signed by the CA created in generate_ca.sh
# Process the output and write the certificate and key to files
## kube-scheduler.pem: The kube-scheduler certificate
## kube-scheduler-key.pem: The private key for the kube-scheduler
## kube-scheduler.csr: The Certificate Signing Request
cfssl gencert \
    -ca=${CA_CERT} \
    -ca-key=${CA_KEY} \
    -config=${CA_CONFIG} \
    -profile=${PROFILE} \
    ${CERT_BASE_DIR}/kube-scheduler-csr.json | cfssljson -bare ${CERT_BASE_DIR}/kube-scheduler