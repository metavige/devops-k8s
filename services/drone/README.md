## gitea integration

- 先登入到 gitea, 建立一個應用程式，取得 clientId/clientSecret

## 結合 gitea

- 要另外建立一個 `secret`: `gitea-oauth-secrets`
- 用來存放 gitea 的 `DRONE_GITEA_CLIENT_ID`/`DRONE_GITEA_CLIENT_SECRET`, 以及 `DRONE_RPC_SECRET`
- 透過設定 `DRONE_GITEA_SKIP_VERIFY: true` 忽略 SSL 驗證，因為目前憑證是 self hosted 的，無法提供給 drone

```shell
$ kubectl create secret generic gitea-oauth-secrets \
    --from-literal DRONE_RPC_SECRET="<secret>" \
    --from-literal DRONE_GITEA_CLIENT_ID="<clientId>" \
    --from-literal DRONE_GITEA_CLIENT_SECRET="<clientSecret>"
```

DRONE_RPC_SECRET 產生方式: 

```shell
$ openssl rand -hex 16
```

## runner

- 參考 https://docs.drone.io/runner/kubernetes/installation/