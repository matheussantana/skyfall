###
# Resource DLQ SQS
# Module: standalone-queue-sqs
###


module "dlq-sqs" {
  source = "../modules/middleware/core/standalone-queue-sqs"
  namespace = var.namespace
  queue_name = "middleware-dlq-mock"
  tags = var.tags
}

output "dql-sqs" {
  value = module.dlq-sqs
}

###
# Resource Queue SQS
# Module: queue-with-dlq-sqs
###

module "queue" {
  source = "../modules/middleware/core/queue-with-dlq-sqs"
  namespace = var.namespace
  queue_name = "middleware-queue-mock"
  target_dlq_id = module.dlq-sqs.queue.arn
  tags = var.tags
}

output "queue" {
  value = module.queue
}