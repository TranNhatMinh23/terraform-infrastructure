variable "vpc_cidr_block" {
  type    = string
  default = "10.16.0.0/16"
}

variable "public_rt_cidr" {
  type = map(any)
  default = {
    internet = {
      cidr_block = "0.0.0.0/0"
    }
  }
}

variable "private_rt_cidr" {
  type = map(any)
  default = {
    internet = {
      cidr_block = "0.0.0.0/0"
    }
  }
}

variable "subnets_map" {
  type        = map(any)
  description = "Map of subnets"
}

variable "public_sn_nat_gw" {
  type = any
}
variable "vpc_name" {
  type = string
}
variable "public_rt_name" {
  type = string
}
variable "private_rt_name" {
  type = string
}
variable "igw_name" {
  type = string
}
variable "ngw_name" {
  type = any
}
variable "create_nat_gateway" {
  type = bool
}
