start:
	sh ./traefik-init.sh

stop:
	helm uninstall traefik
	kubectl delete IngressRoute/traefik-dashboard -n kube-system

whoami:
	kubectl apply -f whoami.yaml