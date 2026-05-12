# Arquitetura

Esta plataforma demonstra um fluxo completo de entrega em OCI:

1. Terraform cria rede, OKE, OCIR, Vault, Bastion e recursos auxiliares.
2. CI/CD constroi a imagem da app e publica no OCIR.
3. O pipeline atualiza a tag em Kustomize.
4. ArgoCD sincroniza o cluster com o estado declarado no Git.
5. Prometheus, Grafana, Loki, Alloy e Alertmanager cobrem metricas, logs e alertas.

## Fluxo de requisicao

Internet -> OCI Load Balancer -> Ingress Controller -> Service -> Pods da `simple-app`.

Os worker nodes ficam em subnet privada. O Load Balancer usa subnet publica e encaminha trafego apenas para as portas expostas pelo Ingress.

## Decisoes principais

- Infra por modulos Terraform para reaproveitar entre dev, hml e prod.
- Overlays Kustomize por ambiente para mudar replicas, recursos, hosts e tags.
- GitOps como mecanismo de deploy, mantendo o cluster reconciliado com Git.
- Vault OCI e External Secrets para evitar secrets estaticos no repositorio.
