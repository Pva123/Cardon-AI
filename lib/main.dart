import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/Minimal_Page.dart';
import 'services/ai_service.dart';
import 'widgets/nav_button.dart'; // Import the nav button widget

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
      home: const AIChatPage(),
    );
  }
}

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

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Gemini AI Assistant"),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Navigation'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NavButton(
                          label: 'AI Chat',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        NavButton(
                          label: 'Landing Page',
                          onPressed: () {
                            Navigator.pop(context);
                            _navigateToPage(context, const LandingPage());
                          },
                        ),
                        NavButton(
                          label: 'Minimal Page',
                          onPressed: () {
                            Navigator.pop(context);
                            _navigateToPage(context, const MinimalPage());
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'Cardon-AI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('AI Chat'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Landing Page'),
              onTap: () {
                Navigator.pop(context);
                _navigateToPage(context, const LandingPage());
              },
            ),
            ListTile(
              title: const Text('Minimal Page'),
              onTap: () {
                Navigator.pop(context);
                _navigateToPage(context, const MinimalPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}