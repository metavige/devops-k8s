#!/bin/bash

source .env

k3d cluster create ${CLUSTER_NAME} \
  -p 80:80@loadbalancer \
  -p 443:443@loadbalancer \
  --network ${K3D_NETWORK} \
  --servers ${SERVER_NODES} \
  --agents ${AGENT_NODES} \
  --k3s-server-arg "--disable=traefik"

helm repo update

# Optional
# --api-port 0.0.0.0:6443 \
# --agents-memory 1g \
# --registry-create \

# 另外一種建立 k3d 的方式
# k3d cluster create -c k3d-devops.yaml

# cd base/traefik
# sh ./traefik-init.sh

# cd $OLDPWD
