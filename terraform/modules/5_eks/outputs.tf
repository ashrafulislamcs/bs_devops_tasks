output "prefix" {
  value       = local.prefix
  description = "Exported common resources prefix"
}

output "common_tags" {
  value       = local.common_tags
  description = "Exported common resources tags"
}
output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "Exported common resources tags"
}

output "cluster_certificate_authority_data" {
  value       = module.eks.cluster_certificate_authority_data
  description = "Exported common resources tags"
}

output "node_security_group_id" {
  value       = module.eks.node_security_group_id
  description = "EKS Node Security Group ID"
}
output "cluster_security_group_id" {
  value       = module.eks.cluster_security_group_id
  description = "EKS Cluster Security Group ID"
}

output "cluster_primary_security_group_id" {
  value       = module.eks.cluster_primary_security_group_id
  description = "EKS Node Primary Security Group ID"
}

output "cluster_id" {
  value       = module.eks.cluster_id
  description = "EKS Node Primary Security Group ID"
}

output "flarie_namespace" {
  value       = kubernetes_namespace.flarie_service.id
  description = "EKS Node Primary Security Group ID"
}
output "eks_admins_iam_role" {
  value = module.eks_admins_iam_role.iam_role_name
}