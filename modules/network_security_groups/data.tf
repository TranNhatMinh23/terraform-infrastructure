locals {
  vpc_id = try(var.vpc_name != "default" ? var.network_configs[var.vpc_name].vpc_id : var.default_subnet.vpc_id, var.default_subnet.vpc_id)
}