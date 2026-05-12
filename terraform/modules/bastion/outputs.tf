output "bastion_id" {
  description = "OCID do Bastion"
  value       = oci_bastion_bastion.main.id
}

output "bastion_endpoint" {
  description = "Endpoint do Bastion"
  value       = oci_bastion_bastion.main.private_endpoint_ip_address
}
