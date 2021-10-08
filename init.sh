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

mkdir -p "${K3S_VOLUME_DIR}/storages"

k3d cluster create ${CLUSTER_NAME} \
  -p 80:80@loadbalancer \
  -p 443:443@loadbalancer \
  --network ${K3D_NETWORK} \
  --agents ${AGENT_NODES} \
  --registry-config registry-config.yaml \
  --volume "${K3S_MANIFESTS_DIR}:/var/lib/rancher/k3s/server/manifests@server[0]" \
  --volume "${K3S_VOLUME_DIR}/storages:/var/lib/rancher/k3s/storage/@all"

# === test with docker-compose traefik (not yet) ===
# --label "traefik.enable=true@loadbalancer" \
# --label "traefik.http.routers.k3d-https.tls.passthrough=true@loadbalancer" \
# --label "traefik.http.routers.k3d-https.entrypoints=websecure@loadbalancer" \
# --label "traefik.http.routers.k3d-https.rule=hostregexp(\"k8s.internal\", \"{subdomain:.+}.k8s.internal\")@loadbalancer" \
# --label "traefik.http.services.k3d-https.loadbalancer.server.port=443@loadbalancer" \
# --label "traefik.http.routers.k3d-http.entrypoints=web@loadbalancer" \
# --label "traefik.http.routers.k3d-http.rule=hostregexp(\"k8s.internal\", \"{subdomain:.+}.k8s.internal\")@loadbalancer" \
# --label "traefik.http.services.k3d-http.loadbalancer.server.port=80@loadbalancer"
