# /plan-architecture

Analise o contexto e desenhe ou revise a arquitetura OCI/local.

## O que fazer

1. **Ler o contexto da sessao**: leia `.claude/context/session.md` para entender o objetivo
2. **Ler o estado atual**: leia `terraform/`, `kubernetes/`, `docs/architecture.md`
3. **Consultar documentacao atualizada** via MCP fetch quando necessario:
   - OCI docs: `https://docs.oracle.com/en-us/iaas/`
   - Terraform Registry OCI: `https://registry.terraform.io/providers/oracle/oci/latest/docs`
   - Kubernetes: `https://kubernetes.io/docs/`
4. **Usar o agent `devops-architect`** para raciocinar sobre a solucao
5. **Gerar diagrama Mermaid** da topologia de rede e fluxo de dados
6. **Listar componentes OCI** com justificativa
7. **Identificar gaps** na arquitetura atual
8. **Escrever o output** em `.claude/context/architect-output.md`

## Output esperado

```markdown
## Arquitetura Proposta

### Diagrama
[mermaid diagram]

### Componentes
- VCN: [justificativa]
- OKE: [justificativa]
...

### Gaps identificados
1. [gap] → [solucao proposta]

### Proximos passos
1. [acao prioritaria]
```

## Handoff

Apos concluir, escreva o resultado em `.claude/context/architect-output.md`.
O `devops-engineer` e o `security` irao ler esse arquivo como input.
