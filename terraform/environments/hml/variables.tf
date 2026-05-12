variable "compartment_id" {
  type = string
}

variable "region" {
  type    = string
  default = "sa-saopaulo-1"
}

variable "notification_email" {
  type = string
}

variable "bastion_allowed_cidrs" {
  type = list(string)
}
