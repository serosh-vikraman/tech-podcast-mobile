import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_podcast_mobile/data/repositories/auth_repository.dart';

class StudioScreen extends StatelessWidget {
  const StudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Studio')),
      body: const Center(child: Text('Studio Modules (JD Decoder, Interview Twin)')),
    );
  }
}





