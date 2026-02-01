import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tech_podcast_mobile/firebase_options.dart';
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

  // Set up error handling to prevent blank screens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  // Set System UI Overlay Style - Use explicit color instead of transparent
  // CRITICAL: Set explicit dark color to prevent gray overlay from top
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF030712), // Explicit dark color, NOT transparent
    statusBarIconBrightness: Brightness.light, // White icons
    systemNavigationBarColor: Color(0xFF030712), // Match AppTheme.background
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  
  // Use manual mode instead of edge-to-edge to have more control
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );

  // Initialize Supabase with error handling
  try {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
    );
  } catch (e) {
    debugPrint('Supabase initialization error: $e');
  }

  // Initialize Firebase (Required for Auth)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }

  // Initialize AudioService with error handling
  AudioHandler? audioHandler;
  try {
    audioHandler = await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.careerCast.techPodcast.channel.audio',
        androidNotificationChannelName: 'Tech Podcast Audio',
        androidNotificationOngoing: true,
      ),
    );
  } catch (e) {
    // Log error but don't crash - app can still work without audio service initially
    debugPrint('AudioService initialization error: $e');
  }

  runApp(ProviderScope(
    overrides: audioHandler != null
        ? [
            audioHandlerProvider.overrideWithValue(audioHandler!),
          ]
        : [],
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
      builder: (context, child) {
        return MediaQuery(
          // Ensure consistent text scaling
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}

