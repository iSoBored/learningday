resource "aws_lb_target_group" "app_target_group" {
  count = 2
  name = "${var.project}-app-tg-${count.index}"
  target_type      = "instance"
  protocol_version = "HTTP1"
  protocol         = "HTTP"
  port             = 80
  vpc_id           = var.vpc_id
  tags = {
    Name = "${var.project}-app-tg-${count.index}"
  }

  health_check {
    port = 80
    protocol = "HTTP"
    path = "/"
  }
}

resource "aws_lb_target_group_attachment" "app_attachement" {
  count = 2
  target_group_arn = aws_lb_target_group.app_target_group[count.index].arn
  target_id        = var.app_instance_ids[count.index]
}

resource "aws_lb" "main" {
  name               = "${var.project}-alb"
  load_balancer_type = "application"
  subnets            = [var.alb_subnet_1_id, var.alb_subnet_2_id]
  security_groups    = [var.alb_security_group]
  tags = {
    Name = "${var.project}-alb"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.app_target_group[0].arn
        weight = 1
      }

      target_group {
        arn = aws_lb_target_group.app_target_group[1].arn
        weight = 0
      }
    }
  }
}