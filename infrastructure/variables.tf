variable "region" {
  description   = "The Azure region to use"
  type          = string
  default       = "southcentralus"
}

variable "namespace" {
  description   = "The AKS namespace to use"
  type          = string
  default       = "logicapp-eventprocessor" 
}