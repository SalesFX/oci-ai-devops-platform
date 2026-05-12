$ErrorActionPreference = "Stop"

$ClusterName = if ($env:KIND_CLUSTER_NAME) { $env:KIND_CLUSTER_NAME } else { "oci-devops-local" }

$clusters = kind get clusters
if ($clusters -contains $ClusterName) {
  Write-Host "kind cluster already exists: $ClusterName"
} else {
  kind create cluster --config local/kind-cluster.yaml
}

kubectl cluster-info --context "kind-$ClusterName"
