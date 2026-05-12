resource "oci_artifacts_container_repository" "app" {
  compartment_id = var.compartment_id
  display_name   = "oci-devops-${var.env}/simple-app"
  is_public      = false
  freeform_tags  = var.tags
}
