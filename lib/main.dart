import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'screens/Minimal_Page.dart';

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
      home: const MinimalPage(),
    );
  }
}
