#!/bin/bash

K3S_NODE='k3s-devops'
MEMORY='2g'

multipass launch -m $MEMORY -n $K3S_NODE --cloud-init ./ubuntu-init.yml lts

multipass exec $K3S_NODE -- bash -c "curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=644 sh -"

# bash
# multipass exec $K3S_NODE sudo cat /etc/rancher/k3s/k3s.yaml > ~/.kube/k3s.yaml

# ZSH
multipass exec $K3S_NODE sudo cat /etc/rancher/k3s/k3s.yaml >! ~/.kube/k3s.yaml

K3S_NODE_IP=$(multipass info $K3S_NODE | grep IPv4 | awk '{print $2}')
sed -i '' "s/127.0.0.1/$K3S_NODE_IP/" ~/.kube/k3s.yaml

echo
echo "K3s devops cluster is ready ! [NODE IP: $K3S_NODE_IP]"
echo