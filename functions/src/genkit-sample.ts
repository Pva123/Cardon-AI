import {GoogleGenerativeAI} from "@google/generative-ai";
import {onRequest} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import {config} from "firebase-functions";

// Load API Key from Firebase Config
const genAI = new GoogleGenerativeAI(config().gemini.apikey);

export const askGemini = onRequest(async (req, res) => {
  try {
    logger.info("Received AI request");

    const {prompt} = req.body;
    if (!prompt) {
      res.status(400).json({error: "Missing 'prompt' in request body"});
      return;
    }

    // Get Gemini AI model
    const model = genAI.getGenerativeModel({model: "gemini-pro"});

    // Generate response from AI
    const result = await model.generateContent(prompt);
    const response = result.response;

    res.json({output: response.text()});
    return;
  } catch (error: unknown) {
    logger.error("Gemini AI Error:", error);
    res.status(500).json({error: "Internal Server Error", details: error instanceof Error ? error.message : "Unknown error"});
    return;
  }
});
