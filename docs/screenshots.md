# Portfolio Screenshots

Use esta lista para capturar evidencias da demo local.

## Cluster

```powershell
kubectl get nodes -o wide
kubectl get pods -A
kubectl -n simple-app-local get pod -o wide
```

Print recomendado: terminal mostrando 1 control-plane, 2 workers e a `simple-app` rodando em worker.

## GitOps

```powershell
kubectl -n argocd get application simple-app-local
kubectl -n argocd describe application simple-app-local
```

Print recomendado: UI do ArgoCD com `simple-app-local` em `Synced` e `Healthy`.

## App

```powershell
Invoke-WebRequest -Uri "http://localhost:8080/healthz" -UseBasicParsing
```

Print recomendado: navegador em `http://localhost:8080`.

## Observability

```powershell
kubectl -n observability get pods
kubectl -n observability port-forward svc/grafana 3000:80
kubectl -n observability port-forward svc/prometheus 9090:9090
```

Print recomendado: dashboard `Simple App - Local GitOps Demo` no Grafana.

No Grafana, use tambem o datasource `Loki` em `Explore` com a query:

```logql
{namespace="simple-app-local", app="simple-app"}
```

Se quiser filtrar por container:

```logql
{namespace="simple-app-local", app="simple-app", container="app"}
```

## Gitea

```powershell
kubectl -n gitea get pods,svc,pvc
kubectl -n gitea port-forward svc/gitea-http 3001:3000
```

Print recomendado: repo `gitops/oci-ai-devops-platform` no Gitea.

## Onde salvar

Salve as imagens em:

```text
docs/img/
```

Nomes sugeridos:

```text
01-kind-nodes.png
02-pods-all-namespaces.png
03-app-worker-node.png
04-argocd-synced-healthy.png
05-gitea-repo.png
06-simple-app-browser.png
07-grafana-dashboard.png
08-prometheus-query.png
09-alert-manager.png
```
