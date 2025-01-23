import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'login_page.dart';
import 'cardon_auth_pages.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const CardonLoginPage(),
        '/signup': (context) => const CardonSignUpPage(),
        '/forgot-password': (context) => const CardonForgotPasswordPage(),
      },
    );
  }
}
