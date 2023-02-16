resource "aws_lb" "swo_elb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_all.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

}

resource "aws_lb_target_group" "swo-elb" {
  name        = "swo-elb"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_listener" "swo-elb" {
  load_balancer_arn = aws_lb.swo_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.swo-elb.arn
  }
}
