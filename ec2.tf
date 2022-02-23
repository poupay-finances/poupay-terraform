resource "aws_instance" "server" {
    ami = var.amiHASH
    key_name = var.keyName
    instance_type = var.instanceTypeMicro
    subnet_id = aws_subnet.public_subnet_osiris.id

    vpc_security_group_ids = [
        aws_security_group.http-https.id,
        aws_security_group.ssh.id,
        aws_default_security_group.default.id
    ]
    user_data = file("configuracoes/configure.sh")
    tags = {
        Name = "web-server"
    }
}

resource "aws_eip" "server" {
    instance = aws_instance.web_server.id
    vpc = true

    tags = {
        Name = "web-server"
    }
}