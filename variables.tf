# VPC Variables

variable "public_subnets" {
  description = "List of public subnets in the VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "private_subnets" {
  description = "List of private subnets in the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "cidr" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# ASG Variables

variable "image_id" {
  description = "Image ID to be used by asg"
  type        = string
  default     = "ami-06e0ce9d3339cb039"
}

variable "instance_type" {
  description = "Instance type for the asg"
  type        = string
  default     = "t3.micro"
}


# DB Variables

variable "db_engine" {
  description = "db engine"
  type        = string
  default     = "mariadb"
}

variable "db_engine_version" {
  description = "db engine version"
  type        = string
  default     = "10.6.10"
}

variable "db_instance_class" {
  description = "db instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "db allocated storage"
  type        = string
  default     = "5"
}
