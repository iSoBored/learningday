resource "aws_instance" "app_instance" {
  count = 2
  instance_type        = var.instance_type
  ami                  = var.ami
  subnet_id            = var.public_subnets_ids[count.index]
  vpc_security_group_ids = [var.app_security_group_id]
  associate_public_ip_address = true
  user_data            = <<-EOF
                        #!/bin/bash
                        yum update -y
                        yum install -y httpd
                        systemctl start httpd
                        systemctl enable httpd
                        echo "<h1>Hello World from version ${count.index}</h1>" > /var/www/html/index.html
                        EOF
  tags = {
    Name = "${var.project}-app-ec2-${count.index}"
  }
}