# Traefik Init

- 預設要先用下面的指令，產生出 `traefik-certs.yaml` 的設定檔

> 因為安全性問題，不會把這個設定放入 git

```shell
kubectl create secret tls traefik-certs \
  --cert=certs/_wildcard.k8s.internal.pem \
  --key=certs/_wildcard.k8s.internal-key.pem \
  -n kube-system \
  --dry-run=client \
  -o yaml > config/traefik-certs.yaml
```

- 之後可以一次建立所有設定: `kubectl apply -f config/*.yaml`
