resource "aws_instance" "this" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.type
  key_name               = var.key_pair_name
  user_data              = file("user_data/${var.user_data_path}")
  vpc_security_group_ids = var.sg_ids
  subnet_id = var.subnet_ids

  tags = {
    Name = var.instance_name
  }
}




resource "aws_eip" "this" {
  count   = var.instance_count
  instance = aws_instance.this[count.index].id
}


resource "aws_ami_from_instance" "this" {
  count              = var.ami_creation_count
  name               = var.ami_name
  source_instance_id = element(aws_instance.this[*].id, count.index)

  tags = {
    Name = var.ami_name
  }
}
