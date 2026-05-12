# CI/CD

Este projeto usa GitLab CI como pipeline oficial.

## GitLab CI

O arquivo raiz `.gitlab-ci.yml` inclui `pipelines/gitlab-ci/.gitlab-ci.yml`, que faz:

1. Build da imagem Docker em `app/`.
2. Login no OCIR.
3. Push das tags `<env>-<sha>` e `<env>-latest`.
4. Atualizacao da tag no overlay Kustomize do ambiente.
5. Commit da mudanca GitOps no repositorio.
6. ArgoCD detecta a mudanca no Git e sincroniza o cluster.

## Variaveis Esperadas

Configure estas variaveis no GitLab em `Settings > CI/CD > Variables`:

- `OCIR_NAMESPACE`
- `OCI_TENANCY_NAMESPACE`
- `OCI_USERNAME`
- `OCI_AUTH_TOKEN`
- `GITLAB_TOKEN`

## Fluxo

```text
Commit -> GitLab CI -> Docker build -> OCIR -> update Kustomize -> Git -> ArgoCD -> OKE
```

## Promocao

Use a variavel `ENVIRONMENT` para escolher o ambiente alvo. O padrao atual e `dev`; para `hml` e `prod`, crie jobs com regras de branch/tag ou aprovacao manual.

Observacao: runners Docker-in-Docker normalmente precisam executar em modo privilegiado.
