import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tech_podcast_mobile/core/supabase_config.dart';
import 'package:tech_podcast_mobile/presentation/router/app_router.dart';
import 'package:tech_podcast_mobile/core/theme/app_theme.dart';
import 'package:audio_service/audio_service.dart';
import 'package:tech_podcast_mobile/core/audio/audio_handler.dart';
import 'package:tech_podcast_mobile/core/providers/audio_provider.dart';

import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set System UI Overlay Style for edge-to-edge look and matching colors
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Transparent to show app background
    statusBarIconBrightness: Brightness.light, // White icons
    systemNavigationBarColor: Color(0xFF030712), // Match AppTheme.background
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  final audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.careerCast.techPodcast.channel.audio',
      androidNotificationChannelName: 'Tech Podcast Audio',
      androidNotificationOngoing: true,
    ),
  );

  runApp(ProviderScope(
    overrides: [
      audioHandlerProvider.overrideWithValue(audioHandler),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'CareerTwin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}

