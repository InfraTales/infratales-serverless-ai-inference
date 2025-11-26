# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability, please report it responsibly:

1. **Do not** create a public GitHub issue
2. Email security concerns to the maintainers
3. Provide detailed information about the vulnerability
4. Allow reasonable time for a fix before public disclosure

## Security Best Practices

When using this project:

- Never commit AWS credentials or secrets
- Use IAM roles with least privilege
- Enable CloudTrail for audit logging
- Secure API Gateway endpoints with authentication
- Encrypt model artifacts in S3
- Use VPC endpoints for private access

## Supported Versions

| Version | Supported |
|---------|-----------|
| Latest  | ✅        |
| < 1.0   | ❌        |
