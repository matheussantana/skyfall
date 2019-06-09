variable "cache_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "node_type" {
  type = string
  default = "cache.m4.large"
}

variable "parameter_group_name" {
  type = string
  default = "default.redis3.2"
}

variable "description" {
  type = string
  default = "Resource created by Terraform"
}

variable "port" {
  type = string
  default = 6379

}

variable "tags" {
  type = map
}

variable engine {
  type = string
  default = "redis"
}

variable num_nodes {
  type = string
  default = 1
}

variable engine_version {
  type = string
  default = "3.2.10"
}

resource "aws_elasticache_cluster" "cluster" {
  cluster_id           = "${var.namespace}-${var.cache_name}"
  engine               = var.engine
  node_type            = var.node_type
  num_cache_nodes      = var.num_nodes
  parameter_group_name = var.parameter_group_name
  engine_version       = var.engine_version
  port                 = var.port
  tags = var.tags
}

output "cache" {
  value = aws_elasticache_cluster.cluster
}