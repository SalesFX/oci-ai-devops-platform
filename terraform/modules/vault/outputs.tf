output "vault_id" {
  description = "OCID do Vault"
  value       = oci_kms_vault.main.id
}

output "vault_management_endpoint" {
  description = "Endpoint de gerenciamento do Vault"
  value       = oci_kms_vault.main.management_endpoint
}

output "app_key_id" {
  description = "OCID da chave de criptografia da aplicação"
  value       = oci_kms_key.app.id
}
