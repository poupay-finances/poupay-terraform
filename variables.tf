# Regions
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AZ_REGION" {
  default = "eastus"
}

variable "AVAILABILITY_ZONE" {
  default = "us-east-1a"
}

# Instâncias EC2

variable "AMI_HASH" {
  type = string
  description = "Hash da ami (opcional)"
  default = null
}
variable "INSTANCE_KEY" {
  type        = string
  description = "Chave a ser utilizada nas instâncias"
  default     = "poupay-finances"
}

variable "PROJECT_NAME" {
  type        = string
  description = "Variável do nome do projeto"
  default     = "poupaykaio"
}

variable "AUTOR" {
  type        = string
  description = "Autor"
  default = "kaio"
}

variable "JUPYTER_PASS" {
  type        = string
  sensitive   = true
  description = "Variável da senha do jupyter"
  default = "urubu100"
}

variable "AZURE_SERVER_DATABASE_USER" {
  type        = string
  sensitive   = true
  description = "Variável do usuario do servidor do banco de dados na azure"
  default = "kaio"
}

variable "AZURE_SERVER_DATABASE_PASSWORD" {
  type        = string
  sensitive   = true
  description = "Variável da senha do servidor do banco de dados na azure"
  default = "urubu100"
}
