output "cluster_id" {
  description = "OCID do cluster OKE"
  value       = oci_containerengine_cluster.main.id
}

output "cluster_name" {
  description = "Nome do cluster OKE"
  value       = oci_containerengine_cluster.main.name
}

output "node_pool_id" {
  description = "OCID do node pool"
  value       = oci_containerengine_node_pool.main.id
}

output "kubernetes_version" {
  description = "Versão do Kubernetes instalada"
  value       = oci_containerengine_cluster.main.kubernetes_version
}
