resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.private_rt_name
  }
}

resource "aws_route" "private_rt_routes" {
  for_each               = var.private_rt_cidr
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = each.value.cidr_block
  gateway_id             = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "private_subnet_asso" {
  depends_on = [
    aws_subnet.private_subnets
  ]

  for_each = aws_subnet.private_subnets

  subnet_id = each.value.id

  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.public_rt_name
  }
}

resource "aws_route" "public_rt_routes" {
  for_each               = var.public_rt_cidr
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = each.value.cidr_block
  gateway_id             = aws_internet_gateway.this.id
}


resource "aws_route_table_association" "public_subnet_asso" {
  depends_on = [
    aws_subnet.public_subnets
  ]

  for_each = aws_subnet.public_subnets

  subnet_id = each.value.id

  route_table_id = aws_route_table.public_rt.id
}
