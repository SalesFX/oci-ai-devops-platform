output "repository_id" {
  description = "OCID do repositório OCIR"
  value       = oci_artifacts_container_repository.app.id
}

output "repository_name" {
  description = "Nome do repositório"
  value       = oci_artifacts_container_repository.app.display_name
}
