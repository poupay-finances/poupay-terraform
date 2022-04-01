variable "region" {
     default = "us-east-1"
}
variable "availabilityZone" {
     default = "us-east-1a"
}

# VPC
variable "instanceTenancy" {
    default = "default"
}
variable "dnsSupport" {
    default = true
}
variable "dnsHostNames" {
    default = true
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/23"
}
variable "mapPublicIP" {
    default = true
}

# Subnets
variable "publicsCIDRblock" {
    default = "10.0.0.0/24"
}
variable "privatesCIDRblock" {
    default = "10.0.1.0/24"
}

# Rota para o Internet Gateway
variable "publicdestCIDRblock" {
    default = "0.0.0.0/0"
}
variable "localdestCIDRblock" {
    default = "10.0.0.0/23"
}

# Security Group
variable "sgCidrBlocks" {
    default = ["0.0.0.0/0"]
}

variable "sgIPV6CidrBlocks" {
    default = ["::/0"]
}

# Instâncias EC2
variable "amiHASH" {
    default = "ami-083654bd07b5da81d"
}

variable "instanceTypeMicro" {
    default = "t2.micro"
}

variable "instanceTypeSmall" {
    default = "t2.small"
}

#Variável do nome principal do projeto
variable "projectName" {
    default = "poupay-finances"
}
