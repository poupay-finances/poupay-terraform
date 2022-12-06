variable "INSTANCE_KEY" {
  type        = string
  description = "Chave a ser utilizada na(s) instância(s)"
}

variable "AMI" {
  type        = string
  description = "Id da ami da imagem a ser utilizada"
}

variable "INSTANCE_TYPE" {
  type        = string
  description = "Tipo da instância"
  default     = "t2.micro"
}

variable "SUBNET_ID" {
  type        = string
  description = "Id da subnet da instância"
}

variable "SG_LIST" {
  type        = list(string)
  description = "Id da subnet da instância"
  default     = null
}

variable "PROJECT_NAME" {
  type        = string
  description = "Nome do projeto"
}

variable "USER_DATA" {
  type        = string
  description = "Os dados do usuário a serem fornecidos ao iniciar a instância"
  default     = null
}

variable "EC2_TAGS" {
  type        = map(string)
  description = "Tags da EC2"
  default     = null
}