resource "aws_sfn_state_machine" "pipeline" {
  name     = "${var.project_name}-pipeline"
  role_arn = aws_iam_role.sfn.arn

  definition = jsonencode({
    Comment = "AI Inference Pipeline"
    StartAt = "ValidateInput"
    States = {
      ValidateInput = {
        Type = "Pass"
        Next = "ParallelProcessing"
      }
      ParallelProcessing = {
        Type = "Parallel"
        Next = "MergeResults"
        Branches = [
          {
            StartAt = "Summarize"
            States = {
              Summarize = {
                Type = "Task"
                Resource = "arn:aws:states:::bedrock:invokeModel"
                Parameters = {
                  "ModelId": "amazon.titan-text-express-v1"
                  "Body": {
                    "inputText.$": "$.input"
                  }
                }
                End = true
              }
            }
          },
          {
            StartAt = "Sentiment"
            States = {
              Sentiment = {
                Type = "Pass" # Placeholder for another model call
                Result = { "sentiment": "POSITIVE" }
                End = true
              }
            }
          }
        ]
      }
      MergeResults = {
        Type = "Pass"
        End = true
      }
    }
  })
}

resource "aws_iam_role" "sfn" {
  name = "${var.project_name}-sfn-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "states.amazonaws.com" }
    }]
  })
}

# API Gateway Integration for Step Functions (Chain Route)
resource "aws_iam_role" "api_sfn" {
  name = "${var.project_name}-api-sfn-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "apigateway.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "api_sfn" {
  name = "sfn-start"
  role = aws_iam_role.api_sfn.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = "states:StartExecution"
      Effect   = "Allow"
      Resource = aws_sfn_state_machine.pipeline.arn
    }]
  })
}

resource "aws_apigatewayv2_integration" "chain" {
  api_id              = aws_apigatewayv2_api.main.id
  integration_type    = "AWS_PROXY"
  integration_subtype = "StepFunctions-StartExecution"
  credentials_arn     = aws_iam_role.api_sfn.arn
  
  request_parameters = {
    "StateMachineArn" = aws_sfn_state_machine.pipeline.arn
    "Input"           = "$request.body"
  }
}
