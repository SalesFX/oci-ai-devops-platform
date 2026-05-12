$ErrorActionPreference = "Stop"

kubectl apply -k observability
kubectl -n observability rollout status deployment/prometheus --timeout=180s
kubectl -n observability rollout status deployment/grafana --timeout=180s
kubectl -n observability rollout status deployment/loki --timeout=180s
kubectl -n observability rollout status daemonset/alloy --timeout=180s
kubectl -n observability rollout status deployment/alertmanager --timeout=180s
