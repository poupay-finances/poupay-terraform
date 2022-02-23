output "web_server_ip" {
    value = aws_instance.web_server.public_ip
    description = "Ip público do web server"

    depends_on = [
        aws_eip.web_server
    ]
}