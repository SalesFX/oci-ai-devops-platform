#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-dev}"

case "$ENVIRONMENT" in
  dev|hml|prod) ;;
  *)
    echo "Use: $0 dev|hml|prod"
    exit 1
    ;;
esac

cd "terraform/environments/${ENVIRONMENT}"
terraform destroy
