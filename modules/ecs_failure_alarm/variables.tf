variable "cluster_name" {
  description = "ECS Cluster name to monitor"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "rule_name" {
  description = "Name of the EventBridge rule"
  type        = string
}

#----------LAMBDA VARIABLES TO BE REVIEWED---------------#

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  default     = "lambda_for_ecs"
}

variable "python_runtime" {
  description = "Python runtime for the Lambda function"
  default     = "python3.9"
}

variable "sns_topic_arn" {
  description = "sns topic for sending the email alert"
  type        = string
}
