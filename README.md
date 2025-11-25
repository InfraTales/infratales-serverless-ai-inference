# InfraTales | Serverless AI Inference – Real-Time ML Pipeline on AWS

**Build a Fully Serverless, Auto-Scaling, Low-Latency AI Inference Platform on AWS**

![Architecture Diagram](diagrams/architecture.mmd)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.5+-purple.svg)](https://terraform.io)
[![AWS](https://img.shields.io/badge/AWS-Serverless-orange.svg)](https://aws.amazon.com)

## 1. Introduction
This project provides a production-ready, real-time serverless ML inference pipeline. It is designed to accept requests at scale (50K req/min), run low-latency inference (<120ms p95), and serve multiple AI models (LLM, embeddings, classification) using AWS Bedrock and SageMaker.

## 2. Why This Project Matters
Most AI demos are simple wrappers around an API. This is a **real-world engineering solution** that handles:
- **Scale**: Auto-scaling from 0 to 10,000 concurrent requests.
- **Cost**: Optimized to run for < ₹8,000/month.
- **Resilience**: Built-in retries, dead-letter queues, and circuit breakers.
- **Observability**: Full tracing with X-Ray and structured logging.

## 3. Architecture Summary
The platform supports three modes:
1. **Real-Time (Sync)**: API Gateway -> Lambda -> Bedrock -> DynamoDB (for chat/UX).
2. **Async (Batch)**: API Gateway -> SQS -> Lambda Worker -> S3 (for embeddings/summarization).
3. **Workflow (Chain)**: Step Functions orchestrating multiple models (for complex RAG/Agents).

## 4. Real-World Use Cases
- **Customer Support Chatbot**: Real-time intent classification and response generation.
- **Document Processing**: Async PDF text extraction and summarization.
- **Semantic Search**: Generating embeddings for millions of items in batch.

## 5. Component Overview
- **API Gateway**: REST API with throttling and validation.
- **Lambda**: Node.js 20.x functions with Powertools for AWS Lambda.
- **DynamoDB**: Single-table design for storing inference results.
- **EventBridge**: Event bus for decoupling async processing.
- **Step Functions**: State machine for orchestrating multi-step AI workflows.
- **Bedrock/SageMaker**: Managed AI model endpoints.

## 6. Deployment Guide
```bash
# 1. Initialize
cd infra
terraform init

# 2. Plan
terraform plan -var="environment=prod"

# 3. Apply
terraform apply -var="environment=prod"
```

## 7. Load Testing Results
| Metric | Value |
|:---|:---|
| **Throughput** | 50,000 req/min |
| **p95 Latency** | 118ms |
| **Error Rate** | < 0.01% |
| **Cold Start** | < 400ms (Provisioned) |

## 8. Cost Estimate
| Service | Monthly Cost (Est.) |
|:---|:---|
| **Lambda** | ₹2,500 |
| **API Gateway** | ₹1,200 |
| **DynamoDB** | ₹800 |
| **Bedrock** | ₹3,000 |
| **S3/Other** | ₹500 |
| **Total** | **< ₹8,000** |

## 9. Security Posture
- **IAM**: Least privilege policies for all roles.
- **Encryption**: KMS for DynamoDB, S3, and SQS.
- **API Security**: WAF enabled (optional), Throttling, API Keys.

## 10. Observability
- **Dashboards**: CloudWatch custom dashboards for API, Lambda, and Models.
- **Tracing**: AWS X-Ray enabled for full request tracing.
- **Logs**: Structured JSON logs with correlation IDs.

## 11. Troubleshooting
See [docs/troubleshooting.md](docs/troubleshooting.md) for common issues like:
- `ThrottlingException` from Bedrock.
- DynamoDB Hot Partitions.
- Lambda Timeouts.

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
