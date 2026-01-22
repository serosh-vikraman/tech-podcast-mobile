import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tech_podcast_mobile/core/supabase_config.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000', // Default Android Emulator host for local dev
      // For real device or production, use Supabase Function URL or your backend URL
      // baseUrl: 'https://api.careertwin.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final session = Supabase.instance.client.auth.currentSession;
        if (session != null) {
          options.headers['Authorization'] = 'Bearer ${session.accessToken}';
        }
        // Add API Key header if needed for your specific backend proxy
        // options.headers['x-api-key'] = '...';
        
        return handler.next(options);
      },
    ),
  );

  return dio;
}
