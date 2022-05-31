# Regions
variable "awsRegion" {
     default = "us-east-1"
}

variable "azRegion" {
     default = "eastus"
}

variable "availabilityZone" {
     default = "us-east-1a"
}

# Instâncias EC2
variable "amiHASH" {
    description = "Hash da ami da instância que será criada"
    default = "ami-0f9fc25dd2506cf6d"
}

variable "projectName" {
    type = string
    description = "Variável do nome do projeto"
    default = "poupay"
}
