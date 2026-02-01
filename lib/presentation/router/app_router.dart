import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_podcast_mobile/data/repositories/auth_repository.dart';
import 'package:tech_podcast_mobile/presentation/screens/auth/login_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/auth/otp_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/auth/signup_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/dashboard_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/home/home_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/library/library_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/create/create_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/create/nano_learning_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/create/interview_twin_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/create/jd_decoder_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/create/recruiters_eye_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/create/salary_negotiator_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/create/architecture_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/create/tech_battle_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/create/url_to_podcast_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/playlist/playlist_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/profile/profile_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/library/vault_screen.dart';
import 'package:tech_podcast_mobile/presentation/screens/pricing/pricing_screen.dart'; // Add import
import 'package:tech_podcast_mobile/presentation/screens/player/player_screen.dart';
import 'package:tech_podcast_mobile/data/models/audio_job_model.dart';
import 'package:tech_podcast_mobile/core/providers/dummy_user_provider.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  // Watch dummy provider to trigger rebuilds on login/logout
  final isDummyLoggedIn = ref.watch(dummyUserProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final phone = state.extra as String;
          return OtpScreen(phone: phone);
        },
      ),
      GoRoute(
        path: '/create/nano-learning',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const NanoLearningScreen(),
      ),

      GoRoute(
        path: '/create/interview-twin',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const InterviewTwinScreen(),
      ),
      GoRoute(
        path: '/create/jd-decoder',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const JdDecoderScreen(),
      ),
      GoRoute(
        path: '/create/recruiters-eye',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const RecruitersEyeScreen(),
      ),
      GoRoute(
        path: '/create/salary-negotiator',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SalaryNegotiatorScreen(),
      ),
      GoRoute(
        path: '/create/architecture',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ArchitectureScreen(),
      ),
      GoRoute(
        path: '/create/tech-battle',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const TechBattleScreen(),
      ),
      GoRoute(
        path: '/create/url-to-podcast',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const UrlToPodcastScreen(),
      ),
      GoRoute(
        path: '/vault',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const VaultScreen(),
      ),
      GoRoute(
        path: '/pricing',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const PricingScreen(),
      ),
      GoRoute(
        path: '/player',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
           final job = state.extra as AudioJobModel;
           return PlayerScreen(job: job);
        },
      ),
      // StatefulShellRoute for Bottom Navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DashboardScreen(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Branch 1: Library
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/library',
                builder: (context, state) => const LibraryScreen(),
              ),
            ],
          ),
          // Branch 2: Create (Center)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/create',
                builder: (context, state) => const CreateScreen(),
              ),
            ],
          ),
          // Branch 3: Search
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/playlist', // Changed from /search
                builder: (context, state) => const PlaylistScreen(),
              ),
            ],
          ),
          // Branch 4: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final user = authRepository.currentUser;
      final isDummyLoggedIn = ref.read(dummyUserProvider);
      final isLoggedIn = user != null || isDummyLoggedIn;

      final isLoggingIn =
          state.uri.path == '/login' ||
          state.uri.path == '/otp' ||
          state.uri.path == '/signup';

      if (!isLoggedIn && !isLoggingIn) {
        if (state.uri.path == '/onboarding') return null; // Allow onboarding
        return '/onboarding'; // Default to onboarding
      }

      if (isLoggedIn && isLoggingIn) {
        return '/';
      }

      return null;
    },
  );
}
