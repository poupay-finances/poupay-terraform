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
    default = "172.16.5.0/24"
}
variable "mapPublicIP" {
    default = true
}

# Subnets
variable "subnetsCIDRblock" {
    default = "172.16.5.0/26"
}

# Rota para o Internet Gateway
variable "publicdestCIDRblock" {
    default = "0.0.0.0/0"
}
variable "localdestCIDRblock" {
    default = "172.16.5.0/24"
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
    default = "ami-04505e74c0741db8d"
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
