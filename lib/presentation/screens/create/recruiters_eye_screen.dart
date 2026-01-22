import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecruitersEyeScreen extends StatefulWidget {
  const RecruitersEyeScreen({super.key});

  @override
  State<RecruitersEyeScreen> createState() => _RecruitersEyeScreenState();
}

class _RecruitersEyeScreenState extends State<RecruitersEyeScreen> {
  final _podcastNameController = TextEditingController(
    text: 'Resume Audit - ${DateTime.now().toString().split(' ')[0]}',
  );
  String _duration = 'Short (~3m)';
  String _hostAccent = 'us American';

  @override
  void dispose() {
    _podcastNameController.dispose();
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
        title: Row(
          children: const [
            Icon(Icons.visibility, color: Color(0xFF7C3AED), size: 24),
            SizedBox(width: 8),
            Text(
              "The Recruiter's Eye",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload your resume for a brutally honest audio critique. Two senior recruiters will tear it apart (constructively) to help you improve.',
                style: TextStyle(color: Color(0xFFA3A3A3), fontSize: 13),
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column: Inputs
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Podcast Name *'),
                        const SizedBox(height: 8),
                        _buildTextField(_podcastNameController),
                        const SizedBox(height: 16),
                        _buildLabel('Duration'),
                        const SizedBox(height: 8),
                        _buildDropdown(_duration, [
                          'Short (~3m)',
                          'Deep Dive (~10m)',
                        ], (v) => setState(() => _duration = v!)),
                        const SizedBox(height: 16),
                        _buildLabel('Host Accent'),
                        const SizedBox(height: 8),
                        _buildDropdown(_hostAccent, [
                          'us American',
                          'uk British',
                        ], (v) => setState(() => _hostAccent = v!)),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF1E1B4B,
                            ).withOpacity(0.5), // Dark Violet
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF4C1D95).withOpacity(0.5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'What to expect:',
                                style: TextStyle(
                                  color: Color(0xFFA78BFA),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 8),
                              _BulletPoint(
                                'Feedback on structure & formatting',
                              ),
                              _BulletPoint('Keyword analysis for ATS parsing'),
                              _BulletPoint(
                                '"Red flags" that recruiters spot immediately',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Right Column: Upload
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF1E293B),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E1065),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.description,
                              color: Color(0xFFA78BFA),
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Upload Resume',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Drag & drop or select a PDF/DOCX file.',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.upload_file, size: 16),
                            label: const Text('Select Resume'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7C3AED),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility, size: 18),
                  label: const Text('Start Recruitment Audit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B21B6), // Darker Violet
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
        color: Color(0xFF94A3B8),
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
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
          borderSide: const BorderSide(color: Color(0xFF1E293B)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1E293B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF7C3AED)),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: const Color(0xFF0F172A),
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF64748B),
            size: 16,
          ),
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

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Color(0xFF7C3AED))),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
