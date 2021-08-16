
start:
	helm install gitea gitea-charts/gitea -f gitea-values.yaml
	kubectl replace -f ./ingress-route.yaml

stop:
	helm uninstall gitea
	kubectl delete -f ./ingress-route.yaml

pause:
	kubectl scale --replicas=0 statefulset.apps/gitea
	kubectl scale --replicas=0 statefulset.apps/gitea-postgresql
	kubectl scale --replicas=0 deployment.apps/gitea-memcached

resume:
	kubectl scale --replicas=1 statefulset.apps/gitea-postgresql
	kubectl scale --replicas=1 deployment.apps/gitea-memcached
	kubectl scale --replicas=1 statefulset.apps/gitea
