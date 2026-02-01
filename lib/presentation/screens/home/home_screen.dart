import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tech_podcast_mobile/data/models/audio_job_model.dart';
import 'package:tech_podcast_mobile/data/repositories/podcast_repository.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final AudioPlayer _player = AudioPlayer();
  int _selectedCategoryIndex = 0;

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  // ... rest of class vars ...

  final List<Map<String, dynamic>> _studioFeatures = [
    // ... items ...
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
    // ... existing build ...
    // Dark Theme Colors
    const bgColor = Color(0xFF030712); // Rich Dark Navy / Gray 950
    const textPrimary = Color(0xFFF9FAFB); // White

    // NO Scaffold - DashboardScreen provides it
    return ColoredBox(
      color: bgColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header
              // 1. Header (Global AppBar used instead)
              // const SizedBox(height: 20),

              // 2. Recent Podcast
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Recent Podcast",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildRecentPodcastsCarousel(),

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

  Widget _buildRecentPodcastsCarousel() {
    final recentAsync = ref.watch(recentPodcastsProvider);

    return recentAsync.when(
      data: (jobs) {
        if (jobs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("No recent podcasts found.", style: TextStyle(color: Colors.grey)),
          );
        }

        return SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: jobs.length,
            separatorBuilder: (c, i) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final job = jobs[index];
              final categoryText = job.category ?? _getJobCategoryTitle(job.type);

              return GestureDetector(
                onTap: () {
                  context.push('/player', extra: job);
                },
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _getGradientForType(job.type),
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          categoryText.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Title
                      Text(
                        job.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18, // Reduced from 22
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Author/Subtitle (Optional based on screenshot "with Lucy Ross")
                      // If subtitle is short, we can show it, otherwise hide description
                      // Using "with AI Host" or similar if no specific author logic
                       Text(
                        'with CareerTwin AI', 
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('Error: $err', style: const TextStyle(color: Colors.red)),
      ),
    );
  }

  Widget _buildPodcastList() {
    final recentAsync = ref.watch(recentPodcastsProvider);

    return recentAsync.when(
      data: (jobs) {
        if (jobs.isEmpty) return _buildEmptyState();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: jobs.map((job) {
              // Determine color based on type or use default
              final colors = _getGradientForType(job.type);
              final primaryColor = colors[0];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    // Thumbnail
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: colors.map((c) => c.withOpacity(0.4)).toList(),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: primaryColor.withOpacity(0.3)),
                      ),
                      child: Icon(Icons.podcasts, color: primaryColor, size: 30),
                    ),
                    const SizedBox(width: 16),

                    // Text Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF9FAFB), // White
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            job.subtitle,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFFD1D5DB), // Light Gray
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined, size: 12, color: Color(0xFF6B7280)),
                              const SizedBox(width: 4),
                              Text(
                                job.durationSeconds != null 
                                  ? _formatDuration(job.durationSeconds!) 
                                  : 'Pending',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280), // Muted Gray
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Play Button
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor.withOpacity(0.3)),
                      ),
                      child: Icon(Icons.play_arrow_rounded, color: primaryColor),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
      loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
      error: (_, __) => const SizedBox(), // Hide on error
    );
  }

  // Helper moved or kept consistent
  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _getJobCategoryTitle(String type) {
    if (type.contains('INTERVIEW_TWIN')) return 'Interview Twin';
    if (type.contains('CONCEPT') || type.contains('NANO')) return 'Nano Learning';
    if (type.contains('JD')) return 'JD Decoder';
    if (type.contains('RESUME') || type.contains('RECRUITER')) return 'Recruiter\'s Eye';
    if (type.contains('SALARY')) return 'Salary Negotiator';
    if (type.contains('ARCH')) return 'Architecture';
    if (type.contains('STACK') || type.contains('BATTLE')) return 'Tech Battle';
    if (type.contains('URL')) return 'URL to Podcast';
    return 'Podcast';
  }

  List<Color> _getGradientForType(String type) {
    if (type.contains('INTERVIEW')) return [const Color(0xFF059669), const Color(0xFF34D399)];
    if (type.contains('CONCEPT') || type.contains('NANO')) return [const Color(0xFF4F46E5), const Color(0xFFA78BFA)];
    if (type.contains('JD')) return [const Color(0xFFD97706), const Color(0xFFFBBF24)];
    if (type.contains('RESUME') || type.contains('RECRUITER')) return [const Color(0xFF7C3AED), const Color(0xFFC4B5FD)];
    
    // Default Yellow/Pink Design for general podcasts or unknowns
    return [const Color(0xFFFDE047), Color(0xFFF9A8D4)];
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mic_none_outlined,
                size: 48,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Podcasts Yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF9FAFB),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "It's quiet here. Start your journey by creating your first AI-generated podcast.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF9CA3AF),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to Create tab (index 2 in the shell route)
                // Assuming standard GoRouter integration with StatefulShellRoute
                context.go('/create'); 
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('Create New Podcast'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6), // Blue accent
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
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
}
