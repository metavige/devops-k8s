# DevOps

- 嘗試用 kubernetes 來製作 local 開發測試相關的環境
- 要複製 [devops-compose](https://github.com/metavige/devops-compose) 環境

## Multipass

- 要參考 [Multipass - Network](https://multipass.run/docs/troubleshooting-networking-on-macos#generic-networking-problems)
  會使用 k3s 安裝在 multipass 內，當作 k8s 的基礎。如果有需要，可以增加 agent。(只要有資源)

## k3s

- 參考 https://k3s.io
- 透過 `init.sh` 初始化 multipass + k3s 環境

## k3s - Traefik

- 預設會安裝一個 Klipper LB 的套件 : `rancher/klipper-lb:v0.2.0`
- 這個套件，會 bind 80/443 這兩個 port 在本機上  
  (會用 iptables 的方式轉換，以及 hostPort，讓封包轉到 kubernetes 內部)
- traefik 預設不會將 9000 dashboard export 出來
- 先使用 `mkcert '*.k8s.internal'` 工具產生憑證檔案
- 進入到 `traefik` 目錄，執行 `patch.sh` 會將 SSL 相關設定放入 traefik
