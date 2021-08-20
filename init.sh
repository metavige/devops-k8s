#!/bin/bash

source .env

## Make Traefik Configuration

TRAEFIK_CONF_DIR=${PWD}/base/traefik/config
K3S_MANIFETSS_DIR=${PWD}/volumes/manifests

if [ ! -f ${K3S_MANIFETSS_DIR}/traefik-secret.yaml ]; then
  if [ ! -f ${TRAEFIK_CONF_DIR}/certs/_wildcard.k8s.internal-key.pem ]; then
    cd ${TRAEFIK_CONF_DIR}/certs &&
      mkcert '*.k8s.internal' &&
      cd ${OLDPWD}
  fi

  kubectl create secret tls traefik-certs \
    --cert=${PWD}/base/traefik/config/certs/_wildcard.k8s.internal.pem \
    --key=${PWD}/base/traefik/config/certs/_wildcard.k8s.internal-key.pem \
    -n kube-system --dry-run=client -o yaml \
    >${K3S_MANIFETSS_DIR}/traefik-secret.yaml
fi

if [ ! -f ${K3S_MANIFETSS_DIR}/traefik-configmap.yaml ]; then
  kubectl create configmap traefik-config \
    --from-file=ssl.yml=config/conf/ssl.yml \
    -n kube-system --dry-run=client -o yaml \
    >${K3S_MANIFETSS_DIR}/traefik-configmap.yaml
fi

k3d cluster create ${CLUSTER_NAME} \
  -p 80:80@loadbalancer \
  -p 443:443@loadbalancer \
  --network ${K3D_NETWORK} \
  --servers ${SERVER_NODES} \
  --agents ${AGENT_NODES} \
  --registry-config registry-config.yaml \
  --volume ${K3S_MANIFETSS_DIR}:/var/lib/rancher/k3s/server/manifests
