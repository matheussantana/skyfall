module "dynamodb" {
  source = "../modules/database/core/dynamodb"

  db_attributes = {
    id    = "S"
    ts = "N"
  }
  primary_key = "id"
  secondary_key = "ts"
  tags = var.tags
  namespace = var.namespace
  table_name = "nosqlDB-mock-25819"
}

output "dynamodb" {
  value = module.dynamodb
}