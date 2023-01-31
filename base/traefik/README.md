# Traefik Init

- 改用 [Kustomization](https://kubernetes.io/zh/docs/tasks/manage-kubernetes-objects/kustomization/#generating-resources) 的方式，將產生 secret 的動作，以及所有資源的建立，一起處理

## 20230131 Updated

- 使用 `manifests/traefik-helmchartconfig.yaml` 來設定 traefik