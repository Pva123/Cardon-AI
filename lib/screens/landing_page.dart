import 'package:flutter/material.dart';
import '../widgets/nav_button.dart';
import '../widgets/faq_item.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNavBar(context),
            _buildHeaderSection(),
            _buildAboutSection(),
            _buildTeamSection(),
            _buildContactSection(context),
            _buildFAQSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo or brand text
          const Text(
            'CARDON-AI',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.orange,
            ),
          ),

          // Navigation buttons
          Row(
            children: [
              NavButton(
                label: 'About',
                onPressed: () {
                  // scroll or navigate to About
                },
              ),
              const SizedBox(width: 10),
              NavButton(
                label: 'Team',
                onPressed: () {
                  // scroll or navigate to Team
                },
              ),
              const SizedBox(width: 10),
              NavButton(
                label: 'Contact',
                onPressed: () {
                  // scroll or navigate to Contact
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Welcome to Cardon-AI',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Placeholder for hero image or additional UI
          Container(
            height: 200,
            color: Colors.orangeAccent.withOpacity(0.2),
            child: const Center(child: Text('Hero Image Placeholder')),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: const [
          Text(
            'About Cardon-AI',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Cardon-AI is an AI-based system designed to simplify your daily scheduling...'
            'and provide automated reminders.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          const Text(
            'Meet Our Team',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // Placeholder for a team image
          Container(
            height: 150,
            color: Colors.deepOrange.withOpacity(0.2),
            child: const Center(child: Text('Team Image Placeholder')),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: messageController,
              decoration: const InputDecoration(labelText: 'Message'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Submit logic
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Send'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          const FaqItem(
            question: 'What is Cardon–AI?',
            answer: 'An AI-based assistant to simplify your daily scheduling.',
          ),
          const Divider(),
          const FaqItem(
            question: 'How does it help?',
            answer: 'It provides automated scheduling, reminders, and more.',
          ),
          const Divider(),
        ],
      ),
    );
  }
}
