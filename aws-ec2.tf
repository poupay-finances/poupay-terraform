data "template_file" "jupyter_script" {
  template = file("configuracao-jupyter.sh")
  vars = {
    jupyter_pass = var.JUPYTER_PASS
  }
}

module "ec2-jupiter" {
  source = "./modules/EC2"

  AMI          = "ami-09d3b3274b6c5d4aa"
  INSTANCE_KEY = var.INSTANCE_KEY
  SUBNET_ID    = module.vpc_project.id_subnet
  SG_LIST = [
    module.vpc_project.ssh_sg,
    module.vpc_project.jupyter_sg,
    module.vpc_project.default_sg
  ]
  USER_DATA    = data.template_file.jupyter_script.rendered
  PROJECT_NAME = var.PROJECT_NAME
  EC2_TAGS = {
    Name = format("jupyter-%s", var.PROJECT_NAME)
  }
}

data "template_file" "redundancy" {
  template = file("configuracao-redundancia.sh")
  vars = {
    aws_access_key_id     = var.AWS_ACCESS_KEY_ID
    aws_secret_access_key = var.AWS_SECRET_ACCESS_KEY
    aws_session_token     = var.AWS_SESSION_TOKEN
    sa_name               = azurerm_storage_account.sa_project.name
    sa_key                = azurerm_storage_account.sa_project.primary_access_key
    fs_name               = format("%s %s %s", module.bucket_desestruturados.id, module.bucket_semi_estruturados.id, module.bucket_estruturados.id)
  }
}
module "ec2-redundancy" {
  source = "./modules/EC2"

  AMI          = "ami-08c40ec9ead489470"
  INSTANCE_KEY = var.INSTANCE_KEY
  SUBNET_ID    = module.vpc_project.id_subnet
  SG_LIST = [
    module.vpc_project.ssh_sg,
    module.vpc_project.default_sg
  ]
  USER_DATA    = data.template_file.redundancy.rendered
  PROJECT_NAME = var.PROJECT_NAME
  EC2_TAGS = {
    Name = format("redundancy-%s", var.PROJECT_NAME)
  }
}
