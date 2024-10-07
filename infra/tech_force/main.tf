provider "aws" {
  region  = "us-east-1"
  profile = "work"
}

module "ecs_cluster" {
  source                 = "../../modules/ecs"
  ecs_cluster_name       = var.ecs_cluster_name
  ecs_iam_role_name      = var.ecs_iam_role_name
  task_definition_family = "example-nginx"
}

# module "dashboard" {
#     source = "../../modules/dashboard"
#     dashboard_name = "ECS-${var.ecs_cluster_name}"
#     cluster_name = var.ecs_cluster_name
# }

module "alerts" {
  source                  = "../../modules/alerts"
  email_subscription_list = ["adarshsaxena358@gmail.com"]
  ecs_cluster_name        = var.ecs_cluster_name
  sns_topic_name          = "ecs-alerts"
  ecs_services            = ["example-nginx"]
}

module "ecs_failure_alert" {
  source               = "../../modules/ecs_failure_alarm"
  cluster_name         = var.ecs_cluster_name
  rule_name            = "${var.ecs_cluster_name}-monitor-event-bridge"
  lambda_function_name = "ecs_failure_alerts"
  sns_topic_arn        = module.alerts.sns_arn
}
