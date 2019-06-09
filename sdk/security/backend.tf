  terraform {
  backend "s3" {
    bucket  = "infra-deploy-backend"
    key     = "service/terraform.tfstate"
    region  = "us-east-1"
    profile = "infra-deploy-admin-lab"
  }
}

