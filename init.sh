#!/bin/bash

source .env

k3d cluster create $CLUSTER_NAME \
  -p 80:80@loadbalancer \
  -p 443:443@loadbalancer \
  --agents 3 \
  --k3s-server-arg "--disable=traefik"

# Optional
  # --api-port 0.0.0.0:6443 \
  # --agents-memory 1g \
  # --registry-create \

# k3d cluster create -c k3d-devops.yaml

cd base/traefik
sh ./traefik-init.sh

cd $OLDPWD