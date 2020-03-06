#!/usr/bin/env bash

kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.3/manifests/metallb.yaml
kubectl apply -f ../resources/metal-lb-layer2-config.yaml