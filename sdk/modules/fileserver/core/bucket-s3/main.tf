variable "tags" {
  type = map

}

variable "partition-key" {
  type = string
}

variable "access_level" {
  type = string
  default = "private"
}

variable "namespace" {
  type = string
}
/*
resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.namespace}_${var.partition-key}"
  acl    = "log-delivery-write"
}
*/

resource "aws_s3_bucket" "fileserver" {
  bucket = "${var.namespace}-${var.partition-key}"
  acl    = var.access_level
  tags = var.tags
  force_destroy = true
  versioning {
    enabled = true
  }

  /*
  logging {
    target_bucket = "${var.namespace}_${var.partition-key}_${aws_s3_bucket.log_bucket}"
    target_prefix = "log/"
  }*/
}

output "aws_s3_bucket" {
  value = aws_s3_bucket.fileserver
}