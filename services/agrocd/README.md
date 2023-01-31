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

## 開始使用

- 找到 `argocd/argocd-initial-admin-secret`，取得裡面的密碼
- 進入介面，使用 admin 帳號登入
- 建議改變一下登入密碼