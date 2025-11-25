# Observability Stack

## Metrics (CloudWatch)
- **API Gateway**: `Count`, `Latency`, `4xx`, `5xx`.
- **Lambda**: `Invocations`, `Duration`, `Errors`, `Throttles`.
- **Bedrock**: `InvocationLatency`, `InputTokenCount`, `OutputTokenCount`.
- **DynamoDB**: `ConsumedReadCapacityUnits`, `ConsumedWriteCapacityUnits`.

## Logging
- **Structured JSON**: All Lambdas use `aws-lambda-powertools` to emit JSON logs.
- **Correlation IDs**: `x-correlation-id` is passed through API -> Lambda -> Bedrock -> DDB.

## Tracing
- **AWS X-Ray**: Enabled on all services to visualize the request path and identify bottlenecks.

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
