#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${KIND_CLUSTER_NAME:-oci-devops-local}"
IMAGE_NAME="${IMAGE_NAME:-simple-app:local}"

docker build --build-arg ENV=local --build-arg VERSION=local -t "$IMAGE_NAME" app

if command -v kind >/dev/null 2>&1; then
  kind load docker-image "$IMAGE_NAME" --name "$CLUSTER_NAME"
fi

kubectl apply -k kubernetes/overlays/local
kubectl -n simple-app-local rollout status deployment/simple-app
