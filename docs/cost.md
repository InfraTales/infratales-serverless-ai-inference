# Cost Analysis

## Monthly Estimate (50k req/min peak, 1M req/month avg)

| Service | Configuration | Cost (₹) |
|:---|:---|:---|
| **Lambda** | 128MB ARM, 1M invocations | ₹200 |
| **API Gateway** | REST API, 1M requests | ₹280 |
| **DynamoDB** | On-Demand (Write heavy) | ₹500 |
| **Bedrock** | Titan Text (Input/Output tokens) | ₹2,500 |
| **SageMaker** | Serverless Inference (Sporadic) | ₹1,000 |
| **CloudWatch** | Logs (Ingestion + Storage) | ₹800 |
| **Data Transfer** | Outbound | ₹200 |
| **Total** | | **~₹5,480** |

## Optimization Strategies
1. **ARM Architecture**: Switched all Lambdas to Graviton2 (20% savings).
2. **Log Retention**: Set CloudWatch Logs retention to 7 days.
3. **DynamoDB TTL**: Auto-delete old inference records after 30 days.

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
