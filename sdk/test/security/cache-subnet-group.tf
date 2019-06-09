module "cache-subnet-group" {
  source = "../modules/network/core/elasticache-subnet-group"
  namespace = var.namespace
  cache_subnet_group_name = "cache-subnet-group"
  subnet_ids_list = ["subnet-xxx", "subnet-xxx"]
  #tags = var.tags
}

output "cache-subnet-group" {
  value = module.cache-subnet-group
}