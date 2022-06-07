module "vpc_project" {
  source = "./modules/VPC"

  vpcCIDRblock = "172.16.5.0/24"
}