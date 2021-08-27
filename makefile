include .env

init:
	sh ./init.sh

destroy:
	k3d cluster delete ${CLUSTER_NAME} && rm -rf ${K3S_MANIFESTS_DIR}

stop:
	k3d cluster stop ${CLUSTER_NAME}

start:
	k3d cluster start ${CLUSTER_NAME}

status:
	k3d cluster list ${CLUSTER_NAME}

traefik:
	cd base/traefik && \
	kubectl apply -k config -n kube-system && \
	cd ${OLDPWD}