# Agentes Claude Code

Este documento descreve como usar os agentes, commands, MCP servers e o sistema de handoff que compoe a camada de automacao do projeto.

## Visao Geral

A plataforma usa Claude Code com quatro agentes especializados que se comunicam via arquivos em `.claude/context/`. Cada agente le o output do anterior, realiza seu trabalho e escreve um arquivo de handoff para o proximo.

```text
session.md
    └─> architect-output.md   (/plan-architecture)
            └─> engineer-output.md  (/generate-terraform, /generate-k8s)
                    ├─> security-findings.md  (/review-security)
                    └─> sre-output.md         (/sre)
```

## Agentes

### devops-architect

**Arquivo**: `.claude/agents/devops-architect.md`

**Quando usar**: antes de qualquer implementacao nova. O architect define o "como" antes do engineer escrever codigo.

**Le**: `.claude/context/session.md`

**Escreve**: `.claude/context/architect-output.md`

**Aciona via**: `/plan-architecture`

**Ferramentas MCP**: `fetch` (docs OCI/Terraform/K8s), `brave-search` (novos recursos, changelogs)

---

### devops-engineer

**Arquivo**: `.claude/agents/devops-engineer.md`

**Quando usar**: para gerar ou atualizar Terraform, manifests Kubernetes, Helm charts ou pipelines CI/CD.

**Le**: `.claude/context/architect-output.md`, `.claude/context/security-findings.md`

**Escreve**: `.claude/context/engineer-output.md`

**Aciona via**: `/generate-terraform`, `/generate-k8s`

**Ferramentas MCP**: `fetch` (Terraform Registry, K8s API), `brave-search` (exemplos, issues), `git` (historico de mudancas)

---

### sre

**Arquivo**: `.claude/agents/sre.md`

**Quando usar**: para configurar ou evoluir a stack de observabilidade, criar alertas, SLOs e runbooks.

**Le**: `.claude/context/session.md`, `.claude/context/engineer-output.md`

**Escreve**: `.claude/context/sre-output.md`

**Aciona via**: `/sre`

**Ferramentas MCP**: `fetch` (Prometheus/Grafana/Loki docs), `brave-search` (dashboards da comunidade, alertas recomendados)

---

### security

**Arquivo**: `.claude/agents/security.md`

**Quando usar**: para revisar qualquer output do engineer antes de aplicar em producao.

**Le**: `.claude/context/engineer-output.md`

**Escreve**: `.claude/context/security-findings.md`

**Aciona via**: `/review-security`

**Ferramentas MCP**: `fetch` (CIS Benchmarks, OCI Security Guide), `brave-search` (CVEs recentes), `git` (busca por secrets expostos)

---

## Commands

### /plan-architecture

Aciona o `devops-architect`. Gera diagrama Mermaid, lista componentes OCI com justificativa e identifica gaps.

```text
/plan-architecture adicionar Redis como cache
```

### /generate-terraform

Aciona o `devops-engineer` para IaC. Le o architect-output e gera ou atualiza modulos em `terraform/modules/`.

```text
/generate-terraform modulo Redis para OCI Cache
```

### /generate-k8s

Aciona o `devops-engineer` para manifests. Le o architect-output e gera recursos em `kubernetes/` ou `helm/`.

```text
/generate-k8s deployment do Redis com NetworkPolicy
```

### /review-security

Aciona o `security`. Le o engineer-output e reporta findings com severidade e remediacao.

```text
/review-security
```

### /sre

Aciona o `sre`. Le o engineer-output e gera alertas PrometheusRule, dashboards Grafana e runbooks.

```text
/sre alertas para o Redis
```

## MCP Servers

Configurados em `.claude/settings.json`. Ficam disponiveis para todos os agentes automaticamente.

Apenas o `fetch` e obrigatorio. Os outros dois sao opcionais — se nao estiverem disponiveis, os agentes caem automaticamente nos fallbacks descritos abaixo.

### fetch (obrigatorio)

Busca qualquer URL publica. Usado pelos agentes para ler docs oficiais sem depender do conhecimento de treinamento.

Sem dependencias externas — funciona imediatamente apos clonar o projeto.

Exemplos de uso nos agentes:
- OCI docs: `https://docs.oracle.com/en-us/iaas/`
- Terraform Registry: `https://registry.terraform.io/providers/oracle/oci/latest/docs`
- Kubernetes API: `https://kubernetes.io/docs/reference/`
- ArgoCD: `https://argo-cd.readthedocs.io/`
- Prometheus: `https://prometheus.io/docs/`

### brave-search (opcional)

Busca web em tempo real: CVEs recentes, changelogs, novos recursos OCI.

**Requer** a variavel de ambiente `BRAVE_API_KEY`. Se ausente, o servidor nao sobe — os agentes usam apenas `fetch` para docs oficiais.

Como obter:
1. Acesse `https://brave.com/search/api/`
2. Crie uma conta e gere uma API key gratuita (2000 buscas/mes)
3. Defina `BRAVE_API_KEY=<sua-chave>` no ambiente antes de abrir o Claude Code

**Fallback sem a chave**: use `fetch` diretamente com URLs de CVE databases e changelogs. Os agentes continuam funcionando — perdem apenas a busca livre por termos.

### git (opcional)

Permite que os agentes inspecionem o repositorio (`git log`, `diff`, `blame`) sem precisar do Bash tool.

**Requer** `uvx`, que vem com o Python package manager `uv`.

```bash
pip install uv
# ou (sem Python pre-instalado)
curl -LsSf https://astral.sh/uv/install.sh | sh
```

**Fallback sem uvx**: os agentes usam o Bash tool com comandos `git` normalmente. A permissao `Bash(git:*)` ja esta no `settings.json` para isso.

## Handoff — `.claude/context/`

Os arquivos em `.claude/context/` sao o mecanismo de comunicacao entre agentes. Os agentes os criam e preenchem durante a sessao.

> **Versionamento**: os arquivos `.md` deste diretorio estao no `.gitignore` — conteudo real de sessao nao e commitado. O diretorio e mantido no repo via `.gitkeep`. Em um clone novo, os arquivos serao criados pelos agentes na primeira sessao.

| Arquivo | Escrito por | Lido por |
| --- | --- | --- |
| `session.md` | usuario / orquestrador | todos os agentes |
| `architect-output.md` | devops-architect | devops-engineer, security |
| `engineer-output.md` | devops-engineer | security, sre |
| `security-findings.md` | security | devops-engineer (ciclo de correcao) |
| `sre-output.md` | sre | orquestrador (relatorio final) |

### Como iniciar uma sessao

Antes de usar qualquer command, escreva o objetivo em `.claude/context/session.md`:

```markdown
## Objetivo da Sessao
Adicionar Redis como cache da simple-app no ambiente dev.

## Escopo
- Ambiente alvo: dev
- Componente: redis + simple-app
- Tipo de trabalho: novo recurso

## Restricoes
- Usar OCI Cache Service, nao Redis auto-hospedado
- Nao ultrapassar $50/mes no ambiente dev
```

### Ciclo de correcao

Quando o security encontra findings, o engineer deve fazer um segundo ciclo:

```
/review-security          # security escreve security-findings.md
/generate-terraform       # engineer le findings e corrige
/review-security          # security valida as correcoes
```

## Exemplo Completo

### Objetivo: adicionar Horizontal Pod Autoscaler na simple-app

**Passo 1** — escreva o contexto:

```markdown
# .claude/context/session.md
## Objetivo da Sessao
Adicionar HPA para a simple-app no ambiente prod.
Metrica: CPU > 70% por 2 minutos.
Min: 3 replicas, Max: 10 replicas.
```

**Passo 2** — planeje:

```text
/plan-architecture HPA para simple-app com base em CPU
```

**Passo 3** — gere o manifest:

```text
/generate-k8s HorizontalPodAutoscaler para simple-app prod
```

**Passo 4** — revise:

```text
/review-security
```

**Passo 5** — configure alertas:

```text
/sre alerta de HPA ao limite de replicas
```

## Estrutura de Arquivos

```text
.claude/
|-- settings.json          # MCP servers (fetch, brave-search, git) e permissoes
|-- agents/
|   |-- devops-architect.md
|   |-- devops-engineer.md
|   |-- sre.md
|   `-- security.md
|-- commands/
|   |-- plan-architecture.md
|   |-- generate-terraform.md
|   |-- generate-k8s.md
|   |-- review-security.md
|   `-- sre.md
`-- context/
    |-- session.md          # objetivo da sessao atual
    |-- architect-output.md # decisoes do architect
    |-- engineer-output.md  # codigo gerado pelo engineer
    |-- security-findings.md # findings do security
    `-- sre-output.md       # SLOs, alertas e runbooks do sre
```
