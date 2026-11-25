# Tappet Helm charts

```sh
helm repo add tappet https://charts.tappet.dev
helm repo update
helm install tappet tappet/tappet -n tappet --create-namespace
```

| Chart | Description |
|---|---|
| [tappet](charts/tappet) | Tappet workflow engine (single node or HA) |

Charts are released automatically by chart-releaser when `charts/**` changes on `main`.
Licensed Apache-2.0.
