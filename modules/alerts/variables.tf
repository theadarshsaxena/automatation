variable "sns_topic_name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "email_subscription_list" {
  description = "List of email addresses to subscribe to the SNS topic"
  type        = list(string)
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}