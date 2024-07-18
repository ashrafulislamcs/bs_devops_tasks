# Set up Terraform provider version (if required)
terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
  }
}

# Defining AWS provider
provider "aws" {
  region = var.aws_region
}
