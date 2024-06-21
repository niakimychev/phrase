resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = [aws_security_group.alb_sg.id]

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "https" {
  name        = "${var.alb_name}-https-tg"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/phrase"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }
}

#resource "aws_lb_target_group" "http" {
#  name        = "${var.alb_name}-http-tg"
#  port        = 80
#  protocol    = "HTTP"
#  vpc_id      = var.vpc_id
#  target_type = "ip"
#
#  health_check {
#    enabled             = true
#    interval            = 30
#    path                = "/phrase"
#    port                = "traffic-port"
#    protocol            = "HTTP"
#    healthy_threshold   = 3
#    unhealthy_threshold = 3
#    matcher             = "200"
#  }
#}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.https.arn
  }
}

# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = 80
#   protocol          = "HTTP"
# 
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.http.arn
#   }
#   # default_action {
#   #   type = "redirect"
#   #   redirect {
#   #     protocol   = "HTTPS"
#   #     port       = "443"
#   #     status_code = "HTTP_301"
#   #   }
#   # }
# }

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
    }
  }
}



resource "aws_security_group" "alb_sg" {
  name   = "phrase_nginx_alb_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
