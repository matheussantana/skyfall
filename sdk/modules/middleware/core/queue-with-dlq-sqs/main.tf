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
  default = 3600
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

variable target_dlq_id {
  type = string
}

variable max_receive_count {
  type = string
  default = 4
}


resource "aws_sqs_queue" "queue" {
  name                      = "${var.namespace}-${var.queue_name}"
  delay_seconds             = var.delay_sec
  max_message_size          = var.max_msg_size
  message_retention_seconds = var.msg_retention_sec
  receive_wait_time_seconds = var.rcv_wait_time_sec
  redrive_policy            = "{\"deadLetterTargetArn\":\"${var.target_dlq_id}\",\"maxReceiveCount\":${var.max_receive_count}}"

  # source: https://stackoverflow.com/questions/52359343/how-to-specify-dead-letter-dependency-using-modules

  /*redrive_policy = (
      var.target_dlq_id == "" ?
      "{\"deadLetterTargetArn\":\"${module.std-dlq.dlq_queue}\",\"maxReceiveCount\":${var.max_receive_count}" :
      "{\"deadLetterTargetArn\":\"${var.target_dlq_id.arn}\",\"maxReceiveCount\":${var.max_receive_count}"
    )*/
  tags = var.tags


}

output "queue" {
  value = aws_sqs_queue.queue
}