# tappet Helm chart

```sh
helm repo add tappet https://charts.tappet.dev
helm install tappet tappet/tappet --namespace tappet --create-namespace \
  --set publicUrl=https://tappet.example.com
```

Single node (default): embedded SQLite on a PersistentVolumeClaim, one replica.
HA: set `database.url` (Postgres), `worker.enabled=true`, and `server.replicas>1`.

See `values.yaml` for every option and https://tappet.dev for documentation.
