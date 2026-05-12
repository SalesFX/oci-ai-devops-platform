# Local Demo with kind

Este modo sobe a parte Kubernetes da arquitetura localmente no Windows usando kind.

Terraform nao entra no fluxo local porque ele provisiona recursos reais na OCI. Aqui validamos:

- build da aplicacao;
- manifests Kubernetes;
- Kustomize;
- ArgoCD;
- Gitea;
- ingress-nginx;
- observability;
- security manifests.

## Requisitos

- Docker/Rancher Desktop com engine ativo
- kind
- kubectl
- helm

## Subir ambiente local

```powershell
.\scripts\bootstrap-local.ps1
```

A app fica acessivel via port-forward:

```powershell
kubectl -n simple-app-local port-forward svc/simple-app 8080:80
```

Depois abra:

```text
http://localhost:8080
```

## ArgoCD local

```powershell
.\scripts\install-argocd.ps1
kubectl -n argocd port-forward svc/argocd-server 8081:443
```

## Gitea local

```powershell
.\scripts\deploy-gitea.ps1
kubectl -n gitea port-forward svc/gitea-http 3001:3000
```

URL:

```text
http://localhost:3001
```

Login local:

```text
gitea / gitea1234
```

URL:

```text
https://localhost:8081
```

Senha inicial:

```powershell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Grafana local

```powershell
kubectl -n observability port-forward svc/grafana 3000:80
```

URL:

```text
http://localhost:3000
```

Login local:

```text
admin / admin
```

## Prometheus local

```powershell
kubectl -n observability port-forward svc/prometheus 9090:9090
```

## Remover ambiente

```powershell
.\scripts\delete-local-cluster.ps1
```
