resource "aws_cloudwatch_event_rule" "ecs_task_state_change_rule" {
  name        = var.rule_name
  description = "EventBridge rule for ECS Task State Change events"
  
  # Event source: "AWS events or EventBridge partner events"
  event_pattern = jsonencode({
    "source"      : ["aws.ecs"],
    "detail-type" : ["ECS Task State Change", "ECS Deployment State Change"],
    "detail" : {
      "clusterArn" : [data.aws_ecs_cluster.ecs_cluster_arn.arn]
    }
  })
}

