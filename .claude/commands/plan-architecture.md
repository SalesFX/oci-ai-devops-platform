# /plan-architecture

Analise o contexto fornecido e desenhe uma arquitetura OCI completa.

## O que fazer

1. **Entender o contexto**: leia os arquivos existentes em `terraform/`, `kubernetes/` e `docs/`
2. **Desenhar a arquitetura**: use o agent `devops-architect`
3. **Gerar diagrama Mermaid** da topologia de rede e fluxo de dados
4. **Listar componentes OCI** necessários com justificativa
5. **Identificar gaps** na arquitetura atual
6. **Propor melhorias** priorizadas por impacto

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
1. [gap] → [solução proposta]

### Próximos passos
1. [ação prioritária]
```
