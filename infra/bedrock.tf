# Bedrock is a managed service, no resource provisioning needed usually.
# However, we can track model access logging here.

resource "aws_cloudwatch_log_group" "bedrock" {
  name = "/aws/bedrock/${var.project_name}"
}
