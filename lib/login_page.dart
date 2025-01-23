import 'package:flutter/material.dart';
import 'dart:ui';

class CardonLoginPage extends StatefulWidget {
  const CardonLoginPage({super.key});

  @override
  State<CardonLoginPage> createState() => _CardonLoginPageState();
}

const LinearGradient goldGradient = LinearGradient(
  colors: [
    Color(0xFFFFD700), // Gold color
    Color(0xFFFFA500), // Orange-gold color
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class _CardonLoginPageState extends State<CardonLoginPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B15),
      body: Stack(
        children: [
          // Premium gradient background
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.8,
                colors: [
                  const Color(0xFF1A2636).withOpacity(0.15),
                  const Color(0xFF050B15),
                ],
              ),
            ),
          ),
          
          // Subtle animated gradient overlay
          Positioned(
            top: -250,
            right: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFAFBBD3).withOpacity(0.03),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Premium navigation bar
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.05),
                            Colors.white.withOpacity(0.02),
                          ],
                        ),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Premium logo styling
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                const Color(0xFFFAF9F6),
                                const Color(0xFFFAF9F6).withOpacity(0.8),
                              ],
                            ).createShader(bounds),
                            child: const Text(
                              'cardon',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Colors.grey[400]!,
                                Colors.grey[400]!.withOpacity(0.8),
                              ],
                            ).createShader(bounds),
                            child: const Text(
                              '-AI',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          const Spacer(),
                          _buildNavButton('About'),
                          _buildNavButton('Team'),
                          _buildNavButton('Contact Us'),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Main Content
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(24),
                        constraints: const BoxConstraints(maxWidth: 400),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.05),
                              Colors.white.withOpacity(0.02),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 30,
                              spreadRadius: -5,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Premium text styling
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  const Color(0xFFFAF9F6),
                                  const Color(0xFFFAF9F6).withOpacity(0.9),
                                ],
                              ).createShader(bounds),
                              child: const Text(
                                'No need to think,',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Colors.grey[400]!,
                                  Colors.grey[400]!.withOpacity(0.8),
                                ],
                              ).createShader(bounds),
                              child: Text(
                                "what's upcoming next.",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            
                            // Premium toggle button
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(0.07),
                                    Colors.white.withOpacity(0.04),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildToggleButton('Sign up', !isLogin),
                                  _buildToggleButton('Log in', isLogin),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            
                            // Social login buttons with premium styling
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _socialLoginButton('G'),
                                const SizedBox(width: 16),
                                _socialLoginButton('A'),
                              ],
                            ),
                            const SizedBox(height: 40),
                            
                            _buildTextField('Email'),
                            const SizedBox(height: 16),
                            _buildTextField('Password', isPassword: true),
                            const SizedBox(height: 16),
                            
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: const Color(0xFFFAF9F6).withOpacity(0.6),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLogin = text == 'Log in';
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          gradient: isSelected ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.15),
              Colors.white.withOpacity(0.1),
            ],
          ) : null,
          borderRadius: BorderRadius.circular(25),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: -2,
            ),
          ] : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: const Color(0xFFFAF9F6).withOpacity(isSelected ? 1 : 0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
            color: const Color(0xFFFAF9F6).withOpacity(0.6),
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(
          color: Color(0xFFFAF9F6),
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: const Color(0xFFFAF9F6).withOpacity(0.4),
            fontWeight: FontWeight.w300,
          ),
          fillColor: Colors.white.withOpacity(0.05),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton(String label) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.07),
            Colors.white.withOpacity(0.04),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFFFAF9F6).withOpacity(0.7),
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}