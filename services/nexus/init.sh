#!/bin/bash

source ../../.env

NODE_HOSTS=$(kubectl get cm/coredns -n kube-system -o 'jsonpath={.data.NodeHosts}')

if [ $(echo ${NODE_HOSTS} | grep -c "nexus.docker.internal") -eq 0 ]; then
  NODE_HOSTS="$(echo ${NODE_HOSTS} | sed -r '$!s/$/\\n/' | tr -d '\n')"
  NEXUS_HOSTS="${NEXUS_IP} nexus.docker.internal"

  NODE_HOSTS="$NODE_HOSTS\\n$NEXUS_HOSTS"

  echo $NODE_HOSTS

  # kubectl patch cm/coredns -n kube-system \
  #   --patch "{\"data\":{\"NodeHosts\":\"$(echo ${NODE_HOSTS} | sed -r '$!s/$/\\n/' | tr -d '\n')\"}}"
fi

# kubectl apply -f external-service.yaml
