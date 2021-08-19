
.PHONY: start stop config

start:
	kubectl apply -k config -n kube-system

stop:
	kubectl delete -l app=traefik -n kube-system

whoami:
	kubectl apply -f whoami.yaml