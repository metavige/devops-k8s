### Reference

- https://docs.gitea.io/en-us/install-on-kubernetes/
- https://gitea.com/gitea/helm-chart/
- https://docs.gitea.io/en-us/config-cheat-sheet/

```shell
helm repo add gitea-charts https://dl.gitea.io/charts/
helm upgrade --install gitea gitea-charts/gitea -f gitea-values.yaml
```

- gitea-values.yaml

```yaml:gitea-values.yaml
resources:
  limits:
    cpu: 100m
    memory: 128Mi
persistence:
  enabled: true
  size: 1Gi
  accessModes:
    - ReadWriteOnce
postgresql:
  persistence:
    size: 1Gi
gitea:
  admin:
    username: gitea
    password: gitea
```
