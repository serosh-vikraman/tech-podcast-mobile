import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  int _selectedCategoryIndex = 0;

  // Reusing the same studio features model for consistency
  final List<Map<String, dynamic>> _studioFeatures = [
    {
      'title': 'All',
      'color': Color(0xFFF9FAFB),
      'count': 45,
    }, // Default white/gray
    {'title': 'The Interview Twin', 'color': Color(0xFF10B981), 'count': 12},
    {'title': 'Nano Learning', 'color': Color(0xFF8B5CF6), 'count': 8},
    {'title': 'The JD Decoder', 'color': Color(0xFFF59E0B), 'count': 5},
    {'title': 'The Recruiter\'s Eye', 'color': Color(0xFFA855F7), 'count': 7},
    {'title': 'Salary Negotiator', 'color': Color(0xFF10B981), 'count': 3},
    {
      'title': 'Architecture & Strategy',
      'color': Color(0xFFEC4899),
      'count': 15,
    },
    {'title': 'Tech Stack Battle', 'color': Color(0xFFEF4444), 'count': 4},
    {'title': 'URL to Podcast', 'color': Color(0xFF3B82F6), 'count': 9},
  ];

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF030712); // Dark Navy
    const textPrimary = Color(0xFFF9FAFB);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header & Search
                const Text(
                  'Library',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 24),

                // Search Bar
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search podcasts...',
                    hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF9CA3AF),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1F2937),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF374151)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF374151)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // The Vault Banner
                GestureDetector(
                  onTap: () => context.push('/vault'),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF064E3B),
                          Color(0xFF042F2E),
                        ], // Dark Emerald
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF10B981).withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF10B981).withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.lock_open_rounded,
                            color: Color(0xFF10B981),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'The Vault',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Exclusive career strategies & intelligence.',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 2. Category Filters
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _studioFeatures.length,
                    separatorBuilder: (c, i) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final feature = _studioFeatures[index];
                      final isSelected = index == _selectedCategoryIndex;
                      final color = feature['color'] as Color;
                      final count = feature['count'] as int;

                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedCategoryIndex = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? color.withOpacity(0.2)
                                : const Color(0xFF1F2937),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? color
                                  : const Color(0xFF374151),
                            ),
                          ),
                          child: Text(
                            '${feature['title']} ($count)',
                            style: TextStyle(
                              color: isSelected
                                  ? color
                                  : const Color(0xFF9CA3AF),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // 3. Podcast List (Detail Tiles)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  separatorBuilder: (c, i) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _buildPodcastDetailTile(index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPodcastDetailTile(int index) {
    // Mock Data matching web fields: Details (Img+Title), Type, Date, Duration, Status
    final items = [
      {
        'title': 'System Design: Scalability',
        'subtitle': 'Deep dive into horizontal scaling',
        'type': 'Interview Twin',
        'date': 'Jan 20, 2026',
        'duration': '45 min',
        'status': 'Published',
        'color': Color(0xFF10B981),
      },
      {
        'title': 'Negotiation Tactics 101',
        'subtitle': 'Salary negotiation basics',
        'type': 'Nano Learning',
        'date': 'Jan 18, 2026',
        'duration': '12 min',
        'status': 'Draft',
        'color': Color(0xFF8B5CF6),
      },
      {
        'title': 'Java vs Kotlin',
        'subtitle': 'Language wars',
        'type': 'Tech Stack Battle',
        'date': 'Jan 15, 2026',
        'duration': '30 min',
        'status': 'Processing',
        'color': Color(0xFFEF4444),
      },
      {
        'title': 'Frontend Architecture',
        'subtitle': 'Micro-frontends guide',
        'type': 'Architecture',
        'date': 'Jan 10, 2026',
        'duration': '28 min',
        'status': 'Published',
        'color': Color(0xFFEC4899),
      },
    ];

    final item = items[index];
    final color = item['color'] as Color;
    final status = item['status'] as String;

    Color statusColor;
    if (status == 'Published')
      statusColor = Color(0xFF10B981);
    else if (status == 'Processing')
      statusColor = Color(0xFFF59E0B);
    else
      statusColor = Color(0xFF9CA3AF);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111827), // Surface
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Column(
        children: [
          // Top Row: Image, Title, Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Icon(Icons.podcasts, color: color, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['subtitle'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF9CA3AF),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: const Color(0xFF374151), height: 1),
          const SizedBox(height: 16),

          // Metadata Row: Type | Date | Duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetaItem(Icons.category_outlined, item['type'] as String),
              _buildMetaItem(
                Icons.calendar_today_outlined,
                item['date'] as String,
              ),
              _buildMetaItem(Icons.access_time, item['duration'] as String),
            ],
          ),

          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow_rounded, size: 18),
                  label: const Text('Play'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF374151)),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Icon(
                  Icons.more_horiz,
                  size: 20,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF6B7280)),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF9CA3AF),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
