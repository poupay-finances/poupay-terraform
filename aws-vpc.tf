module "vpc_project" {
  source = "./modules/VPC"

  VPC_CIDR_BLOCK = "172.16.5.0/24"
  VPC_TAGS = {
    Name = format("vpc-%s", var.PROJECT_NAME)
  }
}
