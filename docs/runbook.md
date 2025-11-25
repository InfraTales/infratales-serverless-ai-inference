# Operational Runbook

## Deployment
1. **Validate**: Run `npm test` to execute unit tests.
2. **Plan**: Run `terraform plan` to check for infrastructure changes.
3. **Apply**: Run `terraform apply` to deploy updates.

## Monitoring
- **Dashboards**: Check the "AI Inference Overview" dashboard in CloudWatch daily.
- **Alarms**: Watch for "HighErrorRate" (>1%) and "HighLatency" (>2s).

## Incident Response
### Scenario: High Latency
1. Check **Bedrock Metrics**: Is the model throttling?
2. Check **Lambda Duration**: Is the function timing out?
3. **Action**: If Bedrock is throttling, request a quota increase or switch to a backup model region.

### Scenario: Failed Async Jobs
1. Check **DLQ**: Inspect the SQS Dead Letter Queue.
2. **Redrive**: Fix the payload issue and redrive the message to the main queue.

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
