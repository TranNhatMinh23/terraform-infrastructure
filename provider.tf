
provider "aws" {
  region     = "us-east-1"
  
}

terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  
  backend "s3" {
    bucket         = "backend-eos-terraform-1"   
    key            = "terraform.tfstate"            
    region         = "us-east-1"                   
    encrypt        = true                      
    dynamodb_table          = "tabledb"                  
     
  }

}
  


