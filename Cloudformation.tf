resource "aws_cloudformation_stack" "project-cloudformation" {
  name = format("stack-%s", var.projectName)

  parameters = {
    "VpcCidr"             = "${var.vpcCIDRblock}",
    "VpcPublicSubnetCidr" = "${var.subnetsCIDRblock}",
    "VpcPublicSubnetZone" = "${var.availabilityZone}"
    "Ec2KeyPairName"      = "${var.projectName}"
    "Ec2JupyterPassword"  = "urubu100"
  }

  template_body = file("cloudformation/poupay-cloudformation.yaml")
  on_failure    = "ROLLBACK"

  tags = {
    Name = format("stack-%s", var.projectName)
  }
}