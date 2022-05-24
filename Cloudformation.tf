resource "aws_cloudformation_stack" "project-cloudformation" {
  name = format("server-%s", var.projectName)

  parameters = {
    "VpcCidr" = "${var.vpcCIDRblock}",
    "VpcPublicSubnetCidr" = "${var.subnetsCIDRblock}",
    "VpcPublicSubnetZone" = "${var.availabilityZone}"
    "Ec2KeyPairName" = "${var.projectName}"
    "Ec2JupyterPassword" = "${jupyterPassword}"
  }

  template_body = file("cloudformation/poupay-cloudformation.yaml")
  on_failure = "ROLLBACK"

  tags = {
    Name = format("server-%s", var.projectName)
  }
}