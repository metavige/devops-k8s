# Local Development for Kubernetes (k3d)

- 嘗試用 kubernetes 來製作 local 開發測試相關的環境
- 複製 [devops-compose](https://github.com/metavige/devops-compose) 環境
- 環境:
  - 這組開發環境，FQDN 為 `*.k8s.internal`
  - 透過 `/etc/resolver` 來重導 FQDN 到 k3d 去
    - 增加 `/etc/resolver/k8s.internal` 檔案，內容為 `nameserver 127.0.0.1`
    - 使用 `dnsmasq`，增加 `address=/k8s.internal/127.0.0.1`
  - 重啟 `dnsmasq` 服務
  - podman 需要使用 `podman machine set --rootful=true`

## k3d

- 參考 https://k3d.io
- 啟用簡單的指令，參考 `init.sh`

- 也可以用 config 設定 ('k3d-devops.yaml`)

> config 設定，無法使用 `.env` 檔案內的 `SERVER_NODES`, `AGENT_NODES` 數字，會有錯誤

```shell
$ source .env
$ k3d cluster create -c k3d-devops.yaml
```

- [Optional] 有搭配 [devops-compose](https://github.com/metavige/devops-compose) 內的 nexus 服務，方便離線處理 docker images

## Traefik

- 先使用 [mkcert](https://github.com/FiloSottile/mkcert) 建立 `*.k8s.internal` 的憑證
- 將憑證轉換成 `secret` 物件，並且將設定檔放入 `volumes/manifests/` 目錄下
- 產生 `HelmChartConfig`，將要客製化的設定放入
- 如果需要測試，可以將 `base/traefik/whoami.yaml` 加入 k8s

## 20230131 更新

- 增加 taskfile 的使用
- `makefile`, `init.sh` 之後不會再使用