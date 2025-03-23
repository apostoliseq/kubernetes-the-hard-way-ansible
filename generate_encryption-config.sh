#!/bin/bash

source ./common_vars.sh

ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

cat > ${PROJECT_DIR}/encryption-config.yaml << EOF
kind: EncryptionConfig
apiVersion: v1
    - resources:
        - secrets
    - providers:
        - aescbc:
            keys:
                - name: key1
                    secret: ${ENCRYPTION_KEY}
        - identity" {}
EOF