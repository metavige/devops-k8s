# Local Development for Kubernetes (k3d)

- 嘗試用 kubernetes 來製作 local 開發測試相關的環境
- 複製 [devops-compose](https://github.com/metavige/devops-compose) 環境
- 環境:
  - 這組開發環境，FQDN 為 `*.k8s.internal`
  - 透過 `/etc/resolver` 來重導 FQDN 到 multipass 去
    - 增加 `/etc/resolver/k8s.internal` 檔案，內容為 `nameserver 127.0.0.1`
    - 使用 `dnsmasq`，增加 `address=/k8s.internal/127.0.0.1`
  - 重啟 `dnsmasq` 服務

## k3d

- 參考 https://k3d.io
- 啟用簡單的指令

```shell
$ source .env
$ k3d cluster create ${CLUSTER_NAME} \
    -p 80:80@loadbalancer \
    -p 443:443@loadbalancer \
    --network ${K3D_NETWORK} \
    --servers ${SERVER_NODES} \
    --agents ${AGENT_NODES} \
    --k3s-server-arg "--disable=traefik"
```

- 也可以用 config 設定 ('k3d-devops.yaml`)

```shell
$ source .env
$ k3d cluster create -c k3d-devops.yaml
```

## Traefik

- 先使用 `mkcert` 建立 `*.k8s.internal` 的憑證，放置在 `traefik/certs` 目錄下
- 透過 Helm 安裝 traefik, 可以使用 `base/traefik/traefik-init.sh` 的指令啟動
- 如果需要測試，可以將 `traefik/whoami.yaml` 加入 k8s

## Helm

- 搜尋網站: https://artifacthub.io/

## Storage

- Server 可以掛載 `/var/lib/rancher/k3s/storage/`
