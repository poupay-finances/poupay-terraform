# VPC
resource "aws_vpc" "vpc_project" {
  cidr_block           = var.vpcCIDRblock
  enable_dns_hostnames = true
  tags                 = var.vpcTags
}

# Subnet
resource "aws_subnet" "subnet_project" {
  vpc_id                  = aws_vpc.vpc_project.id
  cidr_block              = "172.16.5.0/26"
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone
  tags                    = var.subnetTags
}

# Internet Gateway
resource "aws_internet_gateway" "igw_project" {
  vpc_id = aws_vpc.vpc_project.id
  tags   = var.igwTags
}

# Route Table
resource "aws_route_table" "rtb_project" {
  vpc_id = aws_vpc.vpc_project.id
  tags   = var.rtbTags
}

# Rota para o Internet Gateway
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.rtb_project.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_project.id
}

# Associação da Route Table à subnet pública
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.subnet_project.id
  route_table_id = aws_route_table.rtb_project.id
}

# Security Group
resource "aws_security_group" "sg_ssh" {
  name        = "ssh"
  description = "SSH"

  vpc_id = aws_vpc.vpc_project.id

  ingress = [
    {
      description      = "ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "ssh"
  }
}

resource "aws_security_group" "sg_jupyter" {
  name        = "jupyter"
  description = "jupyter"

  vpc_id = aws_vpc.vpc_project.id

  ingress = [
    {
      description      = "jupyter-http"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "jupyter"
  }
}

data "aws_security_group" "default" {
  vpc_id = aws_vpc.vpc_project.id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}
