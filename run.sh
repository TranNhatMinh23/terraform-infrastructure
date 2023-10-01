#!/bin/bash

read -p 'Open lab_vars dir to view list of lab names.
Enter lab name (not include file extension) to apply: ' lab_var

lab_path="lab_vars/${lab_var}.tfvars"

if [ ! -f $lab_path ]; then
  echo "Invalid lab name!"
  exit 0
fi

if [ ! -d terraform.tfvars ]; then 
  touch terraform.tfvars
fi

cat $lab_path > terraform.tfvars

terraform init -upgrade
terraform apply