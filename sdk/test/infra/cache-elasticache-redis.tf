module "cache-HA-redis-cluster" {
  source = "../modules/storage/core/elasticache-HA-cluster-redis"
  namespace = var.namespace
  cache_name = "HA-cache-mk"
  security_group_ids_list = ["sg-xxx"]
  cache_subnet_group_name = "service-cache-subnet-group"
  tags = var.tags
}

output "cache-HA-redis-cluster" {
  value = module.cache-HA-redis-cluster
}

module "cache-standard-cluster" {
  source = "../modules/storage/core/elasticache-standard-cluster-redis"
  namespace = var.namespace
  cache_name = "std-cache"
  tags = var.tags
}

output "cache-standard-cluster" {
  value = module.cache-standard-cluster
}