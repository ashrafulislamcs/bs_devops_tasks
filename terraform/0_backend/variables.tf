variable "remote_state_s3_name" {
  default     = "assessment-remote-state-s3"
  description = "Common prefix for AWS resources names"
}

variable "remote_state_dynamodb_table_name" {
  default     = "assessment-remote-state-dynamodb"
  description = "remote state table for assessment terraform"
}

variable "aws_region" {
  default     = "eu-west-1"
  description = "terraform statefile region"
}
