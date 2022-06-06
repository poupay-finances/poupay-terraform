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
  default     = "ami-0f9fc25dd2506cf6d"
}

variable "instanceKey" {
  type        = string
  description = "Chave a ser utilizada nas instâncias"
  default     = "poupay-finances"
}

variable "projectName" {
  type        = string
  description = "Variável do nome do projeto"
  default     = "poupay"
}

variable "AUTOR" {
  type        = string
  description = "Autor"
}

variable "JUPYTER_PASS" {
  type        = string
  sensitive   = true
  description = "Variável da senha do jupyter"
}

variable "AZURE_SERVER_DATABASE_USER" {
  type        = string
  sensitive   = true
  description = "Variável do usuario do servidor do banco de dados na azure"
}

variable "AZURE_SERVER_DATABASE_PASSWORD" {
  type        = string
  sensitive   = true
  description = "Variável da senha do servidor do banco de dados na azure"
}
