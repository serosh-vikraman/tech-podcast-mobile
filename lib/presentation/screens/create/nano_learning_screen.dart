import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NanoLearningScreen extends StatefulWidget {
  const NanoLearningScreen({super.key});

  @override
  State<NanoLearningScreen> createState() => _NanoLearningScreenState();
}

class _NanoLearningScreenState extends State<NanoLearningScreen> {
  final _conceptController = TextEditingController();
  final _insightNameController = TextEditingController();

  String _duration = 'Nano (Quick Insight ~3m)';
  String _accent = 'us American';

  @override
  void dispose() {
    _conceptController.dispose();
    _insightNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030712),
      appBar: AppBar(
        backgroundColor: const Color(0xFF030712),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Nano Learning',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Concept Input
              _buildLabelWithIcon(
                Icons.help_outline,
                'What specific concept confuses you?',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _conceptController,
                style: const TextStyle(color: Colors.white),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      "e.g. 'How does React useEffect work?', 'Difference between Rest and GraphQL'",
                  hintStyle: const TextStyle(color: Color(0xFF525252)),
                  filled: true,
                  fillColor: const Color(0xFF0F172A), // Slate 900
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF334155),
                    ), // Slate 700
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF334155)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF6366F1),
                    ), // Indigo 500
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 24),

              // Insight Name Input
              _buildLabel('Name this insight'),
              const SizedBox(height: 12),
              TextField(
                controller: _insightNameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "e.g. React Fiber 101",
                  hintStyle: const TextStyle(color: Color(0xFF525252)),
                  filled: true,
                  fillColor: const Color(0xFF0F172A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF334155)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF334155)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF6366F1)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Duration & Accent Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabelWithIcon(Icons.timer_outlined, 'Duration'),
                        const SizedBox(height: 12),
                        _buildDropdown(
                          value: _duration,
                          items: [
                            'Nano (Quick Insight ~3m)',
                            'Short (~5m)',
                            'Deep Dive (~10m)',
                          ],
                          onChanged: (v) => setState(() => _duration = v!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Voice Accent'),
                        const SizedBox(height: 12),
                        _buildDropdown(
                          value: _accent,
                          items: [
                            'us American',
                            'British',
                            'Indian',
                            'Australian',
                          ],
                          onChanged: (v) => setState(() => _accent = v!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text(
                'Strictly focused. No fluff.',
                style: TextStyle(color: Color(0xFF737373), fontSize: 13),
              ),
              const SizedBox(height: 48),

              // Generate Button
              ElevatedButton(
                onPressed: () {
                  // Logic placeholder
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5), // Indigo 600
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  shadowColor: const Color(0xFF4F46E5).withOpacity(0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.bolt, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Generate Nano Learning',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Uses advanced AI to synthesize a perfect explanation.',
                  style: TextStyle(color: Color(0xFF525252), fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  Widget _buildLabelWithIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF6366F1), size: 18), // Indigo 500
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A), // Slate 900
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155)), // Slate 700
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: const Color(0xFF1E293B), // Slate 800
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF94A3B8)),
          style: const TextStyle(color: Colors.white, fontSize: 13),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
