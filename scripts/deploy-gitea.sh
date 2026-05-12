#!/usr/bin/env bash
set -euo pipefail

kubectl apply -f local/gitea/gitea.yaml
kubectl -n gitea rollout status deployment/gitea --timeout=240s

pod="$(kubectl -n gitea get pod -l app=gitea -o jsonpath='{.items[0].metadata.name}')"

kubectl -n gitea exec "$pod" -- su git -c "gitea admin user create --username gitea --password gitea1234 --email gitea@example.com --admin --must-change-password=false" 2>/dev/null || true

echo "Gitea is ready."
echo "Port-forward: kubectl -n gitea port-forward svc/gitea-http 3001:3000"
echo "URL: http://localhost:3001"
echo "Login: gitea / gitea1234"
