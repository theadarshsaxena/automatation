variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "ecs_cluster"
}

variable "ecs_iam_role_name" {
  description = "Name of the IAM role for ECS"
  type        = string
  default     = "ecs_execution_role"
}

variable "task_definition_family_name" {
  description = "Name of the ECS task family"
  type        = string
  default     = "nginx-example"
}

variable "event_bridge_rule_name" {
  description = "rule name for event bridge used in the ecs_failure_alarm"
  type        = string
  default     = "ecs_failure_detection_rule"
}