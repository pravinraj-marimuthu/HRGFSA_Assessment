output "cluster_name" {
  value = module.eks.cluster_id
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "ecr_repo" {
  value = aws_ecr_repository.hello_repo.repository_url
}