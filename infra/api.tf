resource "aws_apigatewayv2_api" "main" {
  name          = "${var.project_name}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "prod" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "prod"
  auto_deploy = true
  
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api.arn
    format          = jsonencode({
      requestId = "$context.requestId"
      ip        = "$context.identity.sourceIp"
      status    = "$context.status"
      latency   = "$context.responseLatency"
    })
  }
}

resource "aws_cloudwatch_log_group" "api" {
  name              = "/aws/apigateway/${var.project_name}-api"
  retention_in_days = 7
}

# Routes
resource "aws_apigatewayv2_route" "infer" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /infer"
  target    = "integrations/${aws_apigatewayv2_integration.realtime.id}"
}

resource "aws_apigatewayv2_route" "async" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /async"
  target    = "integrations/${aws_apigatewayv2_integration.async.id}"
}

resource "aws_apigatewayv2_route" "chain" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /chain"
  target    = "integrations/${aws_apigatewayv2_integration.chain.id}"
}
