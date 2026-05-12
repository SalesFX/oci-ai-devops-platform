$ErrorActionPreference = "Stop"

$ClusterName = if ($env:KIND_CLUSTER_NAME) { $env:KIND_CLUSTER_NAME } else { "oci-devops-local" }
kind delete cluster --name $ClusterName
