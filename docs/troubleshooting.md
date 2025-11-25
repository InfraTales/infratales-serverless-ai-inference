# Troubleshooting Guide

| Symptom | Probable Cause | Fix |
|:---|:---|:---|
| **ThrottlingException** | Bedrock quota exceeded | Implement exponential backoff or request quota increase. |
| **504 Gateway Timeout** | Lambda took > 29s | Optimize model inference or switch to Async Mode. |
| **ProvisionedThroughputExceeded** | DynamoDB hot partition | Review partition key strategy or enable Auto Scaling. |
| **AccessDenied** | IAM Role missing permission | Check CloudTrail for failed API calls and update IAM policy. |

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
