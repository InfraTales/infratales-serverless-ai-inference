# Placeholder for SageMaker Serverless Inference
# Requires a model artifact in S3 and ECR image.
# We will define the structure but comment it out to avoid deployment errors without artifacts.

/*
resource "aws_sagemaker_model" "model" {
  name               = "${var.project_name}-model"
  execution_role_arn = aws_iam_role.sagemaker.arn
  primary_container {
    image = "763104351884.dkr.ecr.us-east-1.amazonaws.com/pytorch-inference:1.8.0-cpu-py3"
  }
}

resource "aws_sagemaker_endpoint_config" "config" {
  name = "${var.project_name}-config"
  production_variants {
    variant_name           = "AllTraffic"
    model_name             = aws_sagemaker_model.model.name
    serverless_config {
      max_concurrency = 10
      memory_size_in_mb = 2048
    }
  }
}

resource "aws_sagemaker_endpoint" "endpoint" {
  name                 = "${var.project_name}-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_config.config.name
}
*/
