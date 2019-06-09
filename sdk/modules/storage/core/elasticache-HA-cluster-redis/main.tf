variable "cache_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "node_type" {
  type = string
  default = "cache.t2.small"
}

variable "parameter_group_name" {
  type = string
  default = "default.redis5.0.cluster.on"
}

variable "description" {
  type = string
  default = "Resource created by Terraform"
}

variable "port" {
  type = string
  default = 6379

}

variable "security_group_ids_list" {
  type = list(string)
}

variable "tags" {
  type = map
}

variable cache_subnet_group_name {
  type = string
}

variable cluster_replicas_per_node_group {
  type = string
  default = 1
}

variable cluster_num_node_groups {
  type = string
  default = 2
}

resource "aws_elasticache_replication_group" "cache-cluster" {
  replication_group_id          = "${var.namespace}-${var.cache_name}"
  replication_group_description = var.description
  node_type                     = var.node_type
  port                          = var.port
  parameter_group_name          = var.parameter_group_name
  automatic_failover_enabled    = true
  subnet_group_name             = var.cache_subnet_group_name
  security_group_ids            = var.security_group_ids_list
  apply_immediately             = true

  cluster_mode {
    replicas_per_node_group = var.cluster_replicas_per_node_group
    num_node_groups         = var.cluster_num_node_groups
  }

  tags = var.tags
}

output "cache-cluster" {
  value = aws_elasticache_replication_group.cache-cluster
}

/*
resource "aws_elasticache_replication_group" "baz" {
  replication_group_id          = "tf-redis-cluster"
  replication_group_description = "test description"
  node_type                     = "cache.t2.small"
  port                          = 6379
  parameter_group_name          = "default.redis3.2.cluster.on"
  automatic_failover_enabled    = true

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 2
  }
}
*/