output "cluster_name" {
  value = module.eks.cluster_id
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "ecr_repo" {
  value = aws_ecr_repository.hello_repo.repository_url
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "ecr_repo_url" {
  value = aws_ecr_repository.hello_repo.repository_url
}