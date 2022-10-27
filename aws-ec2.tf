data "template_file" "jupyter_script" {
  template = file("configuracao.sh")
  vars = {
    jupyter_pass = var.JUPYTER_PASS
  }
}

module "ec2-jupiter" {
  source = "./modules/EC2"

  AMI = "ami-09d3b3274b6c5d4aa"
  INSTANCE_KEY = var.INSTANCE_KEY
  SUBNET_ID = module.vpc_project.id_subnet
  SG_LIST = [
    module.vpc_project.ssh_sg,
    module.vpc_project.jupyter_sg,
    module.vpc_project.default_sg
  ]

  USER_DATA = data.template_file.jupyter_script.rendered
  
  PROJECT_NAME = var.PROJECT_NAME
  JUPYTER_PASS = var.JUPYTER_PASS
}