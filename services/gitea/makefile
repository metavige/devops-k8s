HELM_CHART=gitea-charts/gitea
RELEASE_NAME=gitea

start:
	helm upgrade --install ${RELEASE_NAME} ${HELM_CHART} -f gitea-values.yaml
	kubectl replace -f ./ingress-route.yaml

stop:
	helm uninstall ${RELEASE_NAME}
	kubectl delete -f ./ingress-route.yaml

pause:
	kubectl scale --replicas=0 statefulset.apps/gitea
	kubectl scale --replicas=0 statefulset.apps/gitea-postgresql
	kubectl scale --replicas=0 deployment.apps/gitea-memcached

resume:
	kubectl scale --replicas=1 statefulset.apps/gitea-postgresql
	kubectl scale --replicas=1 deployment.apps/gitea-memcached
	kubectl scale --replicas=1 statefulset.apps/gitea
