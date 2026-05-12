$ErrorActionPreference = "Stop"

$ClusterName = if ($env:KIND_CLUSTER_NAME) { $env:KIND_CLUSTER_NAME } else { "oci-devops-local" }
$ImageName = if ($env:IMAGE_NAME) { $env:IMAGE_NAME } else { "simple-app:local" }

docker build --build-arg ENV=local --build-arg VERSION=local -t $ImageName app
kind load docker-image $ImageName --name $ClusterName

kubectl apply -k kubernetes/overlays/local
kubectl -n simple-app-local rollout status deployment/simple-app
