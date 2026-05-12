terraform {
  required_version = ">= 1.5"
  required_providers {
    oci = { source = "oracle/oci", version = "~> 5.0" }
  }
  backend "s3" {
    bucket                      = "oci-devops-tfstate"
    key                         = "hml/terraform.tfstate"
    region                      = "sa-saopaulo-1"
    endpoint                    = "https://<namespace>.compat.objectstorage.sa-saopaulo-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}

provider "oci" { region = var.region }

locals {
  env  = "hml"
  tags = { env = "hml", project = "oci-devops-platform", managed_by = "terraform" }
}

module "network" {
  source         = "../../modules/network"
  compartment_id = var.compartment_id
  env            = local.env
  vcn_cidr       = "10.1.0.0/16"
  tags           = local.tags
}

module "oke" {
  source            = "../../modules/oke"
  compartment_id    = var.compartment_id
  env               = local.env
  vcn_id            = module.network.vcn_id
  lb_subnet_id      = module.network.lb_subnet_id
  workers_subnet_id = module.network.private_subnet_id
  workers_nsg_id    = module.network.workers_nsg_id
  node_count        = 2
  node_ocpus        = 2
  node_memory_gb    = 16
  tags              = local.tags
}

module "ocir" {
  source         = "../../modules/ocir"
  compartment_id = var.compartment_id
  env            = local.env
  tags           = local.tags
}

module "vault" {
  source         = "../../modules/vault"
  compartment_id = var.compartment_id
  env            = local.env
  tags           = local.tags
}

module "bastion" {
  source           = "../../modules/bastion"
  compartment_id   = var.compartment_id
  env              = local.env
  target_subnet_id = module.network.private_subnet_id
  allowed_cidrs    = var.bastion_allowed_cidrs
  tags             = local.tags
}

module "observability" {
  source             = "../../modules/observability"
  compartment_id     = var.compartment_id
  env                = local.env
  notification_email = var.notification_email
  tags               = local.tags
}
