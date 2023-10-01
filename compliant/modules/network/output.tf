output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnets_map" {
  value = merge(aws_subnet.public_subnets, aws_subnet.private_subnets)
}

output "public_subnets_map" {
  value = aws_subnet.public_subnets
}

output "private_subnets_map" {
  value = aws_subnet.private_subnets
}
