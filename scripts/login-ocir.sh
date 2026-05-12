#!/usr/bin/env bash
set -euo pipefail

REGION="${OCI_REGION:-sa-saopaulo-1}"
TENANCY_NAMESPACE="${OCI_TENANCY_NAMESPACE:?Set OCI_TENANCY_NAMESPACE}"
USERNAME="${OCI_USERNAME:?Set OCI_USERNAME}"
AUTH_TOKEN="${OCI_AUTH_TOKEN:?Set OCI_AUTH_TOKEN}"

echo "$AUTH_TOKEN" | docker login "${REGION}.ocir.io" \
  --username "${TENANCY_NAMESPACE}/${USERNAME}" \
  --password-stdin
