module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.7.1"
  name    = "swo-${var.region}-asg"

  min_size                  = 2
  max_size                  = 2
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  health_check_type         = "ELB"
  vpc_zone_identifier       = module.vpc.public_subnets

  initial_lifecycle_hooks = [
    {
      name                  = "StartupLifeCycleHook"
      default_result        = "CONTINUE"
      heartbeat_timeout     = 60
      lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                  = "TerminationLifeCycleHook"
      default_result        = "CONTINUE"
      heartbeat_timeout     = 180
      lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = "swo-asg"
 rds
  launch_template_description = "Launch"

  launch_template_description = "Launch template"
 main
  update_default_version      = true

  image_id          = var.image_id
  instance_type     = var.instance_type
  ebs_optimized     = true
  enable_monitoring = true
  user_data         = base64encode(file("${path.module}/userdata.sh"))

  # Security Group
 rds
  security_groups = [aws_security_group.allow_http.id]

  security_groups = [aws_security_group.allow_all.id]
> main

  # Load Balancer
  target_group_arns = [aws_lb_target_group.swo-elb.arn]
}
