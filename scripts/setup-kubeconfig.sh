#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-dev}"
REGION="${OCI_REGION:-sa-saopaulo-1}"
CLUSTER_ID="${OCI_CLUSTER_ID:-}"

if [[ -z "$CLUSTER_ID" ]]; then
  echo "Set OCI_CLUSTER_ID with the OKE cluster OCID for ${ENVIRONMENT}."
  exit 1
fi

oci ce cluster create-kubeconfig \
  --cluster-id "$CLUSTER_ID" \
  --file "$HOME/.kube/config" \
  --region "$REGION" \
  --token-version 2.0.0 \
  --kube-endpoint PRIVATE_ENDPOINT

kubectl config current-context
