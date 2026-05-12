resource "oci_kms_vault" "main" {
  compartment_id = var.compartment_id
  display_name   = "oci-devops-${var.env}-vault"
  vault_type     = "DEFAULT"
  freeform_tags  = var.tags
}

resource "oci_kms_key" "app" {
  compartment_id      = var.compartment_id
  display_name        = "oci-devops-${var.env}-app-key"
  management_endpoint = oci_kms_vault.main.management_endpoint
  freeform_tags       = var.tags

  key_shape {
    algorithm = "AES"
    length    = 32
  }
}
