resource "aws_instance" "server_project" {
    ami = var.amiHASH
    key_name = var.projectName
    instance_type = var.instanceTypeMicro
    subnet_id = aws_subnet.public_subnet_project.id
    # associate_public_ip_address = true
 
    vpc_security_group_ids = [
        aws_security_group.ssh.id,
        aws_security_group.database.id,
        aws_default_security_group.default.id
    ]

    user_data = file("configuracao.sh")

    tags = {
        Name = format("server-%s", var.projectName)
    }
}

resource "aws_eip" "server_eip_project" {
    instance = aws_instance.server_project.id
    vpc = true

    tags = {
        Name = format("server-eip-%s", var.projectName)
    }
}
