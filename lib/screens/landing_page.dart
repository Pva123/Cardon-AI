import 'package:flutter/material.dart';
import '../widgets/nav_button.dart';
import '../widgets/faq_item.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SelectionArea(
          // Wrap the entire page with SelectionArea
          child: Column(
            children: [
              _buildNavBar(context),
              _buildHeaderSection(),
              _buildAboutSection(),
              _buildTeamSection(),
              _buildContactSection(),
              _buildFAQSection(),
            ],
          ),
        ),
      ),
    );
  }

  /// Navbar with logo, navigation links, and Sign Up / Log In buttons
  Widget _buildNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo Section: Adjusted size for CARDON AI logo
          Row(
            children: [
              Image.asset(
                'assets/images/CARDON_AI_Logo.png',
                height: 30, // Reduced size from 40 to 30
              ),
            ],
          ),
          // Navigation Links and Buttons
          Row(
            children: [
              NavButton(label: 'About', onPressed: () {}),
              const SizedBox(width: 8),
              NavButton(label: 'Team', onPressed: () {}),
              const SizedBox(width: 8),
              NavButton(label: 'Contact Us', onPressed: () {}),
              const SizedBox(width: 8),
              NavButton(label: 'FAQ', onPressed: () {}),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text('Sign Up'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.orange),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text(
                  'Log In',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Header Section
  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Cardon-AI: The Assistant That Simplifies Your Life ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/images/calender_light_mode.png',
                height: 52, // Adjust the size to match the text
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // MacBook Content
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/macbook_icon.png',
                    height: 300,
                  ),
                  Image.asset(
                    'assets/images/image_inside_macbook.png',
                    height: 250,
                  ),
                ],
              ),
              const SizedBox(width: 24), // Space between MacBook and iPhone
              // iPhone Content
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/iphone_icon.png',
                    height: 150,
                  ),
                  Image.asset(
                    'assets/images/image_inside_iphone.png',
                    height: 125,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Contact Us Section
  Widget _buildContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SelectionArea(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  enableInteractiveSelection: true, // Ensures text selection
                  textInputAction: TextInputAction.done, // Smooth interaction
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  enableInteractiveSelection: true, // Ensures text selection
                  textInputAction: TextInputAction.done, // Smooth interaction
                ),
                const SizedBox(height: 16),
                TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                  ),
                  enableInteractiveSelection: true, // Ensures text selection
                  textInputAction: TextInputAction.newline, // For multiline
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  /// About Section
  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          const Text(
            'About Us',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'It all started with ✨\n“What if we wrote our own weekly schedule and planner 📆”\nNow Cardon-AI can not only help you manage your entire week, it can even act as your personal assistant and pomodoro Timer.🤖',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Team Section
  Widget _buildTeamSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          const Text(
            'Our Team',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Meet the talented individuals behind Cardon-AI.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// FAQ Section
  Widget _buildFAQSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'FAQ',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          FaqItem(
            question: 'What is even Cardon-AI 🧐?',
            answer: 'Cardon-AI is your personal assistant that helps plan, '
                'schedule, and organize your tasks for the week.',
          ),
          const Divider(),
          FaqItem(
            question: 'How can Cardon-AI help me? 🤖',
            answer:
                'It simplifies your day-to-day routine by automatically planning '
                'and managing your schedule, sending reminders, and more.',
          ),
          const Divider(),
          FaqItem(
            question: 'What features Cardon-AI has? 🔧',
            answer:
                'Appointment scheduling, task management, reminders, and more. '
                'New features are added regularly!',
          ),
        ],
      ),
    );
  }
}
