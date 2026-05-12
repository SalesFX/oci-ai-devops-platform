$ErrorActionPreference = "Stop"

kubectl apply -f local/gitea/gitea.yaml
kubectl -n gitea rollout status deployment/gitea --timeout=240s

$pod = kubectl -n gitea get pod -l app=gitea -o jsonpath="{.items[0].metadata.name}"

kubectl -n gitea exec $pod -- su git -c "gitea admin user create --username gitea --password gitea1234 --email gitea@example.com --admin --must-change-password=false" 2>$null

if ($LASTEXITCODE -ne 0) {
  Write-Host "Gitea admin user may already exist. Continuing."
}

Write-Host "Gitea is ready."
Write-Host "Port-forward: kubectl -n gitea port-forward svc/gitea-http 3001:3000"
Write-Host "URL: http://localhost:3001"
Write-Host "Login: gitea / gitea1234"
