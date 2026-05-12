variable "compartment_id" {
  description = "OCID do compartment"
  type        = string
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
