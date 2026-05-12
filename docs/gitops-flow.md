# GitOps Flow

Este projeto usa ArgoCD como ferramenta GitOps unica.

## ArgoCD

Os manifests em `gitops/argocd/applications` apontam para overlays Kustomize:

- `kubernetes/overlays/dev`
- `kubernetes/overlays/hml`
- `kubernetes/overlays/prod`

Quando uma tag muda no Git, o ArgoCD reconcilia o ambiente automaticamente e aplica o estado declarado no cluster.

Antes de aplicar, troque `https://gitlab.com/<group>/oci-ai-devops-platform.git` pela URL real do projeto no GitLab.

## Promocao

Um fluxo simples e:

1. Commit em `main` gera imagem `dev-<sha>`.
2. Homologacao promove a mesma imagem para `hml`.
3. Aprovacao manual promove a tag para `prod`.

## Operacao

Use a UI do ArgoCD para acompanhar `sync`, `health`, diff de manifests e historico de deploy. Em producao, habilite RBAC, SSO e projetos com escopo por ambiente.
