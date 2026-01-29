import 'package:flutter/material.dart';
import 'package:tech_podcast_mobile/presentation/screens/playlist/widgets/create_playlist_modal.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF030712);
    const textPrimary = Color(0xFFF9FAFB);

    // NO Scaffold - DashboardScreen provides it
    return ColoredBox(
      color: bgColor,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Playlists',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // Allow full height
                    backgroundColor: Colors.transparent,
                    builder: (context) => const CreatePlaylistModal(),
                  );
                },
                icon: const Icon(Icons.add, color: textPrimary, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Empty State or List
          _PlaylistTile(
            title: 'Favorites',
            count: 12,
            colors: [Color(0xFFEC4899), Color(0xFFF472B6)],
          ),
          SizedBox(height: 16),
          _PlaylistTile(
            title: 'Interview Prep',
            count: 5,
            colors: [Color(0xFF10B981), Color(0xFF34D399)],
          ),
          SizedBox(height: 16),
          _PlaylistTile(
            title: 'Morning Commute',
            count: 8,
            colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
          ),
        ],
      ),
    );
  }
}

class _PlaylistTile extends StatelessWidget {
  final String title;
  final int count;
  final List<Color> colors;

  const _PlaylistTile({
    required this.title,
    required this.count,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.music_note, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$count episodes',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF6B7280)),
        ],
      ),
    );
  }
}
