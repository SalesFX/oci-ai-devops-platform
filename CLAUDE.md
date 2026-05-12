# CLAUDE.md - OCI AI DevOps Platform

## Contexto do Projeto

Plataforma DevOps completa na OCI com OKE, GitOps via ArgoCD, observabilidade com Prometheus/Grafana/Loki/Alloy/Alertmanager e seguranca com RBAC, NetworkPolicy, External Secrets e policies.

O projeto possui duas frentes:

- demo local com kind, Gitea, ArgoCD, ingress-nginx e observability;
- blueprint OCI com Terraform, OKE, OCIR, Vault, Bastion e GitLab CI.

## Comandos Disponiveis

| Comando | Descricao |
| --- | --- |
| `/plan-architecture` | Desenha ou revisa a arquitetura OCI/local. Escreve handoff em `.claude/context/architect-output.md`. |
| `/generate-terraform` | Gera ou evolui modulos Terraform para OCI. Le architect-output, escreve engineer-output. |
| `/generate-k8s` | Gera manifests Kubernetes, Kustomize e Helm. Le architect-output, escreve engineer-output. |
| `/review-security` | Revisa seguranca. Le engineer-output, escreve security-findings. |
| `/sre` | Configura observabilidade, alertas, SLOs e runbooks. Le engineer-output, escreve sre-output. |

## Agents

| Agent | Papel |
| --- | --- |
| `devops-architect` | Desenha solucoes, define componentes OCI e revisa arquitetura. Le session, escreve architect-output. |
| `devops-engineer` | Gera Terraform, Kubernetes, Helm e pipelines CI/CD. Le architect-output, escreve engineer-output. |
| `sre` | Configura observabilidade, alertas, runbooks e SLOs. Le engineer-output, escreve sre-output. |
| `security` | Revisa RBAC, NetworkPolicy, secrets, OPA/Kyverno e hardening. Le engineer-output, escreve security-findings. |

## Arquitetura de Agentes

### Fluxo de Handoff

Os agentes se comunicam via arquivos em `.claude/context/`:

```
session.md → architect-output.md → engineer-output.md → security-findings.md
                                                        → sre-output.md
```

Antes de iniciar qualquer tarefa complexa, escreva o objetivo em `.claude/context/session.md`.
Cada agente le o output do anterior e escreve o seu proprio antes de passar o trabalho adiante.

### MCP Servers

Configurados em `.claude/settings.json`:

| Servidor | Uso |
| --- | --- |
| `fetch` | Busca docs oficiais: OCI, Terraform Registry, Kubernetes, ArgoCD |
| `brave-search` | Busca web em tempo real: CVEs, changelogs, novos recursos OCI |
| `git` | Inspeciona git log, diff e blame sem precisar de Bash |

Para ativar `brave-search`, defina a variavel de ambiente `BRAVE_API_KEY`.

### Fluxo Completo (exemplo: adicionar novo componente)

```
1. Escreva o objetivo em .claude/context/session.md
2. /plan-architecture  → architect decide como fazer, documenta em architect-output.md
3. /generate-terraform → engineer gera IaC lendo architect-output.md
4. /generate-k8s       → engineer gera manifests lendo architect-output.md
5. /review-security    → security revisa engineer-output.md, escreve findings
6. /generate-terraform → engineer corrige com base nos security-findings.md
7. /sre                → sre configura alertas e dashboards para o novo componente
```

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

## Variaveis Para MCP

```bash
BRAVE_API_KEY=<chave-da-brave-search-api>  # opcional, habilita busca web
```

## Padroes de Codigo

- Terraform: snake_case, outputs documentados, variaveis com `description` e `type`.
- Kubernetes: kebab-case para recursos e labels claras por ambiente.
- Shell scripts: `set -euo pipefail`.
- PowerShell scripts: `$ErrorActionPreference = "Stop"`.
- Nenhum secret real deve ser commitado.
