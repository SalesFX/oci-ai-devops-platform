variable "compartment_id" {
  description = "OCID do compartment"
  type        = string
}

variable "env" {
  description = "Ambiente (dev, hml, prod)"
  type        = string
}

variable "target_subnet_id" {
  description = "OCID da subnet alvo do Bastion"
  type        = string
}

variable "allowed_cidrs" {
  description = "CIDRs autorizados a criar sessoes no Bastion"
  type        = list(string)
}

variable "tags" {
  description = "Tags aplicadas a todos os recursos"
  type        = map(string)
  default     = {}
}
