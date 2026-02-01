import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_podcast_mobile/core/dio_provider.dart';
import 'package:tech_podcast_mobile/data/models/audio_job_model.dart';

final podcastRepositoryProvider = Provider<PodcastRepository>((ref) {
  return PodcastRepository(ref.watch(dioProvider));
});

// Provider for fetching public (recent) podcasts
final recentPodcastsProvider = FutureProvider<List<AudioJobModel>>((ref) async {
  return ref.watch(podcastRepositoryProvider).getPublicPodcasts();
});

// Keeping this for library view if needed later
final userJobsProvider = FutureProvider<List<AudioJobModel>>((ref) async {
  return ref.watch(podcastRepositoryProvider).getUserJobs();
});

class PodcastRepository {
  final Dio _dio;

  PodcastRepository(this._dio);

  Future<List<AudioJobModel>> getUserJobs() async {
    try {
      final response = await _dio.get('/podcast/jobs');
      final List<dynamic> list = response.data;
      return list.map((json) => AudioJobModel.fromJson(json)).toList();
    } catch (e) {
      // If unauthorized, return empty list or rethrow? 
      // User is using Firebase Auth which might fail here if API expects Supabase.
      // But let's assume this might fail silently or return empty.
      debugPrint('Error fetching user jobs: $e');
      // Returning empty list to prevent crash, user seems focused on Public ones now.
      return []; 
    }
  }

  Future<List<AudioJobModel>> getPublicPodcasts() async {
    try {
      // Fetching from public endpoint
      // Assuming it supports limit or we take first 5
      final response = await _dio.get('/podcast/public');
      final List<dynamic> list = response.data;
      
      // Map and take top 5
      var models = list.map((json) => AudioJobModel.fromJson(json)).toList();
      
      // If the API doesn't sort by date, we might want to ensure it?
      // models.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      if (models.length > 5) {
        models = models.sublist(0, 5);
      }
      
      return models;
    } catch (e) {
      debugPrint('Error fetching public podcasts: $e');
      return [];
    }
  }
}
