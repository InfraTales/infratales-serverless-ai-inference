# Project Overview

## Goal
To build a production-ready, real-time serverless ML inference pipeline that can accept requests at scale, run low-latency inference, and serve multiple AI models while keeping costs under ₹8,000/month.

## Key Features
- **Serverless First**: No EC2 management. 100% Lambda, API Gateway, and managed services.
- **Multi-Model Support**: Seamlessly switch between Bedrock (Titan, Claude) and SageMaker endpoints.
- **Async Processing**: Decoupled architecture for heavy workloads using SQS and EventBridge.
- **Cost Optimized**: Aggressive use of Spot instances (SageMaker), ARM architecture (Lambda), and Intelligent Tiering (S3).

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
