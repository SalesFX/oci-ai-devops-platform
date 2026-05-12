locals {
  name_prefix = "oci-devops-${var.env}"
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

# OKE Cluster
resource "oci_containerengine_cluster" "main" {
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version
  name               = "${local.name_prefix}-oke"
  vcn_id             = var.vcn_id
  freeform_tags      = var.tags

  endpoint_config {
    is_public_ip_enabled = false
    subnet_id            = var.workers_subnet_id
  }

  options {
    service_lb_subnet_ids = [var.lb_subnet_id]

    add_ons {
      is_kubernetes_dashboard_enabled = false
      is_tiller_enabled               = false
    }

    admission_controller_options {
      is_pod_security_policy_enabled = false
    }

    kubernetes_network_config {
      pods_cidr     = "10.244.0.0/16"
      services_cidr = "10.96.0.0/16"
    }
  }

  cluster_pod_network_options {
    cni_type = "OCI_VCN_IP_NATIVE"
  }
}

# Node Pool
resource "oci_containerengine_node_pool" "main" {
  cluster_id         = oci_containerengine_cluster.main.id
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version
  name               = "${local.name_prefix}-nodepool"
  freeform_tags      = var.tags

  node_config_details {
    size = var.node_count

    dynamic "placement_configs" {
      for_each = data.oci_identity_availability_domains.ads.availability_domains
      content {
        availability_domain = placement_configs.value.name
        subnet_id           = var.workers_subnet_id
      }
    }

    nsg_ids = [var.workers_nsg_id]

    node_pool_pod_network_option_details {
      cni_type          = "OCI_VCN_IP_NATIVE"
      pod_subnet_ids    = [var.workers_subnet_id]
      max_pods_per_node = 31
    }
  }

  node_shape = var.node_shape

  node_shape_config {
    ocpus         = var.node_ocpus
    memory_in_gbs = var.node_memory_gb
  }

  node_source_details {
    image_id                = data.oci_core_images.oke_node.images[0].id
    source_type             = "IMAGE"
    boot_volume_size_in_gbs = 50
  }

  node_eviction_node_pool_settings {
    eviction_grace_duration              = "PT60M"
    is_force_delete_after_grace_duration = false
  }
}

data "oci_core_images" "oke_node" {
  compartment_id           = var.compartment_id
  operating_system         = "Oracle Linux"
  operating_system_version = "8"
  shape                    = var.node_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"

  filter {
    name   = "display_name"
    values = [".*OKE.*"]
    regex  = true
  }
}
