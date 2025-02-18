import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleAIService {
  final String apiKey =
      "AIzaSyC1sgOwvENwgevqVmKsjEdUO78x9mszFIE"; // Replace with your API key

  Future<String> askAI(String query) async {
    final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateText?key=$apiKey");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "prompt": {"text": query},
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["candidates"][0]["output"];
    } else {
      throw Exception("AI request failed: ${response.body}");
    }
  }
}
