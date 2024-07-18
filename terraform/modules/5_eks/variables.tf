variable "prefix" {}

variable "aws_region" {}
variable "backend_host" {}

variable "namespace" {
  default     = "dev"
  description = "Environment VPC ID"
}

variable "vpc_id" {
  default     = "vpc-id"
  description = "Environment VPC ID"
}

variable "private_subnets" {
  default     = "private_subnets"
  description = "VPC private subnets IDs list"
}

variable "db_sg_id" {
  default     = "database security_group_id"
  description = "Security Group ID"
}

variable "default_instance_type" {
  default     = "t3.medium"
  description = "AWS VPC CIDR range"
}
