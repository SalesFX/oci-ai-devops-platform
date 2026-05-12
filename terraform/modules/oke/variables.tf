variable "compartment_id" {
  description = "OCID do compartment"
  type        = string
}

variable "env" {
  description = "Ambiente (dev, hml, prod)"
  type        = string
}

variable "vcn_id" {
  description = "OCID da VCN"
  type        = string
}

variable "lb_subnet_id" {
  description = "OCID da subnet do Load Balancer"
  type        = string
}

variable "workers_subnet_id" {
  description = "OCID da subnet privada dos workers"
  type        = string
}

variable "workers_nsg_id" {
  description = "OCID do NSG dos workers"
  type        = string
}

variable "kubernetes_version" {
  description = "Versão do Kubernetes"
  type        = string
  default     = "v1.30.1"
}

variable "node_shape" {
  description = "Shape das VMs dos nodes"
  type        = string
  default     = "VM.Standard.E4.Flex"
}

variable "node_ocpus" {
  description = "OCPUs por node"
  type        = number
  default     = 2
}

variable "node_memory_gb" {
  description = "Memória em GB por node"
  type        = number
  default     = 16
}

variable "node_count" {
  description = "Número inicial de nodes"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags aplicadas a todos os recursos"
  type        = map(string)
  default     = {}
}
