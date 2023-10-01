locals {
  eks_configs           = try(var.resources.eks, {})
  vnet_configs         = try(var.resources.vnet, {})
  nsg_configs          = try(var.resources.nsg, {})
  vm_configs           = try(var.resources.vm, {})
  default_subnet   = aws_default_subnet.this
  network_configs_outputs = try(module.network, null)
  s3_configurations  = try(var.resources.s3, {})
}
resource "aws_default_subnet" "this" {
  availability_zone = "us-east-1a"

}
