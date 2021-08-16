RELEASE_NAME=nexus3

start:
	helm upgrade --install -n default ${RELEASE_NAME} stevehipwell/nexus3
	kubectl apply -f ingress-route.yaml

stop:
	helm uninstall ${RELEASE_NAME}
	kubectl delete -f ingress-route.yaml

pause:
	kubectl scale deployment.apps/nexus3 --replicas=0

resume:
	kubectl scale deployment.apps/nexus3 --replicas=1