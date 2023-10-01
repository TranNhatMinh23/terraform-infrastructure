resources = {
  
  vnet = {
    vpc1 = {
      vpc_name = "vpc1"
      vpc_cidr_block   = "10.16.0.0/16"
      public_rt_name  = "pubblic1_rt"
      private_rt_name  = "private1_rt"
      igw_name        = "igw1"
      create_nat_gateway = true
      subnets_map = {
        public_subnet_1 = {
          type              = "public"
          cidr_block        = "10.16.0.0/20"
          availability_zone = "us-east-1a"
        }
        public_subnet_2 = {
          type              = "public"
          cidr_block        = "10.16.16.0/20"
          availability_zone = "us-east-1b"
        }
        private_subnet_1 = {
          type              = "private"
          cidr_block        = "10.16.32.0/20"
          availability_zone = "us-east-1a"
        }
        
      }
    }
    
  }
  nsg = {
    "sg1" = {
      vpc_name = "vpc1"
      sg_name  = "sg1"
      ingress_rules = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "HTTP from Internet"
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "HTTP from Internet"
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "HTTP from Internet"
        },
        
      ]
      egress_rules = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
          description = "egress"
        }
      ]
    }
  }
  
  
  vm = {
    ami_instance = {
      ami_name = "ec2_ami"
      ami_id             = "ami-053b0d53c279acc90"
      instance_name      = "instance-final"
      type               = "t3.large"
      key_pair_name      = "MINHTN36"
      user_data_path     = "user-data.sh"
      vpc_name           = "vpc1"
      subnet_name        = "public_subnet_1"
      sg_name            = "sg1"
      ami_creation_count = 1
    }
  }
  eks = {
    eks_project = {
      eks_name = "devops"
      versions = "1.25"
      node_group_name = "prod"
      capacity_type = "ON_DEMAND"
      disk_size = "30"
      instance_types = ["t3.2xlarge"]
      ec2_ssh_key = "devops"
      desired_size = 2
      max_size     = 3
      min_size     = 2
      eksmaster_role    = "eksmaster_iam_role3"
      eksworker_role    = "eksworker_iam_role3"
      autoscaler_role   = "autoscaler_role"
      vpc_name           = "vpc1"
      subnet_name        = ["public_subnet_1","public_subnet_2"]
      sg_name            = "sg1"
    }
  }
  
  s3 = {
    react_web = {
      bucket_name = "s3-logsfsoft5"
      public_access_blocks = {
        blocks = {
          block_public_acls       = false
          block_public_policy     = false
          ignore_public_acls      = false
          restrict_public_buckets = false
        }
      }
      policy = {
        Id = "s3-logsfsoft"
        Statement = [
          {
            Action = ["s3:*"]
            Effect = "Allow"
            Principal = {
              AWS = "*"
            }

            Resource = [
              "arn:aws:s3:::s3-logsfsoft",
              "arn:aws:s3:::s3-logsfsoft/*"
            ]
            Sid = "Enable IAM User Permissions"
          },
        ]
        Version = "2012-10-17"
      }
    }
  }
}

