output "vcn_id" {
  description = "OCID da VCN"
  value       = oci_core_vcn.main.id
}

output "public_subnet_id" {
  description = "OCID da subnet pública"
  value       = oci_core_subnet.public.id
}

output "private_subnet_id" {
  description = "OCID da subnet privada"
  value       = oci_core_subnet.private.id
}

output "lb_subnet_id" {
  description = "OCID da subnet do Load Balancer"
  value       = oci_core_subnet.lb.id
}

output "workers_nsg_id" {
  description = "OCID do NSG dos workers OKE"
  value       = oci_core_network_security_group.workers.id
}

output "lb_nsg_id" {
  description = "OCID do NSG do Load Balancer"
  value       = oci_core_network_security_group.lb.id
}
