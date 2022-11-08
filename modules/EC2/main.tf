resource "aws_instance" "server_project" {
  ami                    = var.AMI
  key_name               = var.INSTANCE_KEY
  instance_type          = var.INSTANCE_TYPE
  subnet_id              = var.SUBNET_ID
  iam_instance_profile   = "EMR_EC2_DefaultRole"
  vpc_security_group_ids = var.SG_LIST
  user_data              = var.USER_DATA
  tags                   = var.EC2_TAGS
}

output "public_ip" {
  description = "ip público do servidor"
  value       = aws_instance.server_project.public_ip
}
