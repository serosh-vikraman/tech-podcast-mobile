import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030712), // Dark App Background
      body: SafeArea(
        child: Stack(
          children: [
            // Background ambient gradients
            Positioned(
              top: -100,
              left: 0,
              right: 0,
              height: 400,
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.8,
                    colors: [
                      const Color(0xFF7C3AED).withOpacity(0.2), // Violet glow
                      const Color(0xFF030712).withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 20),
                // Pill Header
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF2E1065),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFF020617).withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.auto_awesome,
                          size: 14,
                          color: Color(0xFFA78BFA),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Career Studio',
                          style: TextStyle(
                            color: Color(0xFFA78BFA),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // Hero Image (Logo)
                Container(
                  height: 300,
                  width: 300,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo_glow.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const Spacer(flex: 3),

                // Headlines
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                            fontFamily:
                                'Instrument Sans', // If avail, else Default
                          ),
                          children: [
                            TextSpan(
                              text: 'Your Career.\n',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: 'Now Streaming.',
                              style: TextStyle(
                                color: Color(0xFF8B5CF6),
                              ), // Violet
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Face your future before it happens.\nAI Twin-powered podcasts for interviews, decisions, and moments that matter.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF94A3B8), // Slate 400
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 2),

                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => context.go('/login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF6D28D9,
                            ), // Violet 700
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => context.push('/signup'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFA78BFA),
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
