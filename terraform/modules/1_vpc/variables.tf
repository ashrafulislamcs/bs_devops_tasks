variable "prefix" {}

variable "aws_region" {}

variable "vpc_cidr" {
  default     = "10.100.0.0/16"
  description = "AWS VPC CIDR range"
}
