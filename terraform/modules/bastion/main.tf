resource "oci_bastion_bastion" "main" {
  bastion_type                 = "STANDARD"
  compartment_id               = var.compartment_id
  target_subnet_id             = var.target_subnet_id
  name                         = "ocidevops${var.env}bastion"
  client_cidr_block_allow_list = var.allowed_cidrs
  max_session_ttl_in_seconds   = 10800
  freeform_tags                = var.tags
}
