include .env

start:
	k3d cluster create -c k3d-devops.yaml

stop:
	k3d cluster delete ${CLUSTER_NAME}

pause:
	k3d cluster stop ${CLUSTER_NAME}

resume:
	k3d cluster start ${CLUSTER_NAME}

status:
	k3d cluster list ${CLUSTER_NAME}

traefik:
	cd base/traefik && \
	sh ./traefik-init.sh && \
	cd ${OLDPWD}