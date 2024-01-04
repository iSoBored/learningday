resource "aws_subnet" "main" {
  for_each = var.subnet_details
 
  availability_zone = each.value["az"]
  cidr_block = each.value["cidr"]
  vpc_id     = var.vpc_id
  tags = {
    Name = "${var.project}-${each.key}"
  }
}