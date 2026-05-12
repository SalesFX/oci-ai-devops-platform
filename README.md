# OCI AI DevOps Platform

Arquitetura completa de DevOps na Oracle Cloud Infrastructure (OCI) com OKE, OCIR, Terraform, GitOps, observabilidade e seguranca.

## Visao Geral

```text
Developer -> CI/CD -> OCIR -> GitOps repo -> ArgoCD -> OKE
                                      |
Internet -> OCI Load Balancer -> Ingress -> simple-app
                                      |
                         Prometheus + Grafana + Loki + Alloy
```

## Componentes

| Area | O que entrega |
| --- | --- |
| `.claude/` | Agents e comandos para planejar, gerar, revisar e operar a plataforma com Claude Code. |
| `app/` | Aplicacao HTML simples servida por Nginx e empacotada em container. |
| `terraform/` | Infra OCI: VCN, subnets, gateways, NSGs, OKE, OCIR, Vault, Bastion e observabilidade nativa. |
| `kubernetes/` | Manifests base e overlays Kustomize para dev, hml e prod. |
| `helm/` | Chart Helm da aplicacao. |
| `gitops/` | Aplicacoes ArgoCD para sincronizar o cluster com o Git. |
| `pipelines/` | GitLab CI para build, push no OCIR e atualizacao GitOps. |
| `observability/` | Prometheus, Grafana, Loki, Alloy e Alertmanager. |
| `security/` | RBAC, NetworkPolicy, External Secrets e policies de admissao. |
| `docs/` | Documentacao de arquitetura, rede, CI/CD, GitOps, observabilidade e troubleshooting. |
| `scripts/` | Utilitarios para kubeconfig, login no OCIR, deploy local e destroy. |

## Quick Start

### Local com kind

```powershell
.\scripts\bootstrap-local.ps1
kubectl -n simple-app-local port-forward svc/simple-app 8080:80
```

Abra `http://localhost:8080`.

Servicos locais:

- Gitea: `kubectl -n gitea port-forward svc/gitea-http 3001:3000`
- ArgoCD: `kubectl -n argocd port-forward svc/argocd-server 8081:443`
- Grafana: `kubectl -n observability port-forward svc/grafana 3000:80`
- Prometheus: `kubectl -n observability port-forward svc/prometheus 9090:9090`

### OCI

1. Configure as variaveis OCI em `terraform/environments/<env>/variables.tf`.
2. Copie `terraform.tfvars.example` para `terraform.tfvars` no ambiente desejado.
3. Ajuste os placeholders `<namespace>`, `<region>`, `<tenancy-namespace>`, `<group>` e dominios nos manifests.
4. Provisione a infraestrutura:

```bash
cd terraform/environments/dev
terraform init
terraform apply
```

5. Configure o kubeconfig:

```bash
./scripts/setup-kubeconfig.sh dev
```

6. Faca login no OCIR e publique a imagem:

```bash
./scripts/login-ocir.sh
```

7. Aplique a app via Kustomize ou deixe o ArgoCD reconciliar o overlay:

```bash
kubectl apply -k kubernetes/overlays/dev
```

## Estrutura

```text
oci-ai-devops-platform/
|-- .claude/
|-- app/
|-- terraform/
|-- kubernetes/
|-- helm/
|-- gitops/
|-- pipelines/
|-- observability/
|-- security/
|-- docs/
`-- scripts/
```

## Ambientes

| Ambiente | Namespace | Replicas | Uso esperado |
| --- | --- | --- | --- |
| dev | `simple-app-dev` | 1 | Testes rapidos e validacao de infraestrutura. |
| hml | `simple-app-hml` | 2 | Homologacao proxima de producao. |
| prod | `simple-app-prod` | 3 | Operacao com HPA, PDB e politicas restritivas. |

## Documentacao

- [Arquitetura](docs/architecture.md)
- [Networking](docs/networking.md)
- [GitOps Flow](docs/gitops-flow.md)
- [CI/CD](docs/ci-cd.md)
- [Observabilidade](docs/observability.md)
- [Troubleshooting](docs/troubleshooting.md)

## Status

Este repositorio e um blueprint pronto para portifolio e laboratorio. Antes de usar em producao, revise CIDRs, IAM, politicas de seguranca, budgets, retencao de logs, certificados TLS e estrategia de backup.
