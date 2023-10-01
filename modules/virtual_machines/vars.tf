#
# EC2 instance variables
#
variable "ami_id" {
  type = string
}
variable "subnet_ids" {
  type = any
}

variable "sg_ids" {
  type = any
}
variable "instance_name" {
  type = string
}
variable "ami_name" {
  type = string
}
variable "type" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "key_pair_name" {
  type = string
}

variable "user_data_path" {
  type    = string
  default = "default.tpl"
}

variable "ami_creation_count" {
  type    = number
  default = 0
}

variable "ebs_mounting_count" {
  type    = number
  default = 0
}

#
# NETWORK variables
#
variable "vpc_name" {
  type    = string
  default = "default"
}

variable "subnet_name" {
  type = string
}




#
# SG variables
#


variable "sg_name" {
  type = string
}

#
# EBS variables
#
variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "ebs_size" {
  type    = number
  default = 1
}

variable "ebs_device_name" {
  type    = string
  default = "/dev/sdg"
}
