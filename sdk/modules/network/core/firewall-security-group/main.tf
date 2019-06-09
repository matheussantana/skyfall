variable "firewall_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "network_id" {
  type = string
}

variable "description" {
  type = string
  default = "Resource created by Terraform"
}

variable "tags" {
  type = map
}

resource "aws_security_group" "firewall-sg" {
  name = var.firewall_name
  description = var.description
  vpc_id = var.network_id
  tags = var.tags
}

output "firewall" {
  value = aws_security_group.firewall-sg
}