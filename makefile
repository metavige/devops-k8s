include .env

start:
	k3d cluster create ${CLUSTER_NAME} \
		-p 80:80@loadbalancer \
		-p 443:443@loadbalancer \
		--agents 3 \
		--k3s-server-arg "--disable=traefik"

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