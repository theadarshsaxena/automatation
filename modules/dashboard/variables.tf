variable "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
}

variable "cluster_name" {
  description = "ECS Cluster name to monitor"
  type        = string
}

variable "ecs_services" {
  description = "ECS Services in the cluster provided"
  type        = list(string)
  default     = ["example-nginx"]
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}