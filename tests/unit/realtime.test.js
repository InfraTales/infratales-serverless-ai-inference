const { handler } = require('../../src/inference/realtime');
const { BedrockRuntimeClient, InvokeModelCommand } = require("@aws-sdk/client-bedrock-runtime");
const { mockClient } = require("aws-sdk-client-mock");

const bedrockMock = mockClient(BedrockRuntimeClient);

describe('RealTime Inference', () => {
  beforeEach(() => {
    bedrockMock.reset();
  });

  it('should return inference result', async () => {
    bedrockMock.on(InvokeModelCommand).resolves({
      body: new TextEncoder().encode(JSON.stringify({
        results: [{ outputText: "Hello world" }]
      }))
    });

    const event = {
      body: JSON.stringify({ prompt: "Hi" }),
      requestContext: { requestId: "123" }
    };

    const response = await handler(event);
    const body = JSON.parse(response.body);

    expect(response.statusCode).toBe(200);
    expect(body.result).toBe("Hello world");
  });
});
