import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studios = [
      {
        'title': 'The Interview Twin',
        'subtitle':
            'Step beyond reality. Your AI clone faces the interview, tested against tough scenarios.',
        'icon': Icons.center_focus_strong,
        'colors': [const Color(0xFF059669), const Color(0xFF0F766E)], // Emerald
        'badge': 'Clone Yourself. Win The Job.',
        'route': '/create/interview-twin',
      },
      {
        'title': 'Nano Learning',
        'subtitle':
            'Master one specific thing in 3-10 minutes. Just-in-time audio for specific gaps.',
        'icon': Icons.psychology,
        'colors': [const Color(0xFF4F46E5), const Color(0xFF3730A3)], // Indigo
        'badge': 'Tiny Lessons. Big Impact.',
        'route': '/create/nano-learning',
      },
      {
        'title': 'The JD Decoder',
        'subtitle':
            'Read Between The Bullets. Job Descriptions are full of noise. Extract the signal.',
        'icon': Icons.find_in_page,
        'colors': [const Color(0xFFD97706), const Color(0xFFB45309)], // Amber
        'badge': 'Decode The Role. Win It.',
        'route': '/create/jd-decoder',
      },
      {
        'title': "The Recruiter's Eye",
        'subtitle':
            'The Brutal Truth. Fairness is overrated. Preparation is everything. Get the harsh reality check.',
        'icon': Icons.visibility,
        'colors': [const Color(0xFF7C3AED), const Color(0xFF5B21B6)], // Violet
        'badge': 'Brutal Truth. Better Resume.',
        'route': '/create/recruiters-eye',
      },
      {
        'title': 'Salary Negotiator',
        'subtitle':
            'Know Your Worth. Then Add 20%. Negotiation is a game of leverage. Script your winning move.',
        'icon': Icons.attach_money,
        'colors': [const Color(0xFF10B981), const Color(0xFF047857)], // Green
        'badge': 'Know Your Worth. Get It.',
        'route': '/create/salary-negotiator',
      },
      {
        'title': 'Architecture & Strategy',
        'subtitle':
            'Speak The Language of Scale. Senior engineers don\'t just code; they design systems.',
        'icon': Icons.account_tree,
        'colors': [const Color(0xFF3B82F6), const Color(0xFF1E40AF)], // Blue
        'badge': 'Think Big. Design Scale.',
        'route': '/create/architecture',
      },
      {
        'title': 'Tech Stack Battle',
        'subtitle':
            'Pick Your Weapon. React vs Vue? AWS vs Azure? Don\'t just choose a tech, defend it.',
        'icon': Icons.compare_arrows,
        'colors': [const Color(0xFFEF4444), const Color(0xFFB91C1C)], // Red
        'badge': 'Pick Your Side. Defend It.',
        'route': '/create/tech-battle',
      },
      {
        'title': 'GitHub Repo Explainer',
        'subtitle':
            'Decode The Base. Walk into any codebase with confidence. Turn silent code into audio walkthroughs.',
        'icon': Icons.code,
        'colors': [const Color(0xFF06B6D4), const Color(0xFF0E7490)], // Cyan
        'badge': 'Don\'t Read Code. Hear It.',
        'route': '/create/repo-explainer',
      },
      {
        'title': 'URL to Podcast',
        'subtitle':
            'Download The Industry. Turn 20 open tabs into one commute-friendly audio deep dive.',
        'icon': Icons.link,
        'colors': [
          const Color(0xFF6366F1),
          const Color(0xFF4338CA),
        ], // Indigo-Blue
        'badge': 'Turn Tabs Into Tracks.',
        'route': '/create/url-to-podcast',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF030712), // Dark App Background
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Creator Studio',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choose a studio model to generate AI content.',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final studio = studios[index];
                  // Staggered Animation
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildStudioCard(context, studio),
                  ).animate().fadeIn(duration: 400.ms, delay: (50 * index).ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuad);
                }, childCount: studios.length),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildStudioCard(BuildContext context, Map<String, dynamic> studio) {
    final List<Color> colors = studio['colors'] as List<Color>;
    final String route = studio['route'] as String;

    return _InteractiveCard(
      onTap: () {
        // Verify if route is enabled
        if (route == '/create/nano-learning' ||
            route == '/create/interview-twin' ||
            route == '/create/jd-decoder' ||
            route == '/create/recruiters-eye' ||
            route == '/create/salary-negotiator' ||
            route == '/create/architecture' ||
            route == '/create/tech-battle' ||
            route == '/create/url-to-podcast') {
          context.push(route);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Coming Soon: ${studio['title']}')),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E293B).withOpacity(0.6), // Dark Slate
              const Color(0xFF0F172A).withOpacity(0.8), // Darker
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Glow (Subtle)
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: colors.first.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true))
              .scaleXY(begin: 1, end: 1.2, duration: 2000.ms, curve: Curves.easeInOut),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: colors.first.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: colors.first.withOpacity(0.3)),
                    ),
                    child: Icon(
                      studio['icon'] as IconData,
                      color: colors.first, // Use the primary color
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: colors.last.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: colors.last.withOpacity(0.3), width: 0.5),
                          ),
                          child: Text(
                            studio['badge'] as String,
                            style: TextStyle(
                              color: colors.first,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),

                        Text(
                          studio['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          studio['subtitle'] as String,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 13,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Arrow
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 18),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white.withOpacity(0.2),
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Bouncy Interactive Card Wrapper
class _InteractiveCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _InteractiveCard({required this.child, required this.onTap});

  @override
  State<_InteractiveCard> createState() => _InteractiveCardState();
}

class _InteractiveCardState extends State<_InteractiveCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
