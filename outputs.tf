output "server_ip_project" {
  value       = module.ec2-jupiter.public_ip
  description = "Ip público do web server"
}