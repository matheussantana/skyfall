############################
# User/Service Credentials #
# Module: CreateAcessProfile
############################

module "CreateAcessProfile_ServiceProfile" {
  source = "../modules/security/ext/auth/CreateAccessProfile"
  username = "service-user"
  namespace = var.namespace
  target_service = "ec2.amazonaws.com"
  access_level = "Allow"
  role_name = "service-role"
}

output "AuthProfile_ServiceProfile" {
  value = module.CreateAcessProfile_ServiceProfile
}


###
# Policy
# Module: GrantAccessTo_ACL
###

module "GrantAccessTo_ACL_ServiceProfile" {
  source = "../modules/security/ext/auth/GrantAccessTo_ACL"
  policy_name = "dynamodb_access"
  namespace = var.namespace
  access_level = "Allow"
  target_service = "dynamodb"
  operation_list = ["*","action1","action2"]

  target_resource_id_list = ["table/TableA", "table/TableB"]

  region = var.region
  account-id = var.account-id



  target_user_name = module.CreateAcessProfile_ServiceProfile.aws-user.user.name
  target_role_name = module.CreateAcessProfile_ServiceProfile.aws-role.access_role.name
}

output "AcessControl_PolicyRule_ServiceProfile" {
  value = module.GrantAccessTo_ACL_ServiceProfile.policy
}
