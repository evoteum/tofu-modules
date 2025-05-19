terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    netparse = {
      source  = "gmeligio/netparse"
      version = "0.0.3"
    }
  }
}
