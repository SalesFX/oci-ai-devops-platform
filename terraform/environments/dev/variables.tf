variable "compartment_id" {
  description = "OCID do compartment OCI"
  type        = string
}

variable "region" {
  description = "Região OCI"
  type        = string
  default     = "sa-saopaulo-1"
}

variable "notification_email" {
  description = "Email para alertas"
  type        = string
}

variable "bastion_allowed_cidrs" {
  description = "CIDRs autorizados a usar o Bastion"
  type        = list(string)
}
