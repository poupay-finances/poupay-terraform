output "ssh_sg" {
  description = "ID do Security Group de SSH"
  value       = aws_security_group.sg_ssh.id
}
output "jupyter_sg" {
  description = "ID do Security Group de SSH"
  value       = aws_security_group.sg_jupyter.id
}
output "default_sg" {
  description = "ID do Security Group de SSH"
  value       = data.aws_security_group.default.id
}
output "id_subnet" {
  description = "ID da Subnet"
  value       = aws_subnet.subnet_project.id
}