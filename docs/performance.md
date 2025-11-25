# Performance Tuning

## Lambda Optimization
- **Memory**: Tuned to 1024MB for optimal CPU/Network performance (Graviton2).
- **Keep-Alive**: TCP Keep-Alive enabled for DynamoDB and Bedrock connections.
- **Cold Starts**: Provisioned Concurrency enabled for the Real-Time Inference function (Min: 5).

## DynamoDB Optimization
- **On-Demand**: Used for unpredictable workloads.
- **Global Tables**: (Optional) For multi-region low latency.

## API Gateway
- **Edge-Optimized**: For global clients.
- **Caching**: Enabled for frequent read-only requests (e.g., getting model list).

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
