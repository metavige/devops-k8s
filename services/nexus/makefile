HELM_CHART=stevehipwell/nexus3
RELEASE_NAME=nexus3

start:
	kubectl apply -f nexus-helmchart.yaml

stop:
	kubectl delete -f nexus-helmchart.yaml

pause:
	kubectl scale deployment.apps/nexus3 --replicas=0

resume:
	kubectl scale deployment.apps/nexus3 --replicas=1