### Reference

- https://artifacthub.io/packages/helm/stevehipwell/nexus3
- https://blog.sonatype.com/kubernetes-recipe-sonatype-nexus-3-as-a-private-docker-registry

```shell
helm repo add stevehipwell https://stevehipwell.github.io/helm-charts/
```

### TODO

- 可以很簡單的建立一個 Nexus 沒有問題
- 但是，之前 docker-compose 部分，自己有實作 docker request over nginx 的部分，看是否有機會實作出來
  - https://github.com/metavige/devops-compose/tree/master/nexus
- Persistence 設定
