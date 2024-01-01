terraform {
  required_version = ">= 0.15.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "2.3.0"
    }
  }
}
