# /generate-k8s

Gere manifests Kubernetes ou Helm charts para a aplicação.

## O que fazer

1. Leia os manifests existentes em `kubernetes/` e `helm/`
2. Use o agent `devops-engineer`
3. Gere recursos seguindo os padrões de segurança do `CLAUDE.md`

## Recursos padrão por aplicação

- `Deployment` com probes, resources, securityContext
- `Service` (ClusterIP por padrão)
- `Ingress` com TLS
- `HorizontalPodAutoscaler`
- `PodDisruptionBudget`
- `ServiceAccount` dedicada
- `NetworkPolicy`

## Checklist

- [ ] `resources.requests` e `limits` definidos
- [ ] `livenessProbe` e `readinessProbe` configurados
- [ ] `securityContext` com `runAsNonRoot: true`
- [ ] Tag de imagem não é `latest`
- [ ] `kubectl apply --dry-run=client` passa
