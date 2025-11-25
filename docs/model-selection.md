# Model Selection Strategy

## Option A: AWS Bedrock (Managed)
- **Best for**: General purpose LLM tasks, text generation, embeddings.
- **Models**: Titan Text G1, Titan Embeddings, Claude 3 Haiku.
- **Pros**: Zero infrastructure management, pay-per-token.
- **Cons**: Rate limits, less control over model weights.

## Option B: SageMaker Endpoint (Custom)
- **Best for**: Specialized tasks, fine-tuned models, ultra-low latency requirements.
- **Models**: BERT, ResNet, Custom PyTorch models.
- **Pros**: Full control, consistent latency.
- **Cons**: Higher base cost (unless using Serverless Inference).

## Decision Matrix
| Requirement | Recommended Backend |
|:---|:---|
| **Chatbot / Q&A** | Bedrock (Claude Haiku) |
| **Semantic Search** | Bedrock (Titan Embeddings) |
| **Custom Classification** | SageMaker (Serverless) |

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
