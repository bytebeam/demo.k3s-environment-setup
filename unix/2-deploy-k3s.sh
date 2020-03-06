#!/usr/bin/env bash

#k3s-master k3s-worker1 k3s-worker2 k3s-worker3
# Deploy k3s master on node1
multipass exec k3s-master -- /bin/bash -c "curl -sfL https://get.k3s.io | sh -"

# Get the IP of the master node
K3S_NODEIP_MASTER="https://$(multipass info k3s-master | grep "IPv4" | awk -F' ' '{print $2}'):6443"

# Get the TOKEN from the master node
K3S_TOKEN="$(multipass exec k3s-master -- /bin/bash -c "sudo cat /var/lib/rancher/k3s/server/node-token")"

# Deploy k3s on the worker nodes node2,node3,node4
multipass exec k3s-worker1 -- /bin/bash -c "curl -sfL https://get.k3s.io | K3S_TOKEN=${K3S_TOKEN} K3S_URL=${K3S_NODEIP_MASTER} sh -"
multipass exec k3s-worker2 -- /bin/bash -c "curl -sfL https://get.k3s.io | K3S_TOKEN=${K3S_TOKEN} K3S_URL=${K3S_NODEIP_MASTER} sh -"
multipass exec k3s-worker3 -- /bin/bash -c "curl -sfL https://get.k3s.io | K3S_TOKEN=${K3S_TOKEN} K3S_URL=${K3S_NODEIP_MASTER} sh -"
sleep 10

echo "############################################################################"
multipass exec k3s-master -- bash -c 'sudo cat /etc/rancher/k3s/k3s.yaml' > k3s.yaml
sed -i'.back' -e 's/127.0.0.1/k3s-master/g' k3s.yaml
export KUBECONFIG=k3s.yaml
kubectl taint node k3s-master node-role.kubernetes.io/master=effect:NoSchedule
kubectl label node k3s-worker1 node-role.kubernetes.io/node=
kubectl label node k3s-worker2 node-role.kubernetes.io/node=
kubectl label node k3s-worker3 node-role.kubernetes.io/node=
kubectl get nodes
echo "############################################################################"