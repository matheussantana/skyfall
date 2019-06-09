terraform {
  backend "s3" {
    bucket  = "service-tfstate"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    profile = "service-admin-lab"
  }
}

