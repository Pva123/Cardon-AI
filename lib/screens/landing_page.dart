import 'login_page.dart';
import 'package:flutter/material.dart';
import '../widgets/nav_button.dart';
import '../styles/app_typography.dart';

// Make themeNotifier a global variable to persist between page navigations
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          
          // Light Theme Configuration
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.black,
            colorScheme: const ColorScheme.light(
              primary: Colors.grey,
              secondary: Colors.blue,
              background: Colors.white,
              surface: Colors.white,
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black),
              bodySmall: TextStyle(color: Colors.black87),
              titleLarge: TextStyle(color: Colors.black),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          
          // Dark Theme Configuration
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0D1117),
            primaryColor: Colors.grey[400],
            colorScheme: ColorScheme.dark(
              primary: Colors.grey[400]!,
              secondary: Colors.grey[600]!,
              background: Colors.grey[900]!,
              surface: Colors.grey[800]!,
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Color(0xFFF0F6FC)),
              bodyMedium: TextStyle(color: Color(0xFFF0F6FC)),
              bodySmall: TextStyle(color: Color(0xFFC9D1D9)),
              titleLarge: TextStyle(color: Color(0xFFF0F6FC)),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 79, 90, 99),
                foregroundColor: const Color(0xFF0D1117),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              fillColor: Color(0xFF161B22),
              labelStyle: TextStyle(color: Color(0xFFC9D1D9)),
            ),
            dividerColor: const Color(0xFF30363D),
          ),
          
          // Set the current theme
          themeMode: currentTheme,
          
          home: const LandingPageContent(),
        );
      },
    );
  }
}

class LandingPageContent extends StatefulWidget {
  const LandingPageContent({super.key});

  @override
  State<LandingPageContent> createState() => _LandingPageContentState();
}

class _LandingPageContentState extends State<LandingPageContent> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              _buildNavBar(context),
              _buildHeroSection(context),
              _buildFeaturesSection(context),
              _buildAboutSection(context),
              _buildTestimonialsSection(context),
              _buildContactSection(context),
              _buildFooterSection(context),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildNavBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      color: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Icon(
                Icons.assistant_rounded,
                color: isDark ? Colors.grey[400] : Colors.grey,
                size: 32,
              ),
              const SizedBox(width: 8),
              Text(
                'Cardon-AI',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          
          // Navigation Links & Theme Toggle
          Row(
            children: [
              // Navigation Links
              _buildNavLink(context, 'Home', () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }),
              _buildNavLink(context, 'Features', () {
                // Scroll to features section
              }),
              _buildNavLink(context, 'About', () {
                // Scroll to about section
              }),
              _buildNavLink(context, 'Contact', () {
                // Scroll to contact section
              }),
              
              const SizedBox(width: 16),
              
              // Theme Toggle Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Toggle between light and dark
                    themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF30363D) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                        color: isDark ? Colors.blueGrey : Colors.blueGrey[800],
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to login page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? const Color.fromARGB(255, 79, 90, 99) : Colors.grey,
                  foregroundColor: isDark ? Colors.black : Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text('Login'),
              ),
              
              const SizedBox(width: 8),
              
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to signup page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? const Color(0xFF58A6FF) : Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavLink(BuildContext context, String title, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeroSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark 
            ? [const Color(0xFF1B222C), const Color(0xFF0D1117)]
            : [Colors.grey.shade50, Colors.white],
        ),
      ),
      child: Stack(
        children: [
          // Background Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                painter: GridPainter(isDark: isDark),
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Text Column
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your Intelligent\nPersonal Assistant',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Cardon-AI helps you manage your schedule, stay productive, and accomplish more with less stress.',
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          color: isDark ? Colors.grey[300] : Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Get Started action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark ? const Color.fromARGB(255, 79, 90, 99) : Colors.grey,
                              foregroundColor: isDark ? Colors.black : Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: const Text('Get Started'),
                          ),
                          const SizedBox(width: 16),
                          TextButton.icon(
                            onPressed: () {
                              // Watch Demo action
                            },
                            icon: Icon(
                              Icons.play_circle_outline,
                              color: isDark ? const Color(0xFF58A6FF) : Colors.blue,
                            ),
                            label: Text(
                              'Watch Demo',
                              style: TextStyle(
                                color: isDark ? const Color(0xFF58A6FF) : Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 48),
                
                // Right Image Column
                Expanded(
                  flex: 4,
                  child: _buildHeroImage(isDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHeroImage(bool isDark) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Shadow or background glow
        Container(
          height: 350,
          width: 350,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: isDark 
                ? [const Color(0xFF58A6FF).withOpacity(0.2), Colors.transparent]
                : [Colors.grey.withOpacity(0.2), Colors.transparent],
              stops: const [0.2, 1.0],
            ),
          ),
        ),
        
        // Main background circle
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark 
                ? [const Color(0xFF1B222C), const Color(0xFF0D1117)]
                : [Colors.white, Colors.grey.shade200],
            ),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black.withOpacity(0.5) : Colors.grey.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
        ),
        
        // Icon in the center
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark 
                ? [const Color.fromARGB(255, 79, 90, 99), const Color.fromARGB(255, 32, 64, 91)]
                : [Colors.grey, Colors.grey.shade800],
            ),
            boxShadow: [
              BoxShadow(
                color: isDark ? const Color.fromARGB(255, 79, 90, 99).withOpacity(0.3) : Colors.grey.withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Icon(
            Icons.assistant_rounded,
            size: 80,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
  
  Widget _buildFeaturesSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final features = [
      {
        'icon': Icons.schedule_rounded,
        'title': 'Smart Scheduling',
        'description': 'Automatically organize your weekly schedule with AI assistance.'
      },
      {
        'icon': Icons.timer_rounded,
        'title': 'Pomodoro Timer',
        'description': 'Stay productive with built-in Pomodoro technique timers.'
      },
      {
        'icon': Icons.smart_toy_rounded,
        'title': 'AI Assistant',
        'description': 'Get personalized recommendations and help managing tasks.'
      },
      {
        'icon': Icons.bar_chart_rounded,
        'title': 'Progress Tracking',
        'description': 'Visualize your productivity and track task completion over time.'
      },
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      color: isDark ? const Color(0xFF0D1117) : Colors.white,
      child: Column(
        children: [
          Text(
            'Features',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Powerful tools to boost your productivity',
            style: TextStyle(
              fontSize: 18,
              color: isDark ? Colors.grey[300] : Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features.map((feature) => 
              Expanded(
                child: _buildFeatureCard(
                  context,
                  icon: feature['icon'] as IconData,
                  title: feature['title'] as String,
                  description: feature['description'] as String,
                ),
              )
            ).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF161B22) : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 48,
              color: isDark ? const Color.fromARGB(255, 79, 90, 99) : Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.grey[300] : Colors.grey[700],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildAboutSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      color: isDark ? const Color(0xFF161B22) : Colors.grey.shade50,
      child: Column(
        children: [
          Text(
            'About Cardon-AI',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side - Team Image
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 350,
                    color: isDark ? const Color(0xFF30363D) : Colors.grey[300],
                    child: Center(
                      child: Text(
                        'Team Photo',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 64),
              
              // Right side - Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Our Story',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'We are four university students who decided to create a calendar, task manager, and Pomodoro tool all in one. Since the beginning, we have been striving for a best-in-class service.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        color: isDark ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'It is designed to help students and people like us stay organized and productive, with powerful features to make managing tasks easier and more efficient.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        color: isDark ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        _buildTeamMember(context, 'Arman', Icons.person),
                        const SizedBox(width: 16),
                        _buildTeamMember(context, 'Mahyar', Icons.person),
                        const SizedBox(width: 16),
                        _buildTeamMember(context, 'Parsa', Icons.person),
                        const SizedBox(width: 16),
                        _buildTeamMember(context, 'Henrique', Icons.person),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTeamMember(BuildContext context, String name, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: isDark ? const Color(0xFF30363D) : Colors.grey[300],
          child: Icon(
            icon,
            size: 32,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
  
  Widget _buildTestimonialsSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final testimonials = [
      {
        'text': 'Cardon-AI has completely changed how I manage my busy schedule. The AI suggestions are surprisingly accurate!',
        'author': 'Sarah J.',
        'role': 'Graduate Student'
      },
      {
        'text': 'The Pomodoro feature helps me stay focused during long study sessions. I\'ve never been more productive.',
        'author': 'Michael T.',
        'role': 'Software Developer'
      },
      {
        'text': 'I love how intuitive the interface is. Everything just makes sense, and the dark mode is easy on the eyes!',
        'author': 'Alex W.',
        'role': 'Project Manager'
      },
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      color: isDark ? const Color(0xFF0D1117) : Colors.white,
      child: Column(
        children: [
          Text(
            'What Our Users Say',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 64),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: testimonials.map((testimonial) => 
              Expanded(
                child: _buildTestimonialCard(
                  context,
                  text: testimonial['text'] as String,
                  author: testimonial['author'] as String,
                  role: testimonial['role'] as String,
                ),
              )
            ).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTestimonialCard(
    BuildContext context, {
    required String text,
    required String author,
    required String role,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161B22) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: isDark ? const Color(0xFF30363D) : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.format_quote,
              size: 36,
              color: isDark ? const Color.fromARGB(255, 79, 90, 99) : Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                height: 1.8,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: isDark ? const Color(0xFF30363D) : Colors.grey[200],
                  child: Icon(
                    Icons.person,
                    color: isDark ? Colors.white : Colors.black,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      author,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      role,
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildContactSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      color: isDark ? const Color(0xFF161B22) : Colors.grey.shade50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Form Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Have questions or feedback? We\'d love to hear from you!',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 32),
                _buildTextField(context, 'Name', Icons.person),
                const SizedBox(height: 16),
                _buildTextField(context, 'Email', Icons.email),
                const SizedBox(height: 16),
                _buildTextField(context, 'Message', Icons.message, maxLines: 5),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Submit form
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? const Color.fromARGB(255, 79, 90, 99) : Colors.grey,
                    foregroundColor: isDark ? Colors.black : Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Send Message'),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 64),
          
          // Right Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visit Us',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                _buildContactInfo(
                  context,
                  icon: Icons.email,
                  title: 'Email',
                  info: 'contact@cardon-ai.com',
                ),
                const SizedBox(height: 24),
                _buildContactInfo(
                  context,
                  icon: Icons.phone,
                  title: 'Phone',
                  info: '+1 (647) 123-4567',
                ),
                const SizedBox(height: 24),
                _buildContactInfo(
                  context,
                  icon: Icons.location_on,
                  title: 'Address',
                  info: '123 AI Drive\nToronto, ON M5V 1A1\nCanada',
                ),
                const SizedBox(height: 48),
                Text(
                  'Connect With Us',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildSocialIcon(context, Icons.facebook),
                    const SizedBox(width: 16),
                    _buildSocialIcon(context, Icons.telegram),
                    const SizedBox(width: 16),
                    
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTextField(
    BuildContext context,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
        filled: true,
        fillColor: isDark ? const Color(0xFF0D1117) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF30363D) : Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? const Color(0xFF30363D) : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? const Color.fromARGB(255, 79, 90, 99) : Colors.grey,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
    );
  }
  
  Widget _buildContactInfo(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String info,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0D1117) : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isDark ? const Color.fromARGB(255, 79, 90, 99) : Colors.grey,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              info,
              style: TextStyle(
                color: isDark ? Colors.grey[300] : Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildSocialIcon(BuildContext context, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0D1117) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF30363D) : Colors.grey.shade200,
        ),
      ),
      child: Icon(
        icon,
        color: isDark ? Colors.grey[400] : Colors.grey,
      ),
    );
  }
  
  Widget _buildFooterSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
      color: isDark ? const Color(0xFF0D1117) : Colors.white,
      child: Column(
        children: [
          const Divider(color: Colors.grey),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2025 Cardon-AI. All rights reserved.',
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Terms of Service',
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
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

class GridPainter extends CustomPainter {
  final bool isDark;
  
  GridPainter({required this.isDark});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? Colors.grey[800]! : Colors.grey[800]!
      ..strokeWidth = 1;
    
    const spacing = 30.0;
    
    for (var i = 0; i < size.width.toInt(); i += spacing as int) {
      canvas.drawLine(
        Offset(i as double, 0),
        Offset(i as double, size.height),
        paint,
      );
    }
    
    for (var i = 0; i < size.height; i += spacing as int) {
      canvas.drawLine(
        Offset(0, i as double),
        Offset(size.width, i as double),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}