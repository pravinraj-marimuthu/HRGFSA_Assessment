terraform {
  required_version = ">= 1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

# VPC module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.0"

  name               = "${var.cluster_name}-vpc"
  cidr               = "10.0.0.0/16"
  azs                = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
}

# EKS cluster module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.33"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  cluster_endpoint_public_access = true
  eks_managed_node_groups = {
    default = {
      ami_type = "AL2023_x86_64_STANDARD"
      desired_size = var.node_desired_capacity
      max_size     = var.node_max_capacity
      min_size     = var.node_min_capacity
      instance_types   = var.node_instance_types
    }
  }
}

# ECR repository
resource "aws_ecr_repository" "hello_repo" {
  name = "hello-k8s"
  image_scanning_configuration {
    scan_on_push = true
  }
  lifecycle {
    prevent_destroy = false
  }
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "ecr_repo_url" {
  value = aws_ecr_repository.hello_repo.repository_url
}