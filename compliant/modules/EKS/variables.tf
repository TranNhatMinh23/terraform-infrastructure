
#
# NETWORK variables
#
variable "vpc_name" {
  type    = string
  default = "default"
}


variable "subnet_ids" {
  type = any
}

variable "sg_ids" {
  type = any
}
variable "subnet_name" {
  type = any
}


variable "sg_name" {
  type = any
 
}

variable "eks_name" {
  type = string
}
variable "versions" {
  type = string
}
variable "node_group_name" {
  type = string
}



variable "capacity_type" {
  type = string
}
variable "disk_size" {
  type = string
}
variable "instance_types" {
  type = list(string)
}

variable "ec2_ssh_key" {
  type = string
}
variable "desired_size" {
  type = number
}
variable "max_size" {
  type = number
}
variable "min_size" {
  type = number
}
variable "eksmaster_role" {
  type = string
}
variable "eksworker_role" {
  type = string
}
variable "autoscaler_role" {
  type = string
}