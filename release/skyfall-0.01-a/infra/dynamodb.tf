module "dynamodb" {
  source = "..\/moduless\/security\/core\/dynamodb"

  db_attributes = {
    id    = "S"
    ts = "N"
  }
  primary_key = "id"
  sort_key = "ts"
  tags = var.tags
  namespace = var.namespace
  table_name = "nosql-tableA"
}

output "dynamodb" {
  value = module.dynamodb
}