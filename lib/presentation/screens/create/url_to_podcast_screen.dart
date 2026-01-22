import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UrlToPodcastScreen extends StatefulWidget {
  const UrlToPodcastScreen({super.key});

  @override
  State<UrlToPodcastScreen> createState() => _UrlToPodcastScreenState();
}

class _UrlToPodcastScreenState extends State<UrlToPodcastScreen> {
  final _urlController = TextEditingController(
    text: 'https://techcrunch.com/2024/...',
  );
  final _titleController = TextEditingController(text: 'My Custom Podcast...');

  String _hostAccent = 'US';
  String _tone = 'Engaging & Lively';
  String _length = 'Short (2-3 mins)';

  @override
  void dispose() {
    _urlController.dispose();
    _titleController.dispose();
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
          "", // No title in screenshot, handled in body or implicit
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Turn Any Article into a Podcast',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Paste a URL and let our AI hosts discuss it for you. Perfect for commuting or learning on the go.',
                style: TextStyle(color: Color(0xFFA3A3A3), fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1E293B)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Article URL'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _urlController,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.language,
                          color: Color(0xFF64748B),
                          size: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF020617),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
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
                            color: Color(0xFF6366F1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Podcast Title (Optional)'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _titleController,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF020617),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
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
                            color: Color(0xFF6366F1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildConfigCard(
                      '1',
                      'Host Accent',
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildFlagBtn(
                                  'US',
                                  '🇺🇸',
                                  _hostAccent == 'US',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildFlagBtn(
                                  'UK',
                                  '🇬🇧',
                                  _hostAccent == 'UK',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _buildFlagBtn(
                                  'IN',
                                  '🇮🇳',
                                  _hostAccent == 'IN',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildFlagBtn(
                                  'AU',
                                  '🇦🇺',
                                  _hostAccent == 'AU',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildConfigCard(
                      '2',
                      'Conversation Tone',
                      _buildDropdown(_tone, [
                        'Engaging & Lively',
                        'Professional',
                        'Technical',
                      ]),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildConfigCard(
                      '3',
                      'Episode Length',
                      _buildDropdown(_length, [
                        'Short (2-3 mins)',
                        'Long (5-10 mins)',
                      ]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.mic, size: 18),
                  label: const Text('Generate Podcast'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4338CA), // Indigo
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
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
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildConfigCard(String number, String title, Widget content) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          content,
        ],
      ),
    );
  }

  Widget _buildFlagBtn(String label, String flag, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1E1B4B) : const Color(0xFF020617),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF1E293B),
        ),
      ),
      child: Column(
        children: [
          Text(flag, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String value, List<String> items) {
    return GestureDetector(
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
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    trailing: e == value
                        ? const Icon(
                            Icons.check,
                            color: Color(0xFF10B981),
                            size: 20,
                          )
                        : null,
                    onTap: () {
                      // onChanged(e);
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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 40, // Fixed height for alignment
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xFF020617),
          borderRadius: BorderRadius.circular(8),
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
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
