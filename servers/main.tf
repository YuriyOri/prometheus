terraform {
  required_version = ">= 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.67"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.default_zone
}

