variable "compartment_id" {
  description = "OCID do compartment onde os recursos serão criados"
  type        = string
}

variable "vcn_cidr" {
  description = "CIDR block da VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "env" {
  description = "Ambiente (dev, hml, prod)"
  type        = string
}

variable "tags" {
  description = "Tags aplicadas a todos os recursos"
  type        = map(string)
  default     = {}
}
