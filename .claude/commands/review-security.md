# /review-security

Revise a postura de segurança do projeto.

## O que fazer

1. Leia todos os arquivos em `security/`, `kubernetes/`, `terraform/`
2. Use o agent `security`
3. Aplique o checklist completo do agent
4. Reporte findings com severidade e remediação

## Escopo da revisão

- RBAC Kubernetes (ClusterRole, Role, Bindings)
- NetworkPolicies (cobertura, regras)
- Secrets management (External Secrets, Vault)
- Pod Security (securityContext, PSS)
- OCI IAM (Dynamic Groups, Policies)
- Pipeline security (secrets, scan de imagens)
- Configurações de rede (NSG, subnets)

## Formato do relatório

```markdown
## Security Review Report

### Critical
- [finding]: [remediação]

### High
- [finding]: [remediação]

### Medium / Low
- [finding]: [remediação]

### Aprovado ✅
- [controle que está correto]
```
