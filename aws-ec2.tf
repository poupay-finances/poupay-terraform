resource "aws_instance" "server_project" {
  ami                  = var.amiHASH
  key_name             = "poupay-finances"
  instance_type        = "t3.small"
  subnet_id            = module.vpc_project.id_subnet
  iam_instance_profile = "EMR_EC2_DefaultRole"

  vpc_security_group_ids = [
    module.vpc_project.ssh_sg,
    module.vpc_project.jupyter_sg,
    module.vpc_project.default_sg
  ]

  user_data = data.template_file.jupyter_script.rendered

  tags = {
    Name = format("server-%s", var.projectName)
  }
}

data "template_file" "jupyter_script" {
  template = file("configuracao.sh")
  vars = {
    "jupyter_pass" = "urubu100"
  }
}