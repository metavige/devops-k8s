
start:
	helm install gitea gitea-charts/gitea -f gitea-values.yaml
	kubectl replace -f ./ingress-route.yaml

stop:
	helm uninstall gitea
	kubectl delete -f ./ingress-route.yaml
