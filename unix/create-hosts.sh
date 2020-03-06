#!/usr/bin/env bash
NODES=$(echo k3s-master k3s-worker1 k3s-worker2 k3s-worker3)
for NODE in ${NODES}; do
    multipass exec ${NODE} -- bash -c 'echo `ip -4 addr show enp0s2 | grep -oP "(?<=inet ).*(?=/)"` `echo $(hostname)`'
done