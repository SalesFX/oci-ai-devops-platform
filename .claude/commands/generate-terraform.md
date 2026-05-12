# /generate-terraform

Gere ou atualize módulos Terraform para OCI.

## O que fazer

1. Leia os módulos existentes em `terraform/modules/`
2. Use o agent `devops-engineer`
3. Gere código seguindo os padrões do `CLAUDE.md`
4. Sempre incluir: `variables.tf`, `main.tf`, `outputs.tf`
5. Validar que não há valores hardcoded

## Módulos disponíveis

- `network` — VCN, subnets, gateways, NSG
- `oke` — Cluster OKE, node pools, addons
- `ocir` — Container Registry, políticas de acesso
- `vault` — OCI Vault, secrets, keys
- `bastion` — Bastion Service, sessions
- `observability` — OCI Monitoring, alarms, notifications

## Checklist

- [ ] `terraform fmt` aplicado
- [ ] `terraform validate` passa
- [ ] Outputs documentados
- [ ] Variáveis com `description` e `type`
- [ ] Tags de ambiente em todos os recursos
