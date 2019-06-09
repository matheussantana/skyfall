variable "cache_subnet_group_name"{
  type = string
}

variable "namespace" {
  type = string
}

variable "subnet_ids_list" {
  type = list(string)
}

#variable tags {
#  type = map
#}

resource "aws_elasticache_subnet_group" "default" {
  description = "Private subnets for the ElastiCache instances"
  name        = "${var.namespace}-${var.cache_subnet_group_name}"
  subnet_ids  = var.subnet_ids_list
  #tags = var.tags
}

output "cache_subnet_group" {
  value = aws_elasticache_subnet_group.default
}