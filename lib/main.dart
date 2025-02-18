import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/Minimal_Page.dart';
import 'services/ai_service.dart'; // Import AI service

void main() {
  runApp(const CardonAIApp());
}

class CardonAIApp extends StatelessWidget {
  const CardonAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardon-AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AIChatPage(), // Replaced MinimalPage with AI Chat Page
    );
  }
}

// 🔹 New AI Chat Page
class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  _AIChatPageState createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final GoogleAIService aiService = GoogleAIService();
  final TextEditingController controller = TextEditingController();
  String aiResponse = "Ask me anything!";

  void getAIResponse() async {
    setState(() {
      aiResponse = "Thinking... 🤔";
    });

    try {
      String response = await aiService.askAI(controller.text);
      setState(() {
        aiResponse = response;
      });
    } catch (e) {
      setState(() {
        aiResponse = "⚠️ Error: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Gemini AI Assistant")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Ask Google AI"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: getAIResponse,
              child: const Text("Generate"),
            ),
            const SizedBox(height: 16),
            Text(
              aiResponse,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
