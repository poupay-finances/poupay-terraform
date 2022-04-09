# VPC
resource "aws_vpc" "vpc_project" {
    cidr_block           = var.vpcCIDRblock
    instance_tenancy     = var.instanceTenancy 
    enable_dns_support   = var.dnsSupport 
    enable_dns_hostnames = var.dnsHostNames

    tags = {
        Name = format("vpc-%s", var.projectName)
    }
} 

# Subnet
resource "aws_subnet" "public_subnet_project" {
    vpc_id                  = aws_vpc.vpc_project.id
    cidr_block              = var.publicsCIDRblock
    map_public_ip_on_launch = var.mapPublicIP 
    availability_zone       = var.availabilityZone

    tags = {
        Name = format("public-subnet-%s", var.projectName)
    }
}

# Internet Gateway
resource "aws_internet_gateway" "igw_project" {
    vpc_id = aws_vpc.vpc_project.id
    tags = {
        Name = format("internet-gateway-%s", var.projectName)
    }
}

# Route Table
resource "aws_route_table" "rtb_project" {
    vpc_id = aws_vpc.vpc_project.id
    tags = {
        Name = format("route-table-%s", var.projectName)
    }
}

# Rota para o Internet Gateway
resource "aws_route_table_association" "internet_access" {
  gateway_id      = aws_internet_gateway.igw_project.id
  route_table_id = aws_route_table.rtb_project.id
}
# resource "aws_route" "internet_access" {
#     route_table_id         = aws_route_table.rtb_project.id
#     destination_cidr_block = var.publicdestCIDRblock
#     gateway_id             = aws_internet_gateway.igw_project.id
# }

# Associação da Route Table à subnet pública
resource "aws_route_table_association" "public_association" {
    subnet_id      = aws_subnet.public_subnet_project.id
    route_table_id = aws_route_table.rtb_project.id
}

# Security Group
resource "aws_security_group" "ssh" {
    name = "ssh"
    description = "SSH"

    vpc_id = aws_vpc.vpc_project.id

    ingress = [
        {
            description = "ssh"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = var.sgCidrBlocks
            ipv6_cidr_blocks = var.sgIPV6CidrBlocks
            prefix_list_ids = []
            security_groups = []
            self = false 
        }
    ]

    tags = {
        Name = "ssh"
    }
}

resource "aws_security_group" "http-https" {
    name = "http-https"
    description = "aplicacao"

    vpc_id = aws_vpc.vpc_project.id

    ingress = [
        {
            description = "http"
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = var.sgCidrBlocks
            ipv6_cidr_blocks = var.sgIPV6CidrBlocks
            prefix_list_ids = []
            security_groups = []
            self = false 
        },
        {
            description = "https"
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = var.sgCidrBlocks
            ipv6_cidr_blocks = var.sgIPV6CidrBlocks
            prefix_list_ids = []
            security_groups = []
            self = false 
        }
    ]
    
    tags = {
        Name = "http-https"
    }
}

resource "aws_security_group" "rdp" {
    name = "rdp"
    description = "RDP"

    vpc_id = aws_vpc.vpc_project.id

    ingress = [
        {
            description = "rdp"
            from_port = 3389
            to_port = 3389
            protocol = "tcp"
            cidr_blocks = var.sgCidrBlocks
            ipv6_cidr_blocks = var.sgIPV6CidrBlocks
            prefix_list_ids = []
            security_groups = []
            self = false 
        }
    ]
    
    tags = {
        Name = "rdp"
    }
}

resource "aws_security_group" "database" {
    name = "database"
    description = "banco"

    vpc_id = aws_vpc.vpc_project.id

    ingress = [
        {
            description = "banco"
            from_port = 3306
            to_port = 3306
            protocol = "tcp"
            cidr_blocks = var.sgCidrBlocks
            ipv6_cidr_blocks = var.sgIPV6CidrBlocks
            prefix_list_ids = []
            security_groups = []
            self = false 
        }
    ]

    tags = {
        Name = "database"
    }
}

resource "aws_default_security_group" "default" {
    # name = "default"
    # description = "default"

    vpc_id = aws_vpc.vpc_project.id

    ingress = [
        {
            description = "default"
            from_port = 0
            to_port   = 0
            protocol  = "-1"
            cidr_blocks = var.sgCidrBlocks
            ipv6_cidr_blocks = var.sgIPV6CidrBlocks
            prefix_list_ids = []
            security_groups = []
            self = true
        }
    ]

    egress = [
        {
            description = "default"
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = var.sgCidrBlocks
            ipv6_cidr_blocks = var.sgIPV6CidrBlocks
            prefix_list_ids = []
            security_groups = []
            self = false 
        }
    ]

    tags = {
        Name = "default"
    }
}
