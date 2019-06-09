module "dynamodb" {
  source = "..\/moduless\/security\/core\/dynamodb"

  db_attributes = {
    id    = "S"
    ts = "N"
  }
  primary_key = "id"
  secondary_key = "ts"
  tags = var.tags
  namespace = var.namespace
  table_name = "default-nosql-tableA"
}

output "dynamodb" {
  value = module.dynamodb
}