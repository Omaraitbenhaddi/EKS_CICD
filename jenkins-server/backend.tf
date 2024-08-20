terraform {
  backend "s3" {
    bucket = "primuslearning-appomar12"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}

