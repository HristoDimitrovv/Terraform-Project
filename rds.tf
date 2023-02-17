module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "swo-${var.region}-rds"

  engine            = "mariadb"
  engine_version    = "10.6.10"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "rds"
  username = "user"
  password = var.my_db_password
  port     = "3306"

  iam_database_authentication_enabled = false

  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets
  multi_az               = true
  vpc_security_group_ids = [aws_security_group.allow_http.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "swo"
    Environment = var.region
  }

  # DB parameter group
  family = "mariadb10.6"

  # DB option group
  major_engine_version = "10.6"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}
