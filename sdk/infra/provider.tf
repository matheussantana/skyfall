provider "aws" {
  profile                 = var.profile
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}

