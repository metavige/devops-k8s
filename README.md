# Local Development for Kubernetes (k3s)

- 嘗試用 kubernetes 來製作 local 開發測試相關的環境
- 複製 [devops-compose](https://github.com/metavige/devops-compose) 環境
- 環境:
  - 這組開發環境，FQDN 為 `*.k8s.internal`
  - 透過 `/etc/resolver` 來重導 FQDN 到 multipass 去
    - 增加 `/etc/resolver/k8s.internal` 檔案，內容為 `nameserver 127.0.0.1`
    - 使用 `dnsmasq`，增加 `address=/k8s.internal/[multipass ip]` (目前這個動作還需要手動做)
  - 重啟 `dnsmasq` 服務

## Multipass

- 要參考 [Multipass - Network](https://multipass.run/docs/troubleshooting-networking-on-macos#generic-networking-problems)
  會使用 k3s 安裝在 multipass 內，當作 k8s 的基礎。如果有需要，可以增加 agent。(只要有資源)

## k3s

- 參考 https://k3s.io
- 透過 `init.sh` 初始化 multipass + k3s 環境
  - CPU - '1'
  - MEMORY - '4g'
  - DISK - '10g'

## k3s - Traefik

- 預設會安裝一個 Klipper LB 的套件: `rancher/klipper-lb:v0.2.0` (https://github.com/k3s-io/klipper-lb)
- 這個套件，會 bind 80/443 這兩個 port 在本機上  
  (會用 iptables 的方式轉換，以及 hostPort，讓封包轉到 kubernetes 內部)
- traefik 預設不會將 9000 dashboard export 出來
- 先使用 `mkcert '*.k8s.internal'` 工具產生憑證檔案
- 進入到 `traefik` 目錄，執行 `patch.sh` 會將 SSL 相關設定放入 traefik
