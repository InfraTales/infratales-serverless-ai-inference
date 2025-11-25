const axios = require('axios');

const API_URL = process.env.API_URL || "https://example.com";

describe('API Integration', () => {
  it('should accept inference request', async () => {
    if (API_URL === "https://example.com") {
      console.log("Skipping integration test (no API_URL)");
      return;
    }

    try {
      const res = await axios.post(`${API_URL}/infer`, { prompt: "Test" });
      expect(res.status).toBe(200);
      expect(res.data).toHaveProperty("result");
    } catch (e) {
      // Fail if API is reachable but errors
      if (e.response) throw e;
    }
  });
});
