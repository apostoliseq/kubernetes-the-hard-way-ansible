#!/bin/bash

source ./common_vars.sh

# CA config
cat > "${CA_CONFIG}" << EOF
{
    "signing": {
        "default": {
            "expiry": "8760h"
        },
        "profiles": {
            "kubernetes": {
                "usages": ["signing", "key encipherment", "server auth", "client auth"],
                "expiry": "8760h"
            }
        }
    }
}
EOF

# CA Certificate Signing Request
# Configuration of the Signing Request for the CA certificate
cat > "${CERT_BASE_DIR}/ca-csr.json" << EOF
{
    "CN": "Kubernetes",
    "key": {
        "algo": "rsa",
        "size": 2048

    },
    "names": [
        {
            "C": "Greece",
            "L": "Evoia",
            "O": "Kubernetes",
            "OU": "CA",
            "ST": "Chalcis"
        }
    ]
}
EOF

# Generete a self-signed CA certificate using the CSR defined in ca-csr.json
# Process the output and write the certificate and key to files
## ca.pem: public certificate (used by other components to validate other certificates)
## ca-key.pem: private certificate
## ca.csr: The Certificate Signing Request
cfssl gencert -initca ${CERT_BASE_DIR}/ca-csr.json | cfssljson -bare ${CERT_BASE_DIR}/ca