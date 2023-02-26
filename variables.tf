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

variable "db_port" {
  description = "db port"
  type        = string
  default     = "3306"
}

variable "db_username" {
  description = "db username"
  type        = string
  default     = "user"
}

variable "db_password" {
  description = "db password"
  type        = string
  default     = "Password1"
}

variable "db_name" {
  description = "db name"
  type        = string
  default     = "rds"
}


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


variable "db_maintenance_window" {
  description = "db maintenance window"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "db_backup_window" {
  description = "db backup window"
  type        = string
  default     = "03:00-06:00"
}


# Tag variables

variable "project" {
  description = "Project tag"
  type        = string
  default     = "webapp"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "eu-west-1"
}


# ASG Variables

variable "max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "The desired capacity of the autoscaling group"
  type        = number
  default     = 2
}

variable "wait_for_capacity_timeout" {
  description = "The time to wait for capacity timeout"
  type        = number
  default     = 0
}

variable "health_check_type" {
  description = "health check type "
  type        = string
  default     = "ELB"
}



