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
- 啟用簡單的指令，參考 `init.sh`

- 也可以用 config 設定 ('k3d-devops.yaml`)

> 這個方式，無法使用 `.env` 檔案內的 `SERVER_NODES`, `AGENT_NODES` 數字

```shell
$ source .env
$ k3d cluster create -c k3d-devops.yaml
```

- 有搭配 [devops-compose](https://github.com/metavige/devops-compose) 內的 nexus 服務，方便離線處理 docker images

## Traefik

- 先使用 `mkcert` 建立 `*.k8s.internal` 的憑證
- 將憑證轉換成 `secret` 物件，並且將設定檔放入 `volumes/manifests/` 目錄下
- 產生 `HelmChartConfig`，將要客製化的設定放入
- 如果需要測試，可以將 `traefik/whoami.yaml` 加入 k8s

## Helm

- 搜尋網站: https://artifacthub.io/

## Storage

- Server 可以掛載 `/var/lib/rancher/k3s/storage/`

## PassThrough traefik on Docker

- 本來嘗試想用同一個 docker traefik 然後做 passthrough
- 可惜發現好像有問題，先不研究了～

```shell
AGENTS=""
for i in $(seq 1 $AGENT_NODES); do
  declare -i j=$i-1
  test ! -z $AGENTS && AGENTS="$AGENTS,$j"
  test -z $AGENTS && AGENTS="$j"
  if [[ $AGENT_NODES -lt 2 ]]; then
    break
  fi
done

k3d cluster create ${CLUSTER_NAME} \
  --no-lb \
  --network ${K3D_NETWORK} \
  --agents ${AGENT_NODES} \
  --registry-config registry-config.yaml \
  --volume ${K3S_MANIFESTS_DIR}:/var/lib/rancher/k3s/server/manifests@server[0] \
  --label "traefik.enable=false@agent[${AGENTS}]" \
  --label "traefik.enable=true@server[0]" \
  --label "traefik.http.routers.k3d-https.tls.passthrough=true@server[0]" \
  --label "traefik.http.routers.k3d-https.entrypoints=websecure@server[0]" \
  --label "traefik.http.routers.k3d-https.rule=hostregexp(\"k8s.internal\", \"{subdomain:.+}.k8s.internal\")@server[0]" \
  --label "traefik.http.services.k3d-https.loadbalancer.server.port=443@server[0]" \
  --label "traefik.http.routers.k3d-http.entrypoints=web@server[0]" \
  --label "traefik.http.routers.k3d-http.rule=hostregexp(\"k8s.internal\", \"{subdomain:.+}.k8s.internal\")@server[0]" \
  --label "traefik.http.services.k3d-http.loadbalancer.server.port=80@server[0]"
  ```