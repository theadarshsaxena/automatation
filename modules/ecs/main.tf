resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

# Define IAM Roles and Policies for ECS Task Execution
# resource "aws_iam_role" "ecs_execution_role" {
#   name = var.ecs_iam_role_name

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Effect    = "Allow"
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
#   role       = aws_iam_role.ecs_execution_role.name
#   policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# resource "aws_iam_role" "ecs_task_role" {
#   name = "ecs_task_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Effect    = "Allow"
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# # Define ECS Task Definition
resource "aws_ecs_task_definition" "example" {
  family                   = var.task_definition_family
  execution_role_arn       = "arn:aws:iam::130248996185:role/ecsTaskExecutionRole"
  task_role_arn            = "arn:aws:iam::130248996185:role/ecsTaskExecutionRole"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "nginx"
    image     = "nginx:latest"  # Replace with your container image
    essential = true
    portMappings = [
      {
        containerPort = 80
        hostPort      = 80
      }
    ]
  }])
}

resource "aws_ecs_service" "ecs_service" {
  name            = "example-nginx"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.example.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = ["subnet-0b6665ee08118ffb3"]
    security_groups  = ["sg-065de8645ee414641"]
    assign_public_ip = true
  }
  depends_on = [aws_ecs_task_definition.example]
}

resource "aws_ecs_service" "ecs_service_duplicate" {
  name            = "nginx1"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.example.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = ["subnet-0b6665ee08118ffb3"]
    security_groups  = ["sg-065de8645ee414641"]
    assign_public_ip = true
  }
  depends_on = [aws_ecs_task_definition.example]
}
