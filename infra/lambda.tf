# Common IAM Role for Lambdas (Simplified for brevity, ideally separate)
resource "aws_iam_role" "lambda" {
  name = "${var.project_name}-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# 1. Real-Time Inference Lambda
resource "aws_lambda_function" "realtime" {
  filename      = "../src/inference.zip" # Placeholder
  function_name = "${var.project_name}-realtime"
  role          = aws_iam_role.lambda.arn
  handler       = "realtime.handler"
  runtime       = "nodejs20.x"
  architectures = ["arm64"]
  memory_size   = 1024
  timeout       = 29

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.main.name
    }
  }
}

# 2. Async Handler (Worker)
resource "aws_lambda_function" "worker" {
  filename      = "../src/async.zip" # Placeholder
  function_name = "${var.project_name}-worker"
  role          = aws_iam_role.lambda.arn
  handler       = "worker.handler"
  runtime       = "nodejs20.x"
  architectures = ["arm64"]
  memory_size   = 1024
  timeout       = 60

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.main.name
    }
  }
}

# SQS Event Source Mapping for Worker
resource "aws_lambda_event_source_mapping" "worker" {
  event_source_arn = aws_sqs_queue.async.arn
  function_name    = aws_lambda_function.worker.arn
  batch_size       = 10
}

# API Gateway Integration for Real-Time
resource "aws_apigatewayv2_integration" "realtime" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.realtime.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_lambda_permission" "api" {
  statement_id  = "AllowAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.realtime.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*/infer"
}
