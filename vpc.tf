module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "swo-vpc"
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Project     = "swo"
    Environment = "eu-west-1"
  }
}
