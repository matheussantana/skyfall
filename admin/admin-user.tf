############################
# User/Service Credentials #
# Module: CreateAcessProfile
############################

module "CreateAcessProfile_AdminProfile" {
  source = "../modules/security/ext/auth/CreateAccessProfile"
  username = "admin-user"
  namespace = var.namespace
  target_service = "ec2.amazonaws.com"
  access_level = "Allow"
  role_name = "admin-role"
}

output "AuthProfile_AdminProfile" {
  value = module.CreateAcessProfile_AdminProfile
}


###
# Policy
# Module: GrantAccessTo_ACL
###

module "GrantAccessTo_ACL_Adm" {
  source = "../modules/security/ext/auth/GrantAccessTo_ACL"
  policy_name = "sqs_access"
  namespace = var.namespace
  access_level = "Allow"
  target_service = "sqs"
  operation_list = ["*"]

  target_resource_id_list = ["*"]

  region = var.region
  account-id = var.account-id

  target_user_name = module.CreateAcessProfile_AdminProfile.aws-user.user.name
  target_role_name = module.CreateAcessProfile_AdminProfile.aws-role.access_role.name
}

output "AcessControl_PolicyRule_Adm" {
  value = module.GrantAccessTo_ACL_Adm.policy
}
