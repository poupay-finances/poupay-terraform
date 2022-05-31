variable "availabilityZone" {
  type        = string
  description = "Zona de disponibilidade"
  default     = "us-east-1a"
}

# VPC
variable "vpcCIDRblock" {
  type        = string
  description = "CIDR da VPC"
}
variable "vpcTags" {
  type        = map(string)
  description = "Tags da VPC"
  default     = {}
}

# Subnet
variable "mapPublicIP" {
  type        = string
  description = "Associação de IP público nas instâncias criadas nessa Subnet"
  default     = true
}
variable "subnetTags" {
  type        = map(string)
  description = "Tags da subnet"
  default     = {}
}

# Internet Gateway
variable "igwTags" {
  type        = map(string)
  description = "Tags do Internet Gateway"
  default     = {}
}

# Route Table
variable "rtbTags" {
  type        = map(string)
  description = "Tags da Route Table"
  default     = {}
}
