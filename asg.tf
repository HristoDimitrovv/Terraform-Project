module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.7.1"
  name    = "web-asg"

  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  health_check_type         = var.health_check_type
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
  launch_template_name        = "web-asg"
  launch_template_description = "Launch web servers"
  update_default_version      = true

  image_id          = var.image_id
  instance_type     = var.instance_type
  ebs_optimized     = true
  enable_monitoring = true
  user_data = base64encode(templatefile("${path.module}/userdata.sh",
      {
        "DB_USERNAME" = "${var.db_username}",
        "DB_PASSWORD" = "${var.db_password}",
        "DB_HOSTNAME" = "${module.db.db_instance_address}",
        "DATABASE"    = "bulgaria",
      }
  ))

  # Security Group
  security_groups = [aws_security_group.allow_http.id, aws_security_group.allow_mysql.id]

  # Load Balancer
  target_group_arns = [aws_lb_target_group.web-elb.arn]

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}
