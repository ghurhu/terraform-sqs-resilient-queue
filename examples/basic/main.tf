terraform {
  required_version = ">= 1.7.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}
module "queue" {
  source = "../.."
  name   = "community-demo"
  tags   = { Environment = "sandbox", Owner = "community" }
}
output "queue_url" {
  value = module.queue.queue_url
}
