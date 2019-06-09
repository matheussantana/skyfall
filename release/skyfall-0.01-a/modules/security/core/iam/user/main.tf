resource "aws_iam_user" "user" {
  name = "${var.namespace}_${var.username}"
  #name = format("%s_%s", var.username, var.namespace)
}

resource "aws_iam_access_key" "user" {
  user = aws_iam_user.user.name
}

