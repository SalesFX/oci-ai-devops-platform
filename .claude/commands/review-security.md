# /review-security

Revise a postura de seguranca do projeto ou de um output especifico.

## O que fazer

1. **Ler o handoff do engineer**: leia `.claude/context/engineer-output.md` para o escopo da revisao
2. **Ler todos os arquivos relevantes** em `security/`, `kubernetes/`, `terraform/`
3. **Consultar referencias atualizadas** via MCP fetch/brave-search:
   - CIS Benchmarks: `https://www.cisecurity.org/benchmark/kubernetes`
   - OCI Security Guide: `https://docs.oracle.com/en-us/iaas/Content/Security/Concepts/security_guide.htm`
   - CVEs recentes via brave-search quando necessario
4. **Usar o agent `security`** para aplicar o checklist completo
5. **Reportar findings** com severidade e remediacao
6. **Escrever o output** em `.claude/context/security-findings.md`

## Escopo da revisao

- RBAC Kubernetes (ClusterRole, Role, Bindings)
- NetworkPolicies (cobertura, regras)
- Secrets management (External Secrets, Vault)
- Pod Security (securityContext, PSS)
- OCI IAM (Dynamic Groups, Policies)
- Pipeline security (secrets, scan de imagens)
- Configuracoes de rede (NSG, subnets)

## Formato do relatorio

```markdown
## Security Review Report

### Critical
- [finding]: [remediacao]

### High
- [finding]: [remediacao]

### Medium / Low
- [finding]: [remediacao]

### Aprovado
- [controle que esta correto]
```

## Handoff

Apos concluir, escreva o resultado em `.claude/context/security-findings.md` incluindo:
- todos os findings com severidade
- acoes especificas que o `devops-engineer` deve executar para resolver
