import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_podcast_mobile/core/providers/audio_provider.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the AudioHandler from our provider - handle case where it might not be initialized
    AudioHandler handler;
    try {
      handler = ref.watch(audioHandlerProvider);
    } catch (e) {
      // AudioHandler not initialized, don't show mini player
      return const SizedBox.shrink();
    }

    return StreamBuilder<MediaItem?>(
      stream: handler.mediaItem,
      builder: (context, snapshot) {
        final mediaItem = snapshot.data;
        // Hide if nothing is playing or queued
        if (mediaItem == null) return const SizedBox.shrink();

        return Dismissible(
          key: const Key('mini_player'),
          direction: DismissDirection.down,
          onDismissed: (_) => handler.stop(),
          child: Container(
            height: 66,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF171717), // Neutral 900
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                // Artwork Placeholder
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                    image: mediaItem.artUri != null
                        ? DecorationImage(
                            image: NetworkImage(mediaItem.artUri.toString()),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: mediaItem.artUri == null
                      ? const Icon(Icons.music_note, color: Colors.white60)
                      : null,
                ),
                
                const SizedBox(width: 12),
                
                // Metadata
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mediaItem.title,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (mediaItem.artist != null)
                        Text(
                          mediaItem.artist!,
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                
                // Controls
                StreamBuilder<PlaybackState>(
                  stream: handler.playbackState,
                  builder: (context, snapshot) {
                    final playing = snapshot.data?.playing ?? false;
                    final processingState = snapshot.data?.processingState ?? AudioProcessingState.idle;
                    
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (processingState == AudioProcessingState.loading || processingState == AudioProcessingState.buffering)
                          const SizedBox(
                             width: 48, 
                             child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)))
                          )
                        else
                          IconButton(
                            onPressed: playing ? handler.pause : handler.play,
                            icon: Icon(playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
                            color: Colors.white,
                            iconSize: 32,
                          ),
                          
                        IconButton(
                          onPressed: handler.stop, // Or skip next
                          icon: const Icon(Icons.close_rounded),
                          color: Colors.white60,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
