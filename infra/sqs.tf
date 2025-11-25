resource "aws_sqs_queue" "async" {
  name                       = "${var.project_name}-async-queue"
  visibility_timeout_seconds = 60
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue" "dlq" {
  name = "${var.project_name}-async-dlq"
}

# API Gateway Integration for SQS (Async Route)
resource "aws_iam_role" "api_sqs" {
  name = "${var.project_name}-api-sqs-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "apigateway.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "api_sqs" {
  name = "sqs-send"
  role = aws_iam_role.api_sqs.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = "sqs:SendMessage"
      Effect   = "Allow"
      Resource = aws_sqs_queue.async.arn
    }]
  })
}

resource "aws_apigatewayv2_integration" "async" {
  api_id              = aws_apigatewayv2_api.main.id
  integration_type    = "AWS_PROXY"
  integration_subtype = "SQS-SendMessage"
  credentials_arn     = aws_iam_role.api_sqs.arn
  
  request_parameters = {
    "QueueUrl"    = aws_sqs_queue.async.id
    "MessageBody" = "$request.body"
  }
}
