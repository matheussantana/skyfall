terraform {
  backend "s3" {
    bucket  = "service-default-backend-storage"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    profile = "service_admin-user-app-mock"
  }
}
