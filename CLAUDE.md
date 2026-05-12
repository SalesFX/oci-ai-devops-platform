# CLAUDE.md - OCI AI DevOps Platform

## Contexto do Projeto

Plataforma DevOps completa na OCI com OKE, GitOps via ArgoCD, observabilidade com Prometheus/Grafana/Loki/Alloy/Alertmanager e seguranca com RBAC, NetworkPolicy, External Secrets e policies.

O projeto possui duas frentes:

- demo local com kind, Gitea, ArgoCD, ingress-nginx e observability;
- blueprint OCI com Terraform, OKE, OCIR, Vault, Bastion e GitLab CI.

## Comandos Disponiveis

| Comando | Descricao |
| --- | --- |
| `/plan-architecture` | Desenha ou revisa a arquitetura OCI/local. |
| `/generate-terraform` | Gera ou evolui modulos Terraform para OCI. |
| `/generate-k8s` | Gera manifests Kubernetes, Kustomize e Helm. |
| `/review-security` | Revisa seguranca: RBAC, NetworkPolicy, secrets e policies. |

## Agents

| Agent | Papel |
| --- | --- |
| `devops-architect` | Desenha solucoes, define componentes OCI e revisa arquitetura. |
| `devops-engineer` | Gera Terraform, Kubernetes, Helm e pipelines CI/CD. |
| `sre` | Configura observabilidade, alertas, runbooks e SLOs. |
| `security` | Revisa RBAC, NetworkPolicy, secrets, OPA/Kyverno e hardening. |

## Convencoes

### Terraform

- Modulos em `terraform/modules/`.
- Ambientes em `terraform/environments/{dev,hml,prod}/`.
- Backend remoto em OCI Object Storage compativel com S3.
- Variaveis sensiveis fora do Git.
- Secrets reais via OCI Vault/External Secrets.

### Kubernetes

- Base em `kubernetes/base/`.
- Overlays em `kubernetes/overlays/{local,dev,hml,prod}/`.
- Namespaces: `simple-app-local`, `simple-app-dev`, `simple-app-hml`, `simple-app-prod`.
- Labels principais: `app`, `env`, `managed-by`.

### Imagens Docker

- OCI: `{region}.ocir.io/{namespace}/{repo}:{tag}`.
- Local: `simple-app:local`.
- Tag OCI: `{env}-{git-sha-7}`.
- Dockerfile multi-stage.

### GitOps

- ArgoCD como ferramenta principal.
- Local: ArgoCD sincroniza do Gitea interno.
- OCI: ArgoCD sincroniza do GitLab/Git remoto real.
- Promocao entre ambientes por alteracao de tag nos overlays.

### CI/CD

- GitLab CI e o pipeline oficial.
- Build da imagem.
- Push para OCIR.
- Atualizacao do overlay Kustomize.
- ArgoCD reconcilia o cluster.

## Variaveis Necessarias Para OCI

```bash
OCI_TENANCY_OCID=ocid1.tenancy.oc1..xxx
OCI_USER_OCID=ocid1.user.oc1..xxx
OCI_FINGERPRINT=xx:xx:xx:...
OCI_REGION=sa-saopaulo-1
OCIR_NAMESPACE=<tenancy-namespace>
```

## Padroes de Codigo

- Terraform: snake_case, outputs documentados, variaveis com `description` e `type`.
- Kubernetes: kebab-case para recursos e labels claras por ambiente.
- Shell scripts: `set -euo pipefail`.
- PowerShell scripts: `$ErrorActionPreference = "Stop"`.
- Nenhum secret real deve ser commitado.
