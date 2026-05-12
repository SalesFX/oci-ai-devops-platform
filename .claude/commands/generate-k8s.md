# /generate-k8s

Gere manifests Kubernetes, overlays Kustomize ou Helm charts.

## O que fazer

1. **Ler o handoff do architect**: leia `.claude/context/architect-output.md` para entender a solucao
2. **Ler manifests existentes** em `kubernetes/` e `helm/`
3. **Consultar documentacao atualizada** via MCP fetch quando necessario:
   - Kubernetes API: `https://kubernetes.io/docs/reference/`
   - Kustomize: `https://kubectl.docs.kubernetes.io/`
   - Helm: `https://helm.sh/docs/`
4. **Usar o agent `devops-engineer`** para gerar o codigo
5. **Gerar recursos** seguindo os padroes de seguranca do `CLAUDE.md`
6. **Escrever o output** em `.claude/context/engineer-output.md`

## Recursos padrao por aplicacao

- `Deployment` com probes, resources, securityContext
- `Service` (ClusterIP por padrao)
- `Ingress` com TLS
- `HorizontalPodAutoscaler`
- `PodDisruptionBudget`
- `ServiceAccount` dedicada
- `NetworkPolicy`

## Checklist antes de entregar

- [ ] `resources.requests` e `limits` definidos
- [ ] `livenessProbe` e `readinessProbe` configurados
- [ ] `securityContext` com `runAsNonRoot: true`
- [ ] Tag de imagem nao e `latest`
- [ ] `kubectl apply --dry-run=client` passou
- [ ] Labels `app`, `env`, `managed-by` em todos os recursos

## Handoff

Apos concluir, escreva o resultado em `.claude/context/engineer-output.md` incluindo:
- lista de arquivos gerados/modificados
- instrucoes de apply por ambiente
- pontos de atencao para o agente `security`
