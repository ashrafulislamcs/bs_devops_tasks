output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "vpc_name" {
  value       = module.vpc.name
  description = "VPC name"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "VPC public subnets' IDs list"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "VPC private subnets' IDs list"
}

output "intra_subnets" {
  value       = module.vpc.intra_subnets
  description = "VPC intra subnets' IDs list"
}

output "database_subnet_group" {
  value       = module.vpc.database_subnet_group
  description = "VPC database subnet group list"
}

output "elasticache_subnet_group_name" {
  value       = module.vpc.elasticache_subnet_group_name
  description = "Elasticache subnet group name"
}

output "database_subnets_cidr_blocks" {
  value       = module.vpc.database_subnets_cidr_blocks
  description = "Database Subnet CIDR Block"
}

output "database_subnets" {
  value       = module.vpc.database_subnets
  description = "Database Subnet"
}

output "private_subnets_cidr_blocks" {
  value       = module.vpc.private_subnets_cidr_blocks
  description = "Private Subnet CIRD Block"
}
output "azs" {
  value       = module.vpc.azs
  description = "VPC Availability Zones"
}

output "log_bucket_domain_name" {
  value = module.log_bucket.s3_bucket_bucket_regional_domain_name
}
output "cloudfront_log_bucket" {
  value = module.cloudfront_log_bucket.s3_bucket_bucket_domain_name
}
output "default_security_group_id" {
  value = module.vpc.default_security_group_id
}