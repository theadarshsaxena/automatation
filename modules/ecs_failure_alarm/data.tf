data "aws_ecs_cluster" "ecs_cluster_arn" {
  cluster_name = var.cluster_name
}