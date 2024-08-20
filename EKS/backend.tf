terraform {
  backend "s3" {
    bucket = "primuslearning-appomar12"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}

