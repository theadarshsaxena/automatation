provider "aws" {
  region  = "us-east-2"
  profile = "work"
}

# module "ecs_cluster" {
#   source                 = "../../modules/ecs"
#   ecs_cluster_name       = var.ecs_cluster_name
#   ecs_iam_role_name      = var.ecs_iam_role_name
#   task_definition_family = "example-nginx"
# }

# module "dashboard" {
#     source = "../../modules/dashboard"
#     dashboard_name = "ECS-${var.ecs_cluster_name}"
#     cluster_name = var.ecs_cluster_name
# }

# module "alerts" {
#   source                  = "../../modules/alerts"
#   email_subscription_list = ["adarshsaxena358@gmail.com"]
#   ecs_cluster_name        = var.ecs_cluster_name
#   sns_topic_name          = "ecs-alerts"
#   ecs_services            = var.all_names["ecs_service_names"]
# }

# module "ecs_failure_alert" {
#   source               = "../../modules/ecs_failure_alarm"
#   cluster_name         = var.ecs_cluster_name
#   rule_name            = "${var.ecs_cluster_name}-monitor-event-bridge"
#   lambda_function_name = "ecs_failure_alerts"
#   sns_topic_arn        = module.alerts.sns_arn
# }

# module "ecs_alerts" {
#   source = "../../../../modules/ecs_alerts"
#   sns_topic_name   = "${var.env}-matterworx-sns-topic"
#   email_subscription_list = var.email_subscription_list
#   ecs_cluster_name = var.ecs_cluster_name
#   region=var.region
#   evaluation_periods = var.evaluation_periods
#   period = var.period
#   threshold = var.threshold
#   datapoints_to_alarm = var.datapoints_to_alarm
#   ecs_service_names = lookup(var.all_names, "ecs_service_names", [])
#   dashboard_name = "${var.env}-matterworx-ecs"

#   providers = {
#     aws = aws.dev-account
#   }
# }

module "ses" {
  source = "../../modules/ses"
}

# output "ses_verification_token" {
#   value = module.ses.verification_token
# }

# output "cname_records" {
#   value = module.ses.cname_records
# }