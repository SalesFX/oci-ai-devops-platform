# /sre

Configure ou evolua a stack de observabilidade, alertas, SLOs e runbooks.

## O que fazer

1. **Ler o contexto da sessao**: leia `.claude/context/session.md` e `.claude/context/engineer-output.md`
2. **Ler a stack existente** em `observability/` e `docs/observability.md`
3. **Consultar documentacao atualizada** via MCP fetch quando necessario:
   - Prometheus: `https://prometheus.io/docs/`
   - Grafana: `https://grafana.com/docs/`
   - Loki: `https://grafana.com/docs/loki/latest/`
   - Alertmanager: `https://prometheus.io/docs/alerting/latest/alertmanager/`
4. **Usar o agent `sre`** para raciocinar sobre SLOs, alertas e dashboards
5. **Gerar ou atualizar** manifests, dashboards e runbooks
6. **Escrever o output** em `.claude/context/sre-output.md`

## Tarefas comuns

### Adicionar alerta
Gere uma PrometheusRule com:
- `expr` baseada em metricas existentes
- `for` adequado para evitar flapping
- `labels.severity: critical | warning`
- `annotations.summary` e `annotations.description` claros

### Criar dashboard Grafana
- Use o formato JSON do Grafana
- Inclua painel de disponibilidade, latencia p99 e taxa de erro
- Adicione variaveis de namespace e ambiente

### Definir SLO
- Documente em `docs/slo.md` (crie se nao existir)
- Inclua metrica, objetivo, janela de tempo e error budget

### Escrever runbook
Use o formato:
```markdown
## Alerta: [Nome]
**Severidade**: critical/warning
**Descricao**: O que esta acontecendo
**Impacto**: O que o usuario sente
**Diagnostico**: Comandos para investigar
**Resolucao**: Passos para corrigir
**Escalacao**: Quando e para quem escalar
```

## Alertas criticos (sempre verificar se existem)

1. Pod CrashLoopBackOff
2. Node NotReady
3. Disco > 80%
4. Memoria > 90%
5. Latencia p99 > SLO
6. Taxa de erro > SLO
7. Certificate expiring < 30 dias

## Checklist antes de entregar

- [ ] Alertas testados com `promtool check rules`
- [ ] Dashboards validados no Grafana local
- [ ] Runbooks linkados nos annotations dos alertas
- [ ] SLOs documentados

## Handoff

Apos concluir, escreva o resultado em `.claude/context/sre-output.md` incluindo:
- SLOs definidos ou revisados
- alertas configurados
- dashboards criados ou atualizados
- recomendacoes de resources para o `devops-engineer`
