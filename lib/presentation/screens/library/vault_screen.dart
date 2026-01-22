import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VaultScreen extends StatefulWidget {
  const VaultScreen({super.key});

  @override
  State<VaultScreen> createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  int _selectedCategoryIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Job Search Fundamentals',
    'Practical Job Hunting Skills',
    'Interview Mastery',
    'Mindset & Motivation',
    'Other',
  ];

  final List<Map<String, dynamic>> _podcasts = [
    {
      'title': 'The 5-Minute Networker: How to Build...',
      'description':
          'Networking usually feels fake, forced, and uncomfortable. But what if you could build a world-class network in just 300 seconds a day? In this...',
      'duration': '15:00',
    },
    {
      'title': '5 LinkedIn Visibility Fixes: Why 90% of...',
      'description':
          'You might be the perfect candidate, but the LinkedIn algorithm is likely screening you out before a human ever sees your name. In this episode, we break dow...',
      'duration': '14:00',
    },
    {
      'title': 'Forget Your Resume: Skills Are the New...',
      'description':
          'Employers aren\'t just looking at degrees or job titles anymore — they want to know what you can actually do. In this episode, we dive into skill-based hiring,...',
      'duration': '11:00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF030712); // Dark background
    const accentColor = Color(0xFF10B981); // Emerald Green for "The Vault"

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'The Vault',
          style: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              const Text(
                'Unlock curated career intelligence. Listen to high-value tech interviews and strategies to gain the unfair advantage in your job search.',
                style: TextStyle(
                  color: Color(0xFF9CA3AF), // Gray 400
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // Horizontal Categories
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (c, i) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedCategoryIndex;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedCategoryIndex = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? accentColor
                              : const Color(0xFF1F2937),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _categories[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Search Bar
              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search podcasts...',
                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF6B7280),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF0F172A), // Darker input bg
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1F2937)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1F2937)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: accentColor, width: 1),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Podcast List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _podcasts.length,
                separatorBuilder: (c, i) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return _buildPodcastCard(_podcasts[index], accentColor);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPodcastCard(Map<String, dynamic> podcast, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A), // Slate 900
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)), // Slate 800
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Play Button & Duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: accentColor,
                  size: 32,
                ),
              ),
              Text(
                podcast['duration'],
                style: const TextStyle(
                  color: Color(0xFF94A3B8), // Slate 400
                  fontSize: 12,
                  fontFamily: 'Monospace', // Give it a techy feel
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Title
          Text(
            podcast['title'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            podcast['description'],
            style: const TextStyle(
              color: Color(0xFF94A3B8), // Slate 400
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
