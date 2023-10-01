resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_eip" "nat" {
  
}

resource "aws_nat_gateway" "this" {
  depends_on = [aws_internet_gateway.this]
  subnet_id     = var.create_nat_gateway ? aws_subnet.public_subnets["public_subnet_1"].id : null
  allocation_id = var.create_nat_gateway ? aws_eip.nat.id : null

  
}
