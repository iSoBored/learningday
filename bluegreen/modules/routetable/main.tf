resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_eip" "main" {
  depends_on = [aws_internet_gateway.main]
  tags = {
    Name = "${var.project}-eip"
  }
}

resource "aws_default_route_table" "public_route_table" {
  default_route_table_id = var.main_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.project}-public-rt"
  }
}

resource "aws_route_table_association" "alb_subnet_1_public_route_table_association" {
  subnet_id      = var.public_subnet_1_id
  route_table_id = aws_default_route_table.public_route_table.id
}

resource "aws_route_table_association" "alb_subnet_2_public_route_table_association" {
  subnet_id      = var.public_subnet_2_id
  route_table_id = aws_default_route_table.public_route_table.id
}