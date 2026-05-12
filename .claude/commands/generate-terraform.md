# /generate-terraform

Gere ou atualize modulos Terraform para OCI.

## O que fazer

1. **Ler o handoff do architect**: leia `.claude/context/architect-output.md` para entender a solucao
2. **Ler modulos existentes** em `terraform/modules/` e `terraform/environments/`
3. **Consultar documentacao atualizada** via MCP fetch quando necessario:
   - Terraform Registry OCI: `https://registry.terraform.io/providers/oracle/oci/latest/docs`
   - OCI Resource Types: `https://docs.oracle.com/en-us/iaas/`
4. **Usar o agent `devops-engineer`** para gerar o codigo
5. **Gerar ou atualizar** os modulos seguindo os padroes do `CLAUDE.md`
6. **Escrever o output** em `.claude/context/engineer-output.md`

## Modulos disponiveis

- `network` — VCN, subnets, gateways, NSG
- `oke` — Cluster OKE, node pools, addons
- `ocir` — Container Registry, politicas de acesso
- `vault` — OCI Vault, secrets, keys
- `bastion` — Bastion Service, sessions
- `observability` — OCI Monitoring, alarms, notifications

## Recursos padrão por modulo

```hcl
terraform {
  required_version = ">= 1.5"
  required_providers {
    oci = { source = "oracle/oci", version = "~> 5.0" }
  }
  backend "s3" {}
}
```

## Checklist antes de entregar

- [ ] `terraform fmt` aplicado
- [ ] `terraform validate` passou
- [ ] Outputs documentados
- [ ] Variaveis com `description` e `type`
- [ ] Tags de ambiente em todos os recursos
- [ ] Nenhum valor sensivel hardcoded

## Handoff

Apos concluir, escreva o resultado em `.claude/context/engineer-output.md` incluindo:
- lista de arquivos gerados/modificados
- variaveis que precisam de valor real
- pontos de atencao para o agente `security`
