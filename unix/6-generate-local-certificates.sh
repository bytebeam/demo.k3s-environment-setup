#!/usr/bin/env bash

echo "Creating self-signed CA certificates for TLS and installing them in the local trust stores"

CA_CERTS_FOLDER=$(pwd)/.certs

# This requires mkcert to be installed/available

echo ${CA_CERTS_FOLDER}

rm -rf ${CA_CERTS_FOLDER}

mkdir -p ${CA_CERTS_FOLDER}

# The CAROOT env variable is used by mkcert to determine where to read/write files
# Reference: https://github.com/FiloSottile/mkcert
CAROOT=${CA_CERTS_FOLDER} mkcert -install

