# Security Posture

## Identity & Access Management (IAM)
- **Least Privilege**: Each Lambda has a dedicated role with scoped permissions (e.g., `bedrock:InvokeModel` only for specific models).
- **No Wildcards**: Policies avoid `*` actions on resources.

## Data Protection
- **Encryption at Rest**: DynamoDB, S3, and SQS encrypted with AWS KMS (Customer Managed Keys optional).
- **Encryption in Transit**: TLS 1.2+ enforced on API Gateway and all AWS SDK calls.

## Input Validation
- **API Gateway**: Request validation models ensure payload structure.
- **Sanitization**: Lambda functions sanitize inputs before passing to models to prevent injection attacks.

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
