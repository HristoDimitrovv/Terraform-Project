module "efs" {
  source = "terraform-aws-modules/efs/aws"

  # File system
  name           = "swo-${var.region}-efs"
  creation_token = "token"
  encrypted      = false

  # File system policy
  attach_policy                      = true
  bypass_policy_lockout_safety_check = false
  policy_statements = [
    {
      sid     = "Allow mount"
      actions = ["elasticfilesystem:ClientMount"]
      principals = [
        {
          type        = "AWS"
          identifiers = ["*"]
        }
      ]
    }
  ]

  # Mount targets / security group
  mount_targets = {
    (var.azs[0]) = {
      subnet_id = module.vpc.public_subnets[0]
    }
    (var.azs[1]) = {
      subnet_id = module.vpc.public_subnets[1]
    }
  }

  # Security group
  security_group_vpc_id = module.vpc.vpc_id

  # Backup policy
  enable_backup_policy = false

  # Replication configuration
  create_replication_configuration = false

  tags = {
    Project = "swo"
    Environment = var.region
  }
}
