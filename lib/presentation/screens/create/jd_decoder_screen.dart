import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class JdDecoderScreen extends StatefulWidget {
  const JdDecoderScreen({super.key});

  @override
  State<JdDecoderScreen> createState() => _JdDecoderScreenState();
}

class _JdDecoderScreenState extends State<JdDecoderScreen> {
  final _podcastNameController = TextEditingController();
  final _jdController = TextEditingController();

  String _duration = 'Short (~3m)';
  String _hostAccent = 'us American';
  bool _decodeAgainstProfile = false;

  @override
  void dispose() {
    _podcastNameController.dispose();
    _jdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030712), // Dark App Background
      appBar: AppBar(
        backgroundColor: const Color(0xFF030712),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Job Description Decoder',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Paste a Job Description to discover hidden red flags, salary estimates, and the 'real' requirements.",
                      style: TextStyle(color: Color(0xFFA3A3A3), fontSize: 13),
                    ),
                    const SizedBox(height: 24),

                    // Podcast Name Input
                    _buildLabel('Podcast Name (Optional)'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      _podcastNameController,
                      'e.g. Google L4 Role Decoder',
                    ),
                    const SizedBox(height: 16),

                    // Controls Row (Duration, Accent, Checkbox)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF1E293B)),
                      ),
                      child: Row(
                        children: [
                          // Dropdowns Column
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                // Duration
                                Expanded(
                                  child: _buildSmallDropdown(
                                    Icons.access_time_filled,
                                    'Duration:',
                                    _duration,
                                    ['Short (~3m)', 'Detailed (~10m)'],
                                    (val) => setState(() => _duration = val!),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Host Accent
                                Expanded(
                                  child: _buildSmallDropdown(
                                    Icons.mic,
                                    'Host Accent:',
                                    _hostAccent,
                                    ['us American', 'uk British', 'in Indian'],
                                    (val) => setState(() => _hostAccent = val!),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Profile Checkbox
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Checkbox(
                                        value: _decodeAgainstProfile,
                                        onChanged: (val) => setState(
                                          () => _decodeAgainstProfile = val!,
                                        ),
                                        activeColor: const Color(0xFFF97316),
                                        side: const BorderSide(
                                          color: Color(0xFF64748B),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Expanded(
                                      child: Text(
                                        'Decode against my Profile',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 26),
                                  child: RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: Color(0xFF64748B),
                                      ),
                                      children: [
                                        TextSpan(text: 'Uses data from your '),
                                        TextSpan(
                                          text: 'My Twin Profile',
                                          style: TextStyle(
                                            color: Color(0xFFF97316),
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                        TextSpan(text: '.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Job Description Input
                    TextField(
                      controller: _jdController,
                      maxLines: 12,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Paste the Job Description here...',
                        hintStyle: const TextStyle(color: Color(0xFF475569)),
                        filled: true,
                        fillColor: const Color(0xFF020617),
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFF97316),
                          ), // Orange focus
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer Action Button
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFF1E293B))),
                color: Color(0xFF030712),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Generating JD Decoder...');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEA580C), // Orange-600
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.play_arrow, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Generate JD Decoder',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF94A3B8), // Material Slate 400
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF475569)),
        filled: true,
        fillColor: const Color(0xFF020617), // Slate 950
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1E293B)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1E293B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFF97316),
          ), // Orange focus
        ),
      ),
    );
  }

  Widget _buildSmallDropdown(
    IconData icon,
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: const Color(0xFF0F172A),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...items.map(
                      (e) => ListTile(
                        title: Text(
                          e,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        trailing: e == value
                            ? const Icon(
                                Icons.check,
                                color: Color(0xFF10B981),
                                size: 20,
                              )
                            : null,
                        onTap: () {
                          onChanged(e);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF020617),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFF1E293B)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF64748B),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
