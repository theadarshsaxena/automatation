# -------------------------------------------------------------
#     SNS topic & Subscription create
# -------------------------------------------------------------
resource "aws_sns_topic" "this" {
    name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "email_subscription" {
    for_each    = { for idx, email in var.email_subscription_list : idx => email }
    topic_arn   = aws_sns_topic.this.arn
    protocol    = "email"
    endpoint    = each.value
}

# -------------------------------------------------------------
#     SNS topic policy
# -------------------------------------------------------------

# resource "aws_sns_topic_policy" "this" {
#     arn = aws_sns_topic.this.arn

#     policy = jsonencode({
#         Version = "2012-10-17"
#         Statement = [
#             {
#                 Effect    = "Allow"
#                 Principal = "*"
#                 Action    = "sns:Publish"
#                 Resource  = aws_sns_topic.this.arn
#                 Condition = {
#                     StringEquals = {
#                         "AWS:SourceOwner" = aws_sns_topic.this.owner_id
#                     }
#                 }
#             },
#             {
#                 Effect    = "Allow"
#                 Principal = "*"
#                 Action    = "sns:Subscribe"
#                 Resource  = aws_sns_topic.this.arn
#                 Condition = {
#                     StringEquals = {
#                         "AWS:SourceOwner" = aws_sns_topic.this.owner_id
#                     }
#                 }
#             }
#         ]
#     })
# }

# -------------------------------------------------------------
#     Create cloudwatch metric alarm for ECS task
# -------------------------------------------------------------

variable "ecs_services" {
  description = "list of services"
  type = list(string)
  default = ["example-nginx"]
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_usage_alarm" {
  for_each = toset(var.ecs_services)
  alarm_name          = "ECS-Alarm-${var.ecs_cluster_name}-${split("/", each.value)[length(split("/", each.value)) - 1]}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "30"  # 1 minute
  statistic           = "Maximum"
  threshold           = "1"

  alarm_description   = "Alarm for CPU > 80 for Cluster: ${var.ecs_cluster_name} & Service: ${split("/", each.value)[length(split("/", each.value)) - 1]}"
  alarm_actions       = [aws_sns_topic.this.arn]
  insufficient_data_actions = []
  ok_actions          = []

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = split("/", each.value)[length(split("/", each.value)) - 1]
  }
}
