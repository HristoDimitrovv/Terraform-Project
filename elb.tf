resource "aws_lb" "web_elb" {

  name               = "web-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

}

resource "aws_lb_target_group" "web-elb" {
  name        = "web-elb"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_listener" "web-elb" {
  load_balancer_arn = aws_lb.web_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-elb.arn
  }

  tags = {
    Project     = var.project
    Environment = var.environment
  }

}