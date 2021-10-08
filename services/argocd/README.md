https://argo-cd.readthedocs.io/en/stable/getting_started/#ingress


## QuickStart

- 先到這個目錄

  - 安裝

```shell
helm install argocd argocd-charts --create-namespace -n argocd
```

  - 設定 ingress

```
kubectl apply -f ingressroute.yaml
```

## Notes

- 安裝 Helm Chart 時候，會給一個 release name，如果這個名稱與實際物件的 prefix 重複，就不會出現 release name 在物件名稱前
- 與 Chart name 無關