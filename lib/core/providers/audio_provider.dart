import 'package:audio_service/audio_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_provider.g.dart';

// This provider will be overridden in main.dart
@Riverpod(keepAlive: true)
AudioHandler audioHandler(AudioHandlerRef ref) {
  throw UnimplementedError('AudioHandler must be initialized in main.dart');
}
