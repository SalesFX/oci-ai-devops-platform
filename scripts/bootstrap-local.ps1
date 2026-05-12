$ErrorActionPreference = "Stop"

& "$PSScriptRoot/create-local-cluster.ps1"
& "$PSScriptRoot/deploy-gitea.ps1"
& "$PSScriptRoot/install-ingress-nginx.ps1"
& "$PSScriptRoot/deploy-local.ps1"
& "$PSScriptRoot/deploy-observability.ps1"
& "$PSScriptRoot/install-argocd.ps1"

kubectl get pods -A
