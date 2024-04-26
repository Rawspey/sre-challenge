terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}
provider "aws" {
    region = "us-west-2"
    profile = "639035123345_PowerUserAccess"
}

terraform {
  backend "s3" {
    bucket = "eea-sre-challenge"
    key    = "terraform_state"
    region = "us-west-2"
    encrypt = true
    profile = "639035123345_PowerUserAccess"
    sts_region = "eu-west-1"
  }
}