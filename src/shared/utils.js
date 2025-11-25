const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, PutCommand } = require("@aws-sdk/lib-dynamodb");
const { Logger } = require("@aws-lambda-powertools/logger");
const { Tracer } = require("@aws-lambda-powertools/tracer");

const logger = new Logger({ serviceName: "serverless-ai" });
const tracer = new Tracer({ serviceName: "serverless-ai" });

const ddbClient = new DynamoDBClient({});
const ddb = DynamoDBDocumentClient.from(ddbClient);

const TABLE_NAME = process.env.TABLE_NAME;

async function saveResult(pk, sk, data) {
  const params = {
    TableName: TABLE_NAME,
    Item: {
      PK: pk,
      SK: sk,
      ...data,
      TTL: Math.floor(Date.now() / 1000) + (30 * 24 * 60 * 60) // 30 days
    }
  };
  await ddb.send(new PutCommand(params));
}

module.exports = { logger, tracer, saveResult };
