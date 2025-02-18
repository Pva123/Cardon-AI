import { onRequest } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { GoogleGenerativeAI } from "@google/generative-ai";
import * as dotenv from "dotenv";

// Load environment variables from .env file
dotenv.config();

// Initialize Google Gemini AI with API Key
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || "YOUR_GEMINI_API_KEY");

export const askGemini = onRequest(async (req, res) => {
  try {
    logger.info("Received AI request", { structuredData: true });

    const { prompt } = req.body;
    if (!prompt) {
      return res.status(400).json({ error: "Missing 'prompt' in request body" });
    }

    // Get the Gemini AI model
    const model = genAI.getGenerativeModel({ model: "gemini-pro" });

    // Generate response from AI
    const result = await model.generateContent(prompt);
    const response = result.response;

    res.json({
      output: response.text(),
    });
  } catch (error) {
    logger.error("Gemini AI Error:", error);
    res.status(500).json({ error: "Internal Server Error", details: error.message });
  }
});
