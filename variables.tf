############ VPC Variables

variable "region" {
  description = "The default region of the project."
  type        = string
  default     = "eu-west-1"
}

variable "public_subnets" {
  description = "List of public subnets in the VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "private_subnets" {
  description = "List of private subnets in the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24"]
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

############ ASG Variables

variable "image_id" {
  description = "Image ID to be used by asg"
  type        = string
  default     = "ami-06e0ce9d3339cb039"
}

variable "instance_type" {
  description = "Instance type for the asg"
  type        = string
  default     = "t2.micro"
}
