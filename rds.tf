module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "web-rds"

  create_db_option_group    = false
  create_db_parameter_group = false
  create_random_password    = false

  engine                    = var.db_engine
  engine_version            = var.db_engine_version
  instance_class            = var.db_instance_class
  allocated_storage         = var.db_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  port     = var.db_port
  password = var.db_password

  iam_database_authentication_enabled = false

  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets
  multi_az               = true
  vpc_security_group_ids = [aws_security_group.allow_mysql.id]

  maintenance_window = var.db_maintenance_window
  backup_window      = var.db_backup_window

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

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}
