output "cluster_id" {
  value = module.oke.cluster_id
}

output "cluster_name" {
  value = module.oke.cluster_name
}

output "ocir_repository" {
  value = module.ocir.repository_name
}

output "vault_id" {
  value = module.vault.vault_id
}

output "bastion_id" {
  value = module.bastion.bastion_id
}
