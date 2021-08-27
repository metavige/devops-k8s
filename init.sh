#!/bin/bash

source .env

## Make Traefik Configuration

rm -rf ${K3S_MANIFESTS_DIR} && mkdir -p ${K3S_MANIFESTS_DIR}
cp -f ${TRAEFIK_MANIFESTS_DIR}/*.yaml ${K3S_MANIFESTS_DIR}

if [ ! -f ${TRAEFIK_CONF_DIR}/certs/_wildcard.k8s.internal-key.pem ]; then
  cd ${TRAEFIK_CONF_DIR}/certs &&
    mkcert "*.k8s.internal" &&
    cd ${OLDPWD}
fi

kubectl create secret tls traefik-secret \
  --cert=${TRAEFIK_CONF_DIR}/certs/_wildcard.k8s.internal.pem \
  --key=${TRAEFIK_CONF_DIR}/certs/_wildcard.k8s.internal-key.pem \
  -n kube-system --dry-run=client -o yaml >${K3S_MANIFESTS_DIR}/traefik-secret.yaml

k3d cluster create ${CLUSTER_NAME} \
  -p 80:80@loadbalancer \
  -p 443:443@loadbalancer \
  --network ${K3D_NETWORK} \
  --agents ${AGENT_NODES} \
  --registry-config registry-config.yaml \
  --volume ${K3S_MANIFESTS_DIR}:/var/lib/rancher/k3s/server/manifests@server[0]
