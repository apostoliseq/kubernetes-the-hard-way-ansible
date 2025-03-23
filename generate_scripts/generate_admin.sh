#!/bin/bash

source ./common_vars.sh

# Admin CSR
cat > ${CERT_BASE_DIR}/admin-csr.json << EOF
{
    "CN": "admin",
    "key": {
        "algo": "rsa",
        "size": 2048

    },
    "names": [
        {
            "C": "Greece",
            "L": "Evoia",
            "O": "system:masters",
            "OU": "Kubernetes The Hard Way",
            "ST": "Chalcis"
        }
    ]
}
EOF

# Generete the admin certificate, signed by the CA created in generate_ca.sh
# Process the output and write the certificate and key to files
## admin.pem: The admin certificate
## admin-key.pem: The private key for the admin
## admin.csr: The Certificate Signing Request
cfssl gencert \
    -ca=${CA_CERT} \
    -ca-key=${CA_KEY} \
    -config=${CA_CONFIG} \
    -profile=${PROFILE} \
    ${CERT_BASE_DIR}/admin-csr.json | cfssljson -bare ${CERT_BASE_DIR}/admin
