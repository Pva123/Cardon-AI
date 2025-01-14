import 'package:flutter/material.dart';

class CardonAIApp extends StatelessWidget {
  const CardonAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CARDON-AI'),
        ),
        body: const Row(
          children: [
            Text('About'),
            Text('Team'),
            Text('Contact'),
          ],
        ),
      ),
    );
  }
}
