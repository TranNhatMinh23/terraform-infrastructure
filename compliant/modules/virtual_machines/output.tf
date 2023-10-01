output "ec2_instance" {
  value = aws_instance.this[*].id
}

output "ec2_instance_arn" {
  value = aws_instance.this[*].arn
}

output "ami_ids" {
  value = aws_ami_from_instance.this[*].id
}
