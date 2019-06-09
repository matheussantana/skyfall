variable "namespace" {
  type = string
}

variable "table_name" {
  type = string
}

variable "read_capacity" {
  type = string
  default = 6
}

variable "write_capacity" {
  type = string
  default = 6
}

variable "primary_key" {
  type = string
  default = "primary_key"
}

variable "secondary_key" {
  type = string
  default = "secondary_key"
}

variable "tags" {
  type = map

}

variable "db_attributes"{
  type = map
  default = {
        primary_key    = "S"
        secondary_key  = "S"
  }
}

/*
locals {
  db_attributes = {
    id    = "S"
  }
}*/

output "aws_dynamodb_table" {
  value = aws_dynamodb_table.dynamodb-table.name
}

resource "aws_dynamodb_table" "dynamodb-table" {
  name = "${var.namespace}_${var.table_name}"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.primary_key
  range_key       = var.secondary_key


  dynamic "attribute" {
    for_each = var.db_attributes #local.dynamodb_attributes
    content {
      name = attribute.key
      type = attribute.value
    }
  }

  point_in_time_recovery {
    enabled = true
  }

  #attribute = ["${var.att}"]
  #attribute = jsonencode(var.att)

  #attribute {
  #  name = "id"
  #  type = "S"
  #}


  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity,
    ] #We want this ignored so that we can use app autoscaling
  }

  tags = var.tags

}

resource "aws_appautoscaling_target" "dynamodb_table_read_target" {
  max_capacity       = 100
  min_capacity       = 1
  resource_id        = "table/${aws_dynamodb_table.dynamodb-table.name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}


resource "aws_appautoscaling_policy" "dynamodb_table_read_policy" {
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_read_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "${aws_appautoscaling_target.dynamodb_table_read_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.dynamodb_table_read_target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.dynamodb_table_read_target.service_namespace}"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = 70
  }
}


