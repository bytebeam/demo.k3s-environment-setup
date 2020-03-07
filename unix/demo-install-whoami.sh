#!/usr/bin/env bash

CA_CERTS_FOLDER=$(pwd)/.certs

kubectl create ns whoami

echo "Creating K8S secrets with the CA private keys (will be used by the cert-manager CA Issuer)"

kubectl create secret -n whoami tls ca-key-pair --key=${CA_CERTS_FOLDER}/rootCA-key.pem --cert=${CA_CERTS_FOLDER}/rootCA.pem

# Install whoami app

kubectl apply -n whoami -f ../resources/whoami-deployment.yaml

# HOST=$(k get ingress -o jsonpath="{.items[*].status.loadBalancer.ingress[*].ip}")