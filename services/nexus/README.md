### Reference

- https://artifacthub.io/packages/helm/stevehipwell/nexus3
- https://blog.sonatype.com/kubernetes-recipe-sonatype-nexus-3-as-a-private-docker-registry

```shell
helm repo add stevehipwell https://stevehipwell.github.io/helm-charts/
helm upgrade --install nexus3 stevehipwell/nexus3 -f nexus-values.yaml
```

```yaml
persistence:
  enabled: true
service:
  additionalPorts:
    - port: 5000
      name: docker-group
      containerPort: 5000
      host: nexus.k8s.internal
config:
  rootPassword:
    secret: nexus-secret
    key: password
```

### TODO

- [ ] 想方法取得 docker ip，設定給 yaml 使用
- [ ] 修改 `init.sh`，讓這個動作可以自動話，不需要自行修改
- [ ] 如果是第一次建立，還需要自行到內部去建立一個 docker proxy/group，並且 expose port 5000，才能使用

## redirect to docker

- 改直接連線到 docker 的服務

```shell
NEXUS_IP=`docker inspect nexus_nginx_1 -f '{{.NetworkSettings.Networks.devops.IPAddress}}'`
```

- 把這個設定加入到 coredns 的 configmap 設定