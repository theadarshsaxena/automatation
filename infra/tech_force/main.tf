provider "aws" {
    region = "us-east-1"
    profile = "default"
}

# module "ecs_cluster" {
#   source = "../../modules/ecs"
#   ecs_cluster_name = var.ecs_cluster_name
#   ecs_iam_role_name = var.ecs_iam_role_name
#   task_definition_family = "example-nginx"
# }

# module "alerts" {
#   source = "../../modules/alerts"
#   email_subscription_list = ["adarshsaxena358@gmail.com", "arvind.chikne@gmail.com"]
#   ecs_cluster_name = var.ecs_cluster_name
#   sns_topic_name = "ecs-alerts"
# }