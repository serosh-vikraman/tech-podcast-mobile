import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tech_podcast_mobile/data/models/audio_job_model.dart';
import 'package:go_router/go_router.dart';

class PlayerScreen extends StatefulWidget {
  final AudioJobModel job;

  const PlayerScreen({super.key, required this.job});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _player;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _player = AudioPlayer();
    
    // Listen to state changes
    _player.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
        if (state.processingState == ProcessingState.completed) {
           _position = Duration.zero;
           _player.pause();
           _player.seek(Duration.zero);
        }
      });
    });

    _player.durationStream.listen((d) {
      setState(() => _duration = d ?? Duration.zero);
    });

    _player.positionStream.listen((p) {
      setState(() => _position = p);
    });

    try {
      if (widget.job.assetUrl != null) {
        await _player.setUrl(widget.job.assetUrl!);
        _player.play(); // Auto-play
      }
    } catch (e) {
      debugPrint("Error loading audio: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
  
  // Reuse gradient logic for consistency
  List<Color> _getGradientForType(String type) {
    if (type.contains('INTERVIEW')) return [const Color(0xFF059669), const Color(0xFF34D399)];
    if (type.contains('CONCEPT') || type.contains('NANO')) return [const Color(0xFF4F46E5), const Color(0xFFA78BFA)];
    if (type.contains('JD')) return [const Color(0xFFD97706), const Color(0xFFFBBF24)];
    if (type.contains('RESUME') || type.contains('RECRUITER')) return [const Color(0xFF7C3AED), const Color(0xFFC4B5FD)];
    return [const Color(0xFFFDE047), const Color(0xFFF9A8D4)]; // Default Yellow/Pink
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = _getGradientForType(widget.job.type);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 32),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF030712), // Dark Navy bg
        ),
        child: Column(
          children: [
             // Big Art Area
             Expanded(
               flex: 3,
               child: Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                     colors: gradientColors,
                     begin: Alignment.topCenter,
                     end: Alignment.bottomCenter,
                   ),
                   borderRadius: const BorderRadius.only(
                     bottomLeft: Radius.circular(40),
                     bottomRight: Radius.circular(40),
                   ),
                 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const Icon(Icons.podcasts, size: 80, color: Colors.white),
                     const SizedBox(height: 20),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 40),
                       child: Text(
                         widget.job.title,
                         textAlign: TextAlign.center,
                         style: const TextStyle(
                           color: Colors.white,
                           fontSize: 24,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ),
             
             // Controls Area
             Expanded(
               flex: 2,
               child: Padding(
                 padding: const EdgeInsets.all(32.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     // Progress Bar
                     Slider(
                       activeColor: gradientColors[0],
                       inactiveColor: Colors.grey[800],
                       min: 0.0,
                       max: _duration.inSeconds.toDouble(),
                       value: _position.inSeconds.toDouble().clamp(0.0, _duration.inSeconds.toDouble()),
                       onChanged: (value) {
                         _player.seek(Duration(seconds: value.toInt()));
                       },
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(_formatDuration(_position), style: const TextStyle(color: Colors.grey)),
                           Text(_formatDuration(_duration), style: const TextStyle(color: Colors.grey)),
                         ],
                       ),
                     ),
                     
                     const SizedBox(height: 30),
                     
                     // Main Buttons
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                          IconButton(
                            icon: const Icon(Icons.replay_10_rounded, size: 36, color: Colors.white),
                            onPressed: () => _player.seek(_position - const Duration(seconds: 10)),
                          ),
                          const SizedBox(width: 30),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: gradientColors[0].withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: _isLoading 
                              ? const Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator())
                              : IconButton(
                                  icon: Icon(
                                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                    size: 48,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (_isPlaying) {
                                      _player.pause();
                                    } else {
                                      _player.play();
                                    }
                                  },
                                ),
                          ),
                          const SizedBox(width: 30),
                          IconButton(
                            icon: const Icon(Icons.forward_10_rounded, size: 36, color: Colors.white),
                            onPressed: () => _player.seek(_position + const Duration(seconds: 10)),
                          ),
                       ],
                     )
                   ],
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }
}
