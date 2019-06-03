resource "aws_iam_user_policy_attachment" "policy" {
  policy_arn = var.target_policy_id
  user = var.username
}

variable "username" {
  type = "string"
}

variable "target_policy_id" {
  type = "string"
}