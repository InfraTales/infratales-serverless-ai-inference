# Architecture Design

## High-Level Components
1. **API Gateway**: Entry point for all clients. Handles auth, throttling, and validation.
2. **Inference Lambda**: Routes requests to the appropriate model backend (Bedrock or SageMaker).
3. **Async Worker**: Processes background jobs from SQS.
4. **Step Functions**: Orchestrates complex, multi-step AI workflows (e.g., RAG pipelines).
5. **DynamoDB**: Stores inference results and job status with a PK/SK pattern optimized for access.

## Data Flow
- **Real-Time**: Client -> APIGW -> Lambda -> Bedrock -> DDB -> Client
- **Async**: Client -> APIGW -> SQS -> Lambda -> Bedrock -> DDB -> EventBridge

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
