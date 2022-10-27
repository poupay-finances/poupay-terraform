variable "AVAILABILITY_ZONE" {
  type        = string
  description = "Zona de disponibilidade"
  default     = "us-east-1a"
}

# VPC
variable "VPC_CIDR_BLOCK" {
  type        = string
  description = "CIDR da VPC"
}
variable "VPC_TAGS" {
  type        = map(string)
  description = "Tags da VPC"
  default     = {}
}

# Subnet
variable "MAP_PUBLIC_IP" {
  type        = string
  description = "Associação de IP público nas instâncias criadas nessa Subnet"
  default     = true
}
variable "SUBNET_TAGS" {
  type        = map(string)
  description = "Tags da subnet"
  default     = {}
}

# Internet Gateway
variable "IGW_TAGS" {
  type        = map(string)
  description = "Tags do Internet Gateway"
  default     = {}
}

# Route Table
variable "RTB_TAGS" {
  type        = map(string)
  description = "Tags da Route Table"
  default     = {}
}
