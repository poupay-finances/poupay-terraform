output "server_ip_project" {
  value       = aws_instance.server_project.public_ip
  description = "Ip público do web server"
}