# CLAUDE.md — OCI AI DevOps Platform

## Contexto do Projeto

Plataforma DevOps completa na OCI com OKE, GitOps via ArgoCD, observabilidade com Prometheus/Grafana/Loki e segurança com RBAC/NetworkPolicy/OPA.

## Comandos Disponíveis

| Comando | Descrição |
|---------|-----------|
| `/plan-architecture` | Desenha ou revisa a arquitetura OCI |
| `/generate-terraform` | Gera módulos Terraform para OCI |
| `/generate-k8s` | Gera manifests Kubernetes/Helm |
| `/review-security` | Revisa segurança (RBAC, NetworkPolicy, OPA) |

## Agents

- **devops-architect** — Desenha soluções, define componentes OCI, revisa arquitetura
- **devops-engineer** — Gera Terraform, Kubernetes, Helm, pipelines CI/CD
- **sre** — Configura observabilidade, alertas, runbooks, SLOs
- **security** — Revisa RBAC, NetworkPolicy, secrets, OPA policies

## Convenções

### Terraform
- Módulos em `terraform/modules/`
- Ambientes em `terraform/environments/{dev,hml,prod}/`
- Backend: OCI Object Storage
- Variáveis sensíveis via OCI Vault

### Kubernetes
- Kustomize para gerenciar ambientes
- Base em `kubernetes/base/`, overlays em `kubernetes/overlays/{env}/`
- Namespaces: `simple-app-{dev,hml,prod}`
- Labels obrigatórias: `app`, `env`, `version`

### Imagens Docker
- Registry: `{region}.ocir.io/{tenancy}/{repo}:{tag}`
- Tag: `{env}-{git-sha-7}`
- Multi-stage build obrigatório

### GitOps
- ArgoCD como ferramenta principal
- Sync automático apenas em dev
- hml e prod requerem aprovação manual

## Variáveis de Ambiente Necessárias

```bash
OCI_TENANCY_OCID=ocid1.tenancy.oc1..xxx
OCI_USER_OCID=ocid1.user.oc1..xxx
OCI_FINGERPRINT=xx:xx:xx:...
OCI_REGION=sa-saopaulo-1
OCIR_NAMESPACE=<tenancy-namespace>
```

## Padrões de Código

- Terraform: snake_case, outputs documentados, variáveis com description e type
- K8s: kebab-case para recursos, camelCase para campos
- Shell scripts: `set -euo pipefail`, validação de deps no início
