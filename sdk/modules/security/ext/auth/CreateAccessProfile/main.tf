############################
# User/Service Credentials #
# Module: CreateAcessProfile
############################

module "aws-user" {
  source = "../../../core/iam/user"
  username = var.username
  namespace = var.namespace
}

output "aws-user" {
  value = module.aws-user
}

variable "username" {
  type = "string"
}

module "aws-role" {
  source = "../../../core/iam/role"
  role_name = var.role_name
  namespace = var.namespace
  target_service = var.target_service
  access_level = var.access_level
}

output "aws-role" {
  value = module.aws-role
}

variable "access_level" {
  type = "string"
  default = "allow"
}

variable "target_service" {
  type = "string"
}

variable "role_name" {
  type = "string"
  default = "aws-role"
}