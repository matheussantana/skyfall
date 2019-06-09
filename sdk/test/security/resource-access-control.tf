############################
# User/Service Credentials #
# Module: CreateAcessProfile
############################

module "CreateAcessProfile_AdminProfile" {
  source = "../modules/security/ext/auth/CreateAccessProfile"
  username = "admin-user-app-mock"
  namespace = var.namespace
  target_service = "ec2.amazonaws.com"
  access_level = "Allow"
  role_name = "admin-role-app-mock"
}

output "AuthProfile_AdminProfile" {
  value = module.CreateAcessProfile_AdminProfile
}


###
# Policy DynamoDB Access Control
# Module: GrantAccessTo_ACL
###


module "DynDB_GrantAccessTo_ACL_Adm" {
  source = "../modules/security/ext/auth/GrantAccessTo_ACL"
  policy_name = "dynamodb_acl"
  namespace = var.namespace
  access_level = "Allow"
  target_service = "dynamodb"
  operation_list = ["*"]
  prefix = "table/"

  target_resource_id_list = ["nosqlDB-mock-${random_integer.value.id}"]

  region = var.region
  account-id = var.account-id

  target_user_name = module.CreateAcessProfile_AdminProfile.aws-user.user.name
  target_role_name = module.CreateAcessProfile_AdminProfile.aws-role.access_role.name
}

output "DynDB_AcessControl_PolicyRule_Adm" {
  value = module.DynDB_GrantAccessTo_ACL_Adm.policy
}

###
# Policy Application AutoScaling for DynamoDB
# Module: GrantAccessTo_ACL
###

/*
source: https://docs.aws.amazon.com/autoscaling/application/userguide/auth-and-access-control.html
Specifying the Resource

Application Auto Scaling has no service-defined resources that can be used as the Resource element of an IAM policy statement. Therefore, there are no Amazon Resource Names (ARNs) for you to use in an IAM policy. To control access to Application Auto Scaling actions, always use an * (asterisk) as the resource when writing an IAM policy.
*/

module "AutoScaling_GrantAccessTo_ACL_Adm" {
  source = "../modules/security/ext/auth/GrantAccessTo_ACL"
  policy_name = "autoscaling_acl"
  namespace = var.namespace
  access_level = "Allow"
  target_service = "application-autoscaling"
  operation_list = ["*"]
  prefix = ""

  target_resource_id_list = ["*"]

  region = var.region
  account-id = var.account-id

  target_user_name = module.CreateAcessProfile_AdminProfile.aws-user.user.name
  target_role_name = module.CreateAcessProfile_AdminProfile.aws-role.access_role.name
}

output "AutoScaling_AcessControl_PolicyRule_Adm" {
  value = module.AutoScaling_GrantAccessTo_ACL_Adm.policy
}

###
# Policy S3 - Default Backend Storage
# Module: GrantAccessTo_ACL
###

module "S3_GrantAccessTo_ACL_Adm" {
  source = "../modules/security/ext/auth/GrantAccessTo_ACL"
  policy_name = "s3_acl"
  namespace = var.namespace
  access_level = "Allow"
  target_service = "s3"
  operation_list = ["*"]
  prefix = ""

  target_resource_id_list = ["default-backend-storage-${random_integer.value.id}*", "default-backend-storage-${random_integer.value.id}/*"]
  #target_resource_id_list = ["bucketTestA*", "bucketTestA-010111*"]

  region = ""
  account-id = ""

  target_user_name = module.CreateAcessProfile_AdminProfile.aws-user.user.name
  target_role_name = module.CreateAcessProfile_AdminProfile.aws-role.access_role.name
}

output "S3_AcessControl_PolicyRule_Adm" {
  value = module.S3_GrantAccessTo_ACL_Adm.policy
}

###
# Policy S3 - Fileserver S3
# Module: GrantAccessTo_ACL
###

module "S3FS_GrantAccessTo_ACL_Adm" {
  source = "../modules/security/ext/auth/GrantAccessTo_ACL"
  policy_name = "s3_acl"
  namespace = var.namespace
  access_level = "Allow"
  target_service = "s3"
  operation_list = ["*"]
  prefix = ""

  #target_resource_id_list = ["default-backend-storage-${random_integer.priority.id}*", "default-backend-storage-${random_integer.priority.id}/*"]
  target_resource_id_list = ["s3-fileserver-mock-${random_integer.value.id}*", "s3-fileserver-mock-${random_integer.value.id}*"]

  region = ""
  account-id = ""

  target_user_name = module.CreateAcessProfile_AdminProfile.aws-user.user.name
  target_role_name = module.CreateAcessProfile_AdminProfile.aws-role.access_role.name
}

output "S3FS_AcessControl_PolicyRule_Adm" {
  value = module.S3FS_GrantAccessTo_ACL_Adm.policy
}

###
# Policy Elasticache
# Module: GrantAccessTo_ACL
###

module "Cache_GrantAccessTo_ACL_Adm" {
  source = "../modules/security/ext/auth/GrantAccessTo_ACL"
  policy_name = "elasticache_acl"
  namespace = var.namespace
  access_level = "Allow"
  target_service = "elasticache"
  operation_list = ["*"]
  prefix = ""

  target_resource_id_list = ["*"]

  region = ""
  account-id = ""

  target_user_name = module.CreateAcessProfile_AdminProfile.aws-user.user.name
  target_role_name = module.CreateAcessProfile_AdminProfile.aws-role.access_role.name
}

output "Cache_AcessControl_PolicyRule_Adm" {
  value = module.Cache_GrantAccessTo_ACL_Adm.policy
}



###
# Policy Queue/DLQ SQS
# Module: GrantAccessTo_ACL
###

module "SQS_GrantAccessTo_ACL_Adm" {
  source = "../modules/security/ext/auth/GrantAccessTo_ACL"
  policy_name = "sqs_acl"
  namespace = var.namespace
  access_level = "Allow"
  target_service = "sqs"
  operation_list = ["*"]
  prefix = ""

  target_resource_id_list = ["middleware-queue-mock-${random_integer.value.id}", "middleware-dlq-mock-${random_integer.value.id}"]

  region = var.region
  account-id = var.account-id

  target_user_name = module.CreateAcessProfile_AdminProfile.aws-user.user.name
  target_role_name = module.CreateAcessProfile_AdminProfile.aws-role.access_role.name
}

output "SQS_AcessControl_PolicyRule_Adm" {
  value = module.SQS_GrantAccessTo_ACL_Adm.policy
}
