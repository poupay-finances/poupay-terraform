variable "region" {
  default = "us-east-1"
}
variable "availabilityZone" {
  default = "us-east-1a"
}

# VPC
variable "vpcCIDRblock" {
  default = "172.16.5.0/24"
}

# Subnets
variable "subnetsCIDRblock" {
  default = "172.16.5.0/26"
}

#Variável do nome principal do projeto
variable "projectName" {
  default = "poupay-finances-kaio"
}
