data "aws_caller_identity" "current" {}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_function_name}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# AWSLambdaBasicExecutionRole
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# AmazonECSReadOnlyAccess

resource "aws_iam_role_policy" "read_only_ecs" {
  name = "ECSReadOnlyAccess"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "ecs:GetTaskProtection",
          "ecs:ListAccountSettings",
          "ecs:DescribeCapacityProviders",
          "ecs:ListTagsForResource",
          "ecs:DescribeServices",
          "ecs:DescribeTaskSets",
          "ecs:DescribeContainerInstances",
          "ecs:DescribeTasks",
          "ecs:DescribeTaskDefinition",
          "ecs:DescribeClusters"
        ],
        "Resource" : "*"
      }
    ]
  })
}


# AmazonSNSFullAccess
resource "aws_iam_role_policy_attachment" "sns_full_access" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}

data "archive_file" "lambda_zip" {
  type = "zip"
  source_content = tostring(templatefile("${path.module}/lambda_code.py", {
    sns_arn_replacement = var.sns_topic_arn
  }))
  source_content_filename = "lambda_code.py"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "lambda_for_ecs_failure" {
  function_name    = var.lambda_function_name
  runtime          = var.python_runtime
  handler          = "lambda_code.lambda_handler"
  role             = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  architectures    = ["x86_64"]

  # Optional: Specify timeout, memory, etc.
  timeout     = 30
  memory_size = 128
}

# EventBridge (CloudWatch Events) Target
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = var.rule_name
  target_id = "LambdaTarget"
  arn       = aws_lambda_function.lambda_for_ecs_failure.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_for_ecs_failure.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ecs_task_state_change_rule.arn
}
