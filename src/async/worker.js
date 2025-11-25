const { BedrockRuntimeClient, InvokeModelCommand } = require("@aws-sdk/client-bedrock-runtime");
const { logger, tracer, saveResult } = require("../shared/utils");

const bedrock = new BedrockRuntimeClient({});

exports.handler = async (event) => {
  for (const record of event.Records) {
    try {
      const body = JSON.parse(record.body);
      const prompt = body.prompt;
      const requestId = record.messageId;

      logger.info("Processing async job", { requestId, prompt });

      // Invoke Bedrock (Titan Embeddings)
      const input = {
        inputText: prompt
      };

      const command = new InvokeModelCommand({
        modelId: "amazon.titan-embed-text-v1",
        contentType: "application/json",
        accept: "application/json",
        body: JSON.stringify(input)
      });

      const response = await bedrock.send(command);
      const responseBody = JSON.parse(new TextDecoder().decode(response.body));
      const embedding = responseBody.embedding;

      // Save to DynamoDB
      await saveResult(`USER#${body.userId || 'anon'}`, `EMBEDDING#${Date.now()}`, {
        GSI1PK: "MODEL#TITAN-EMBED",
        GSI1SK: requestId,
        prompt,
        embedding // Note: This might be large, consider S3 for prod
      });

      logger.info("Job completed", { requestId });

    } catch (error) {
      logger.error("Job failed", error);
      // SQS will retry automatically
      throw error; 
    }
  }
};
