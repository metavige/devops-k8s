https://argo-cd.readthedocs.io/en/stable/getting_started/#ingress


## QuickStart

- 安裝

```shell
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

- 取消 argocd server 預設啟動 TLS

增加 args

```shell
--insecure
```