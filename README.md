# Tappet Helm charts

```sh
helm repo add tappet https://charts.tappet.dev
helm repo update
helm install tappet tappet/tappet -n tappet --create-namespace

# or straight from the OCI registry
helm install tappet oci://ghcr.io/tappet-dev/charts/tappet -n tappet --create-namespace
```

| Chart | Description |
|---|---|
| [tappet](charts/tappet) | Tappet workflow engine (single node or HA) |

Charts are released automatically when `charts/**` changes on `main`: packaged as GitHub release
assets with the index on the `index` branch (served via https://charts.tappet.dev), and pushed to
`oci://ghcr.io/tappet-dev/charts`. Licensed Apache-2.0.
