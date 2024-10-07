resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({
    widgets = flatten([
      for idx, service in var.ecs_services : [
        {
          "type"       = "metric"
          "x"          = 0
          "y"          = idx * 6  # Dynamic y position for CPU panel
          "width"      = 6
          "height"     = 6
          "properties" = {
            "metrics" = [
              [ "AWS/ECS", "CPUUtilization", "ClusterName", var.cluster_name, "ServiceName", service ]
            ]
            "title"     = "${service} - CPU Utilization"
            "period"    = 300
            "stat"      = "Average"
            "region"     = var.region
            "stacked"    = false
            "view"       = "timeSeries"
          }
        },
        {
          "type"       = "metric"
          "x"          = 6
          "y"          = idx * 6  # Dynamic y position for Memory pan el
          "width"      = 6
          "height"     = 6
          "properties" = {
            "metrics" = [
              [ "AWS/ECS", "MemoryUtilization", "ClusterName", var.cluster_name, "ServiceName", service ]
            ]
            "title"     = "${service} - Memory Utilization"
            "period"    = 300
            "stat"      = "Average"
            "region"     = var.region
            "stacked"    = false
            "view"       = "timeSeries"
          }
        }
      ]
    ])
  })
}

