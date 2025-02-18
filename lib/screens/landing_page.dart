import 'login_page.dart';
import 'package:flutter/material.dart';
import '../widgets/nav_button.dart';
import '../styles/app_typography.dart'; // Add this import

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  static const TextStyle _emojiStyle = TextStyle(
    fontFamily: 'NotoColorEmoji',
    fontSize: 18,
    height: 1.2,
    letterSpacing: 0.2,
    wordSpacing: 1.0,
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          // ---------------------------
          // Light Theme
          // ---------------------------
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.black,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black),
              bodySmall: TextStyle(color: Colors.black),
              titleLarge: TextStyle(color: Colors.black),
            ),
          ),

          // ---------------------------
          // Dark Theme
          // ---------------------------
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0A0E1A),
            primaryColor: const Color(0xFFFFD700),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFFD700), // Gold
              secondary: Color(0xFF03DAC6),
              background: Color(0xFF0A0E1A),
              surface: Color(0xFF141B2D),
              onBackground: Color(0xFFECECEC),
              onSurface: Color(0xFFECECEC),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              bodySmall: TextStyle(color: Colors.white),
              titleLarge: TextStyle(color: Colors.white),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF141B2D),
              foregroundColor: Colors.white,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFD700),
                foregroundColor: Color(0xFF0A0E1A),
              ),
            ),
          ),

          // Dynamically switch theme
          themeMode: currentTheme,

          home: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildNavBar(context),
                    _buildHeaderSection(),
                    _buildShowcaseSection(),
                    _buildAboutSection(),
                    _buildTeamSection(),
                    _buildContactUsSection(),
                    _buildFAQSection(context),
                    _buildFooterSection(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      // Use the same color as scaffold in dark mode for a seamless look
      color: isDark ? const Color(0xFF0A0E1A) : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Image.asset('assets/images/CARDON_AI_Logo.png', height: 40),
          Row(
            children: [
              // Theme Toggle Button
              Material(
                color: isDark ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {
                    // Toggle between light and dark
                    themeNotifier.value =
                        isDark ? ThemeMode.light : ThemeMode.dark;
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Text(
                      isDark ? '🌞' : '🌙',
                      style: TextStyle(
                        fontSize: 18,
                        color: isDark ? Colors.amber : Colors.white,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CardonLoginPage(),
                    ),
                  );
                },
                isPrimary: true,
              ),
              const SizedBox(width: 8),
              NavButton(
                label: 'Sign Up',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CardonLoginPage(),
                    ),
                  );
                },
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

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
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
                      '"What if we wrote our own weekly schedule and planner ',
                ),
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
          SelectableText(
            'Contact Us',
            style: AppTypography.sectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Name
          _buildTextField('Full Name'),
          const SizedBox(height: 16),

          // Email
          _buildTextField('Email'),
          const SizedBox(height: 16),

          // Message
          _buildTextField('Message', maxLines: 5),
          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: () {
              // Add functionality here
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

  // A helper that adjusts the fill color for dark mode
  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: AppTypography.bodyText.copyWith(
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            filled: true,
            // Dark mode fill vs. light mode fill
            fillColor: isDark ? const Color(0xFF1A1F2A) : Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          style: AppTypography.bodyText.copyWith(
            color: isDark ? Colors.white : Colors.black,
          ),
        );
      },
    );
  }

  // **Updated** to include the three FAQ items
  Widget _buildFAQSection(BuildContext context) {
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
            context,
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
            context,
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
            context,
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

  // **Here is the updated method** with collapsed color settings
  Widget _buildCustomExpansionTile(
    BuildContext context, {
    required Widget title,
    required Widget content,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ExpansionTile(
      title: title,
      // Expanded (open) colors
      textColor: isDark ? Colors.white : Colors.black,
      iconColor: isDark ? Colors.white : Colors.black,
      // Collapsed (closed) colors
      collapsedTextColor: isDark ? Colors.white : Colors.black,
      collapsedIconColor: isDark ? Colors.white : Colors.black,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: content,
        ),
      ],
    );
  }

  Widget _buildFooterSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      // Unify the footer color with the main scaffold in dark mode
      color: isDark ? const Color(0xFF0A0E1A) : Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo + Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Image.asset(
                  'assets/images/Cardon_footer_logo.png',
                  height: 50,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company & Contact Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                'Company',
                                style: AppTypography.sectionTitle.copyWith(
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText.copyWith(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Team '),
                                    TextSpan(
                                        text: '🥇',
                                        style: AppTypography.bodyTextEmoji),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText.copyWith(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                  children: [
                                    const TextSpan(text: 'FAQ '),
                                    TextSpan(
                                        text: '❓',
                                        style: AppTypography.bodyTextEmoji),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText.copyWith(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                  children: [
                                    const TextSpan(text: 'About us '),
                                    TextSpan(
                                        text: '🙋‍♂️',
                                        style: AppTypography.bodyTextEmoji),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Right Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                'Contact Us',
                                style: AppTypography.sectionTitle.copyWith(
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText.copyWith(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text: 'parsa.vafaei@torontomu.ca '),
                                    TextSpan(
                                        text: '✉️',
                                        style: AppTypography.bodyTextEmoji),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText.copyWith(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                  children: [
                                    const TextSpan(text: '647-667-3708 '),
                                    TextSpan(
                                        text: '☎️',
                                        style: AppTypography.bodyTextEmoji),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              SelectableText.rich(
                                TextSpan(
                                  style: AppTypography.bodyText.copyWith(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Online Chat '),
                                    TextSpan(
                                        text: '💬',
                                        style: AppTypography.bodyTextEmoji),
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
          Divider(
            thickness: 1,
            color: isDark ? Colors.white24 : Colors.grey[300],
          ),
          const SizedBox(height: 16),
          // Footer Bottom Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                '©Copyright by Cardon-AI. All rights reserved.',
                style: AppTypography.bodyText.copyWith(
                  fontSize: 12,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              Row(
                children: [
                  SelectableText(
                    'Privacy Policy',
                    style: AppTypography.bodyText.copyWith(
                      fontSize: 12,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 16),
                  SelectableText(
                    'Terms of Use',
                    style: AppTypography.bodyText.copyWith(
                      fontSize: 12,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 16),
                  SelectableText(
                    'Legal',
                    style: AppTypography.bodyText.copyWith(
                      fontSize: 12,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
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