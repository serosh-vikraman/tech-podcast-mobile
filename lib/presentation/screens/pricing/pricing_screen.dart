import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_podcast_mobile/core/theme/app_theme.dart';

class PricingScreen extends ConsumerStatefulWidget {
  const PricingScreen({super.key});

  @override
  ConsumerState<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends ConsumerState<PricingScreen> {
  bool _isYearly = true; // Default to Yearly as per generic "Yearly -15%" badge usually implies preference

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Match the dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Pricing'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Simple, Transparent Pricing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Choose the plan that fits your podcasting needs.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToggleButton('Monthly', !_isYearly),
                const SizedBox(width: 12),
                _buildToggleButton('Yearly -15%', _isYearly),
              ],
            ),
            const SizedBox(height: 32),

            // Pricing Cards
            // Using PageView for mobile-friendly swiping of cards
            SizedBox(
              height: 750, // Height to fit the tall cards
              child: PageView(
                controller: PageController(viewportFraction: 0.85),
                padEnds: true,
                children: [
                  _PricingCard(
                    title: 'Starter',
                    price: _isYearly ? '\$59.99' : '\$5.99',
                    period: _isYearly ? '/yr' : '/mo',
                    features: const [
                      '1 Hour/mo generation',
                      'Access to All Shows',
                      'Interview Twin',
                      'GitHub Explainer',
                      'Architecture Visuals',
                      'JD Decoder',
                      "The Recruiter's Eye",
                      'Tech Stack Battle',
                      'The Dojo (Roleplay)',
                      'Standard Generation Priority',
                    ],
                    isPopular: false,
                    buttonText: 'Get Started',
                    onTap: () {},
                  ),
                  _PricingCard(
                    title: 'Sprint',
                    price: _isYearly ? '\$99.99' : '\$9.99',
                    period: _isYearly ? '/yr' : '/mo',
                    features: const [
                      '3 Hours/mo generation',
                      'Access to All Shows',
                      'Interview Twin',
                      'GitHub Explainer',
                      'Architecture Visuals',
                      'JD Decoder',
                      "The Recruiter's Eye",
                      'Tech Stack Battle',
                      'The Dojo (Roleplay)',
                      'High Priority Generation',
                    ],
                    isPopular: true,
                    buttonText: 'Get Started',
                    onTap: () {},
                  ),
                  _PricingCard(
                    title: 'Career',
                    price: _isYearly ? '\$199.99' : '\$19.99',
                    period: _isYearly ? '/yr' : '/mo',
                    features: const [
                      'Unlimited* generation',
                      'Access to All Shows',
                      'Interview Twin',
                      'GitHub Explainer',
                      'Architecture Visuals',
                      'JD Decoder',
                      "The Recruiter's Eye",
                      'Tech Stack Battle',
                      'The Dojo (Roleplay)',
                      'High Priority Generation',
                      'Priority Support',
                      '*High volume usage may be regulated',
                    ],
                    isPopular: false,
                    buttonText: 'Get Started',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isYearly = text.contains('Yearly');
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1F2937) : Colors.transparent, // Dark grey for selected
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: Colors.grey.withOpacity(0.3)) : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final List<String> features;
  final bool isPopular;
  final String buttonText;
  final VoidCallback onTap;

  const _PricingCard({
    required this.title,
    required this.price,
    required this.period,
    required this.features,
    required this.isPopular,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Purple color from screenshot
    const purpleColor = Color(0xFF8B5CF6);
    final borderColor = isPopular ? purpleColor : const Color(0xFF1F2937);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Padding to account for the "Most Popular" badge sticking out
        Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 8, left: 8, bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: isPopular ? 2 : 1),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16), // Space for badge if present
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      period,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: features.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final feature = features[index];
                      return Row(
                        children: [
                          const Icon(Icons.check_circle, color: Color(0xFF3B4F69), size: 20), // Dark blueish check
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(
                                color: Color(0xFFD1D5DB), // Light grey
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPopular ? purpleColor : const Color(0xFF1F2937),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isPopular)
          Positioned(
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: purpleColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'MOST POPULAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
