# Troubleshooting

## O pod nao sobe

```bash
kubectl -n simple-app-dev describe pod -l app=simple-app
kubectl -n simple-app-dev logs deploy/simple-app
```

Verifique imagem, pull secret do OCIR, recursos e security context.

## Ingress nao responde

```bash
kubectl get ingress -A
kubectl get svc -A | grep LoadBalancer
```

Confirme DNS, certificado TLS, ingress controller e regras de NSG.

## ArgoCD nao sincroniza

```bash
kubectl -n argocd get applications
kubectl -n argocd describe application simple-app-dev
```

Confira repo URL, path, branch e permissao de acesso ao Git.

## Terraform falha no backend

Revise bucket, namespace Object Storage, endpoint S3 compatible e credenciais OCI.
