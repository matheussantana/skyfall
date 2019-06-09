variable "namespace" {
  type = string
}
/*
variable "rule_type" {
  type = string
  default = "ingress"
}*/

variable "from_port" {
  type = string
}

variable "to_port" {
  type = string
}

variable "protocol" {
  type = string
  default = "tcp"
}

variable "firewall-id" {
  type = string
}

variable "ip_range_list" {
  type = list(string)
}

resource "aws_security_group_rule" "allow_ingress" {
  type            = "ingress"
  from_port       = var.from_port
  to_port         = var.to_port
  protocol        = var.protocol
  cidr_blocks = var.ip_range_list

  security_group_id = var.firewall-id
}

resource "aws_security_group_rule" "allow_egress" {
  type            = "egress"
  from_port       = var.from_port
  to_port         = var.to_port
  protocol        = var.protocol
  cidr_blocks = var.ip_range_list

  security_group_id = var.firewall-id
}



output "ingress-rule" {
  value = aws_security_group_rule.allow_ingress
}

output "egress-rule" {
  value = aws_security_group_rule.allow_egress
}