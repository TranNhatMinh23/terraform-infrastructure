module "network" {
  source = "./modules/network"

  for_each      = local.vnet_configs
  public_sn_nat_gw = try(each.value.public_sn_nat_gw, {})
  vpc_cidr_block   = each.value.vpc_cidr_block
  create_nat_gateway = each.value.create_nat_gateway
  subnets_map      = each.value.subnets_map
  vpc_name        = each.value.vpc_name
  public_rt_name = each.value.public_rt_name
  private_rt_name = each.value.private_rt_name
  igw_name = try(each.value.igw_name, {})
  ngw_name = try(each.value.ngw_name, {})

}
module "sg" {
  source = "./modules/network_security_groups"

  for_each         = local.nsg_configs
  vpc_name      = try(each.value.vpc_name, "default")
  sg_name       = try(each.value.sg_name, "default")
  ingress_rules = each.value.ingress_rules
  egress_rules  = each.value.egress_rules
  network_configs = local.network_configs_outputs
  default_subnet  = local.default_subnet
  
}


module "vm" {
  source = "./modules/virtual_machines"

  for_each   = local.vm_configs
  ami_id             = each.value.ami_id
  ami_name = each.value.ami_name
  instance_name      = each.value.instance_name
  type               = each.value.type
  key_pair_name      = each.value.key_pair_name
  user_data_path     = try(each.value.user_data_path, "default.tpl")
  instance_count     = try(each.value.instance_count, 1)
  ami_creation_count = try(each.value.ami_creation_count, 0)
  ebs_mounting_count = try(each.value.ebs_mounting_count, 0)
  vpc_name           = try(each.value.vpc_name, "default")
  sg_name            = try(each.value.sg_name, "default")
  subnet_name        = try(each.value.subnet_name, "default")
  subnet_ids = module.network[each.value.vpc_name]["subnets_map"][each.value.subnet_name].id
    # Thêm các subnet khác nếu cần
  

  // Để sửa lỗi về Security Group, bạn cần thêm logic để lấy danh sách Security Group IDs
  sg_ids = [
    module.sg[each.value.sg_name].sg_data.id
    # Thêm các Security Group khác nếu cần
  ]
}

module "eks" {
  source = "./modules/EKS"
  for_each      = local.eks_configs
  eks_name = each.value.eks_name
  versions = each.value.versions
  node_group_name = each.value.node_group_name
  capacity_type = each.value.capacity_type
  disk_size = each.value.disk_size
  instance_types = each.value.instance_types
  ec2_ssh_key = each.value.ec2_ssh_key
  desired_size = each.value.desired_size
  max_size = each.value.max_size
  min_size = each.value.min_size
  eksmaster_role = each.value.eksmaster_role
  eksworker_role = each.value.eksworker_role
  autoscaler_role = each.value.autoscaler_role
  vpc_name           = try(each.value.vpc_name, "default")
  sg_name            = each.value.sg_name
  subnet_name        = each.value.subnet_name
  subnet_ids = [
    module.network[each.value.vpc_name]["subnets_map"][each.value.subnet_name[0]].id,
    module.network[each.value.vpc_name]["subnets_map"][each.value.subnet_name[1]].id
    # Thêm các subnet khác nếu cần
  ]

  // Để sửa lỗi về Security Group, bạn cần thêm logic để lấy danh sách Security Group IDs
  sg_ids = [
    module.sg[each.value.sg_name].sg_data.id
    # Thêm các Security Group khác nếu cần
  ]
}

#########################
# S3 MODULE
#########################
module "s3" {
  source = "./modules/s3"

  for_each             = local.s3_configurations
  bucket_name          = each.value.bucket_name
  policy               = each.value.policy
  public_access_blocks = each.value.public_access_blocks

}