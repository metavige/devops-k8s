
.PHONY: start stop config

start:
	kubectl apply -f config/*.yaml -n kube-system

stop:
	kubectl delete -f config/*.yaml -n kube-system

whoami:
	kubectl apply -f whoami.yaml