variable delay_sec {
  type = string
  default = 1
}

variable max_msg_size {
  type = string
  default = 262144
}

variable msg_retention_sec {
  type = string
  default = 1209600
}

variable "rcv_wait_time_sec" {
  type = string
  default = 1
}

variable tags {
  type = map
}

variable namespace {
  type = string
}

variable queue_name {
  type = string
}


resource "aws_sqs_queue" "queue" {
  name                      = "${var.namespace}-${var.queue_name}"
  delay_seconds             = var.delay_sec
  max_message_size          = var.max_msg_size
  message_retention_seconds = var.msg_retention_sec
  receive_wait_time_seconds = var.rcv_wait_time_sec
  tags = var.tags
}

output "queue" {
  value = aws_sqs_queue.queue
}


