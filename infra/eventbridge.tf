resource "aws_cloudwatch_event_bus" "main" {
  name = "${var.project_name}-bus"
}

resource "aws_cloudwatch_event_rule" "inference_completed" {
  name           = "inference-completed"
  event_bus_name = aws_cloudwatch_event_bus.main.name
  event_pattern  = jsonencode({
    source      = ["com.infratales.inference"]
    detail-type = ["InferenceCompleted"]
  })
}

# Target (e.g., Log Group for demo)
resource "aws_cloudwatch_log_group" "events" {
  name = "/aws/events/${var.project_name}"
}

resource "aws_cloudwatch_event_target" "logs" {
  rule           = aws_cloudwatch_event_rule.inference_completed.name
  event_bus_name = aws_cloudwatch_event_bus.main.name
  arn            = aws_cloudwatch_log_group.events.arn
}
