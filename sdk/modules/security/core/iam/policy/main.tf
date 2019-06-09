resource "random_integer" "value" {
  min     = 1
  max     = 99999
}

resource "aws_iam_policy" "policy" {
  name        = "${var.namespace}_${var.policy_name}_${random_integer.value.id}"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {

      "Effect": "${var.access_level}",
      "Resource": ${jsonencode(var.target_resource)},
       "Action": ["${local.action_list}"]

    }
  ]
}
POLICY

}

locals {
  action_list = "${join("\", \"",formatlist( "%s:%s", var.target_service, var.operation_list))}"
}


/*
locals {
  json_policy =<<EOT
      %{ for rule in var.operation_list ~}
      "${var.target_service}:${rule}",
      %{ endfor }
EOT
}*/

variable "policy_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "access_level" {
  type = string
}

variable "target_service" {
  type = string
}

variable "operation_list"{
  type = list(string)
}

variable "target_resource" {
  type = list(string)
}

output "policy_id" {
  value = aws_iam_policy.policy.id
}
output "policy" {
  value = aws_iam_policy.policy
}

