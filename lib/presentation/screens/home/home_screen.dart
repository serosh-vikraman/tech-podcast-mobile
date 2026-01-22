import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> _studioFeatures = [
    {
      'title': 'The Interview Twin',
      'color': Color(0xFF10B981), // Emerald
      'count': 12,
    },
    {
      'title': 'Nano Learning',
      'color': Color(0xFF8B5CF6), // Violet
      'count': 8,
    },
    {
      'title': 'The JD Decoder',
      'color': Color(0xFFF59E0B), // Amber
      'count': 5,
    },
    {
      'title': 'The Recruiter\'s Eye',
      'color': Color(0xFFA855F7), // Purple
      'count': 7,
    },
    {
      'title': 'Salary Negotiator',
      'color': Color(0xFF10B981), // Emerald
      'count': 3,
    },
    {
      'title': 'Architecture & Strategy',
      'color': Color(0xFFEC4899), // Pink
      'count': 15,
    },
    {
      'title': 'Tech Stack Battle',
      'color': Color(0xFFEF4444), // Red
      'count': 4,
    },
    {
      'title': 'URL to Podcast',
      'color': Color(0xFF3B82F6), // Blue
      'count': 9,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Dark Theme Colors
    const bgColor = Color(0xFF030712); // Rich Dark Navy / Gray 950
    const textPrimary = Color(0xFFF9FAFB); // White

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header
              // 1. Header (Global AppBar used instead)
              // const SizedBox(height: 20),

              // 2. Today's Top 5 Podcasts
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Today's Top 5 Podcasts",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTopPodcastsCarousel(),

              const SizedBox(height: 24),

              // 3. Category Chips
              _buildCategoryChips(),

              const SizedBox(height: 24),

              // 4. Podcast List
              _buildPodcastList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopPodcastsCarousel() {
    // Mock data for carousel
    final items = [
      {
        'title': 'Talk Show Podcast.',
        'subtitle': 'Conversations with Lisa Maclear.',
        'imageColor': Color(0xFFD4D4D8),
        'gradient': [Color(0xFFFDE047), Color(0xFFF9A8D4)],
      },
      {
        'title': 'Writing Podcast Cover.',
        'subtitle': 'with Lucy Ross',
        'imageColor': Color(0xFFFB923C),
        'gradient': [Color(0xFFFB923C), Color(0xFFFDBA74)],
      },
    ];

    return SizedBox(
      height: 180,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (c, i) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: item['gradient'] as List<Color>,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'EPISODE ${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  item['title'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['subtitle'] as String,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _studioFeatures.length,
        separatorBuilder: (c, i) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final feature = _studioFeatures[index];
          final isSelected = index == _selectedCategoryIndex;
          final color = feature['color'] as Color;
          final count = feature['count'] as int;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // Dark surface for unselected
                color: isSelected
                    ? color.withOpacity(0.2)
                    : const Color(0xFF111827),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? color : const Color(0xFF374151),
                ),
              ),
              child: Text(
                '${feature['title']} ($count)',
                style: TextStyle(
                  color: isSelected ? color : const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPodcastList() {
    // Determine current category color for styling
    final currentColor =
        _studioFeatures[_selectedCategoryIndex]['color'] as Color;

    // Mock items
    final items = [
      {'title': 'Enjoy It!', 'subtitle': 'Socially Buzzed', 'dur': '22 min'},
      {'title': 'Grow with Us', 'subtitle': 'Business', 'dur': '12 min'},
      {
        'title': 'Crack the Interview',
        'subtitle': 'Educational',
        'dur': '30 min',
      },
      {'title': 'The Daily Standup', 'subtitle': 'Tech News', 'dur': '15 min'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                // Thumbnail
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: currentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: currentColor.withOpacity(0.3)),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://via.placeholder.com/150',
                      ), // Placeholder
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Icon(Icons.podcasts, color: currentColor, size: 30),
                ),
                const SizedBox(width: 16),

                // Text Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF9FAFB), // White
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle']!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFFD1D5DB), // Light Gray
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['dur']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280), // Muted Gray
                        ),
                      ),
                    ],
                  ),
                ),

                // Play Button
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: currentColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: currentColor.withOpacity(0.3)),
                  ),
                  child: Icon(Icons.play_arrow_rounded, color: currentColor),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
