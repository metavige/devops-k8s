# Local Development for Kubernetes (k3d)

- 嘗試用 kubernetes 來製作 local 開發測試相關的環境
- 複製 [devops-compose](https://github.com/metavige/devops-compose) 環境
- 環境:
  - 這組開發環境，FQDN 為 `*.k8s.internal`
  - 透過 `/etc/resolver` 來重導 FQDN 到 k3d 去
    - 增加 `/etc/resolver/k8s.internal` 檔案，內容為 `nameserver 127.0.0.1`
    - 使用 `dnsmasq`，增加 `address=/k8s.internal/127.0.0.1`
  - 重啟 `dnsmasq` 服務
  - 僅適用於 docker desktop

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
- 如果需要測試，可以將 `traefik/whoami.yaml` 加入 k8s

## Services

- 這邊的服務，以及上方的 Traefik，有使用 `HelmChart` 的 CRD，這需要 kubernetes 有支援才可以
- 我使用 `k3d` 來建置，有支援 `HelmChart`
- 服務: 
  - argocd: gitops
  - drone: automation CI/CD tool
  - gitea: small git service
  - nexus: package management system
  - jenkins: CI/CD tool

## TODO

- 嘗試不使用 docker desktop，(ex: docker-machine or VM)
- 把不太變動的 files 放入 docker volume 內