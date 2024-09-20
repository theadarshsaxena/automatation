# --------------- Providers defn -----------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.55"
    }
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }

  required_version = ">= 1.2.0"
}

# Provider configuration
provider "aws" {
    region = "us-east-1"
    profile = "default"
}

provider "ansible" {
}