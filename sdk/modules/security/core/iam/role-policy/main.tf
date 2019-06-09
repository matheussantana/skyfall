resource "aws_iam_role_policy" "role_policy" {
  name = "${var.namespace}_${var.role_policy_name}"
  role = var.role_id
  policy = var.policy
}