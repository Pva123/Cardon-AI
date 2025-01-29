import 'package:flutter/material.dart';
import '../widgets/nav_button.dart';
import '../styles/app_typography.dart'; // Add this import

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  static const TextStyle _emojiStyle = TextStyle(
    fontFamily: 'NotoColorEmoji',
    fontSize: 18,
    height: 1.2, // Reduced from 1.4
    letterSpacing: 0.2, // Reduced from 0.5
    wordSpacing: 1.0, // Reduced from 2.0
  );

  @override
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white, // Light mode background
            primaryColor: Colors.black, // Light mode primary color
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black), // Light mode text
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black, // Dark mode background
            primaryColor: Colors.white, // Dark mode primary color
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white), // Dark mode text
            ),
          ),
          themeMode: currentTheme, // Dynamically switch theme
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _buildNavBar(context),
                  _buildHeaderSection(),
                  _buildShowcaseSection(),
                  _buildAboutSection(),
                  _buildTeamSection(),
                  _buildContactUsSection(),
                  _buildFAQSection(),
                  _buildFooterSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/CARDON_AI_Logo.png', height: 40),
          Row(
            children: [
              Material(
                color: themeNotifier.value == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {
                    themeNotifier.value = themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Text(
                      themeNotifier.value == ThemeMode.light ? '🌙' : '🌞',
                      style: TextStyle(
                        fontSize: 18,
                        color: themeNotifier.value == ThemeMode.light
                            ? Colors.white // White moon in light mode
                            : Colors.amber, // Yellow sun in dark mode
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              NavButton(label: 'About', onPressed: () {}),
              NavButton(label: 'Team', onPressed: () {}),
              NavButton(label: 'FAQ', onPressed: () {}),
              const SizedBox(width: 16),
              NavButton(
                label: 'Log In',
                onPressed: () {},
                isPrimary: true,
              ),
              const SizedBox(width: 8),
              NavButton(
                label: 'Sign Up',
                onPressed: () {},
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
      child: SelectableText(
        'Cardon-AI: The Assistant That Simplifies Your Life.',
        textAlign: TextAlign.center,
        style: AppTypography.header1,
      ),
    );
  }

  Widget _buildShowcaseSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/macbook_icon.png',
                    height: 250,
                  ),
                  Image.asset(
                    'assets/images/image_inside_macbook.png',
                    height: 220,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 24),
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/iphone_icon.png',
                    height: 220,
                  ),
                  Image.asset(
                    'assets/images/image_inside_iphone.png',
                    height: 200,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFramedImage({
    required String framePath,
    required String innerImagePath,
    required double frameHeight,
    required EdgeInsets innerPadding,
  }) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(framePath, height: frameHeight),
        Padding(
          padding: innerPadding,
          child: Image.asset(innerImagePath, height: frameHeight * 0.7),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 48,
        horizontal: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectableText(
            'About',
            style: AppTypography.sectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SelectableText.rich(
            TextSpan(
              style: AppTypography.bodyText,
              children: [
                const TextSpan(text: 'It all started with '),
                TextSpan(
                  text: '✨',
                  style: AppTypography.bodyTextEmoji,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SelectableText.rich(
            TextSpan(
              style: AppTypography.bodyText,
              children: [
                const TextSpan(
                    text:
                        '"What if we wrote our own weekly schedule and planner '),
                TextSpan(
                  text: '📅',
                  style: AppTypography.bodyTextEmoji,
                ),
                const TextSpan(text: '"'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SelectableText.rich(
            TextSpan(
              style: AppTypography.bodyText,
              children: [
                const TextSpan(
                  text:
                      'Now Cardon-AI can not only help you manage your entire week, it can even act as your personal assistant and Pomodoro Timer.',
                ),
                TextSpan(
                  text: '🤖',
                  style: AppTypography.bodyTextEmoji,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    final teamMembers = [
      {'image': 'assets/images/Arman.png', 'name': 'Arman'},
      {'image': 'assets/images/Mahyar.png', 'name': 'Mahyar'},
      {'image': 'assets/images/Parsa.png', 'name': 'Parsa'},
      {'image': 'assets/images/Henrique.png', 'name': 'Henrique'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectableText(
            'Team',
            style: AppTypography.sectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: teamMembers.map((member) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(member['image']!),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      member['name']!,
                      style: AppTypography.bodyText,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SelectableText(
              'We are four university students who decided to create a calendar, task manager, and Pomodoro tool all in one. Since the beginning, we have been striving for a best-in-class service. It is designed to help students and people like us stay organized and productive, with powerful features to make managing tasks easier and more efficient.',
              style: AppTypography.bodyText,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactUsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section title
          SelectableText(
            'Contact Us',
            style: AppTypography.sectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Full Name Input Field
          TextField(
            decoration: InputDecoration(
              labelText: 'Full Name',
              labelStyle: AppTypography.bodyText,
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Email Input Field
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: AppTypography.bodyText,
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Message Input Field
          TextField(
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Message',
              labelStyle: AppTypography.bodyText,
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Submit Button
          ElevatedButton(
            onPressed: () {
              // Add functionality here (e.g., send the message to the server)
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.orange,
            ),
            child: Text(
              'Submit',
              style: AppTypography.navButton,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectableText(
            'FAQ',
            style: AppTypography.sectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // FAQ 1
          _buildCustomExpansionTile(
            title: RichText(
              text: TextSpan(
                style: AppTypography.bodyText,
                children: [
                  const TextSpan(text: 'What is even Cardon-AI '),
                  TextSpan(text: '🤓', style: AppTypography.bodyTextEmoji),
                  const TextSpan(text: '?'),
                ],
              ),
            ),
            content: SelectableText.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'Cardon-AI is your personal assistant '),
                  TextSpan(text: '🤖', style: AppTypography.bodyTextEmoji),
                  const TextSpan(
                    text:
                        '! You tell Cardon-AI how to make your weekly schedule and squeeze in a last-minute assignment, and it will take care of the rest ',
                  ),
                  TextSpan(text: '😊', style: AppTypography.bodyTextEmoji),
                ],
                style: AppTypography.bodyText,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 16),

          // FAQ 2
          _buildCustomExpansionTile(
            title: RichText(
              text: TextSpan(
                style: AppTypography.bodyText,
                children: [
                  const TextSpan(text: 'How can Cardon-AI help me? '),
                  TextSpan(text: '🧑‍💻', style: AppTypography.bodyTextEmoji),
                ],
              ),
            ),
            content: SelectableText.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text:
                        'Imagine having 2 assignments due this weekend, one presentation to prepare, three coffee chats you recently scheduled, and one family gathering to attend. Give it all to Cardon-AI and ease your mind ',
                  ),
                  TextSpan(text: '🍀', style: AppTypography.bodyTextEmoji),
                ],
                style: AppTypography.bodyText,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 16),

          // FAQ 3
          _buildCustomExpansionTile(
            title: RichText(
              text: TextSpan(
                style: AppTypography.bodyText,
                children: [
                  const TextSpan(text: 'What features does Cardon-AI have? '),
                  TextSpan(text: '⚒️', style: AppTypography.bodyTextEmoji),
                ],
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: '- Pomodoro Timer '),
                      TextSpan(text: '⌛', style: AppTypography.bodyTextEmoji),
                    ],
                    style: AppTypography.bodyText,
                  ),
                ),
                const SizedBox(height: 8),
                SelectableText.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: '- Interactive Personal Assistant '),
                      TextSpan(text: '🤖', style: AppTypography.bodyTextEmoji),
                    ],
                    style: AppTypography.bodyText,
                  ),
                ),
                const SizedBox(height: 8),
                SelectableText.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: '- Progress Bar '),
                      TextSpan(text: '📈', style: AppTypography.bodyTextEmoji),
                    ],
                    style: AppTypography.bodyText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomExpansionTile({
    required Widget title,
    required Widget content,
  }) {
    return ExpansionTile(
      title: title,
      textColor: Colors.black,
      iconColor: Colors.black,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: content,
        ),
      ],
    );
  }

  Widget _buildFooterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the footer
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, -2), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align content to the start
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Footer Logo on the left, slightly higher
              Padding(
                padding:
                    const EdgeInsets.only(top: 4.0), // Adjust the top padding
                child: Image.asset(
                  'assets/images/Cardon_footer_logo.png',
                  height: 50,
                ),
              ),
              const SizedBox(width: 24), // Space between logo and other content

              // Remaining footer content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Column - Company Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                'Company',
                                style: AppTypography.sectionTitle,
                              ),
                              const SizedBox(height: 16),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText,
                                  children: [
                                    const TextSpan(text: 'Team '),
                                    TextSpan(
                                      text: '🥇',
                                      style: AppTypography.bodyTextEmoji,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText,
                                  children: [
                                    const TextSpan(text: 'FAQ '),
                                    TextSpan(
                                      text: '❓',
                                      style: AppTypography.bodyTextEmoji,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText,
                                  children: [
                                    const TextSpan(text: 'About us '),
                                    TextSpan(
                                      text: '🙋‍♂️',
                                      style: AppTypography.bodyTextEmoji,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Right Column - Contact Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                'Contact Us',
                                style: AppTypography.sectionTitle,
                              ),
                              const SizedBox(height: 16),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText,
                                  children: [
                                    const TextSpan(
                                        text: 'parsa.vafaei@torontomu.ca '),
                                    TextSpan(
                                      text: '✉️',
                                      style: AppTypography.bodyTextEmoji,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText,
                                  children: [
                                    const TextSpan(text: '647-667-3708 '),
                                    TextSpan(
                                      text: '☎️',
                                      style: AppTypography.bodyTextEmoji,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText,
                                  children: [
                                    const TextSpan(text: 'Online Chat '),
                                    TextSpan(
                                      text: '💬',
                                      style: AppTypography.bodyTextEmoji,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(thickness: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                '©Copyright by Cardon-AI. All rights reserved.',
                style: AppTypography.bodyText.copyWith(fontSize: 12),
              ),
              Row(
                children: [
                  SelectableText(
                    'Privacy Policy',
                    style: AppTypography.bodyText.copyWith(fontSize: 12),
                  ),
                  const SizedBox(width: 16),
                  SelectableText(
                    'Terms of Use',
                    style: AppTypography.bodyText.copyWith(fontSize: 12),
                  ),
                  const SizedBox(width: 16),
                  SelectableText(
                    'Legal',
                    style: AppTypography.bodyText.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
