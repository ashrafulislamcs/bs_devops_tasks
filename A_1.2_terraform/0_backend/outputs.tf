output "remote_state_s3_bucket_id" {
  description = "The name of the bucket."
  value       = module.remote_state_s3.s3_bucket_id
}

output "remote_state_s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = module.remote_state_s3.s3_bucket_arn
}

output "remote_state_dynamodb_table_id" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = module.remote_state_dynamodb_table.dynamodb_table_id
}

output "remote_state_dynamodb_table_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = module.remote_state_dynamodb_table.dynamodb_table_arn
}
