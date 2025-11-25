const { BedrockRuntimeClient, InvokeModelCommand } = require("@aws-sdk/client-bedrock-runtime");
const { logger, tracer, saveResult } = require("../shared/utils");

const bedrock = new BedrockRuntimeClient({});

exports.handler = async (event) => {
  const segment = tracer.getSegment();
  const subsegment = segment.addNewSubsegment("RealTimeInference");
  
  try {
    const body = JSON.parse(event.body);
    const prompt = body.prompt;
    const requestId = event.requestContext.requestId;

    logger.info("Received inference request", { requestId, prompt });

    // Invoke Bedrock (Titan Text)
    const input = {
      inputText: prompt,
      textGenerationConfig: {
        maxTokenCount: 512,
        temperature: 0.7,
        topP: 1,
      }
    };

    const command = new InvokeModelCommand({
      modelId: "amazon.titan-text-express-v1",
      contentType: "application/json",
      accept: "application/json",
      body: JSON.stringify(input)
    });

    const response = await bedrock.send(command);
    const responseBody = JSON.parse(new TextDecoder().decode(response.body));
    const result = responseBody.results[0].outputText;

    // Save to DynamoDB
    await saveResult(`USER#${body.userId || 'anon'}`, `INFERENCE#${Date.now()}`, {
      GSI1PK: "MODEL#TITAN",
      GSI1SK: requestId,
      prompt,
      result
    });

    subsegment.close();

    return {
      statusCode: 200,
      body: JSON.stringify({ result, requestId })
    };

  } catch (error) {
    logger.error("Inference failed", error);
    subsegment.close();
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Internal Server Error" })
    };
  }
};
