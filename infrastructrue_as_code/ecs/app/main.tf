provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "terraform-ecs-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"

    dynamodb_table = "ecs-state-locks"
    encrypt        = true
  }
}
