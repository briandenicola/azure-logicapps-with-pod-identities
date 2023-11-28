variable "region" {
  description = "The Azure region to use"
  type        = string
  default     = "southcentralus"
}

variable "namespace" {
  description = "The AKS namespace to use"
  type        = string
  default     = "logicapp-eventprocessor"
}

variable "vm_size" {
  description = "The SKU for the default node pool"
  default     = "Standard_B4ms"
}

variable "node_count" {
  description = "The default number of nodes to scale the cluster to"
  default     = 2
}
