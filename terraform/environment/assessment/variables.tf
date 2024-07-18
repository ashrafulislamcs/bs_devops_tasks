variable "backend_host" {
  default = "tf-api.test.com"
}
variable "prefix" {
  default     = "nspre"
  description = "Common prefix for AWS resources names"
}
variable "namespace" {
  default     = "test"
  description = "Common prefix for AWS resources names"
}
variable "aws_region" {
  default     = "ap-south-1"
  description = "AWS Region to deploy VPC"
}
variable "vpc_cidr" {
  default     = "10.20.0.0/16"
  description = "VPC CIDR range"
}
variable "alb_certificate_arn" {
  default     = "arn:aws:acm:us-east-1:123456789123:certificate/a22be3b8-458c-48e3-b2a8-e9f5b316bb68"
  description = "Certificate ARN"
}
variable "domain_name" {
  default     = "test.com"
  description = "newprod-integration domain"
}
variable "kms_id" {
  default     = false
  description = "newprod-integration domain"
}
variable "allow_destroy" {
  default = true
}
