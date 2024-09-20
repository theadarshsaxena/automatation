variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_iam_role_name" {
  description = "Name of the IAM role for ECS"
  type        = string
  default     = "ecs_execution_role"
}

variable "task_definition_family" {
  description = "Name of the ECS task family"
  type        = string
  default     = "example"
}