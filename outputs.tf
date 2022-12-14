output "server_ip_project" {
  value       = module.ec2-jupiter.public_ip
  description = "Ip público do web server"
}

output "invoke_url_api" {
  value = aws_api_gateway_deployment.deployment.invoke_url
}