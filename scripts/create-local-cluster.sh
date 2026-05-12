#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${KIND_CLUSTER_NAME:-oci-devops-local}"

if kind get clusters | grep -qx "$CLUSTER_NAME"; then
  echo "kind cluster already exists: $CLUSTER_NAME"
else
  kind create cluster --config local/kind-cluster.yaml
fi

kubectl cluster-info --context "kind-${CLUSTER_NAME}"
