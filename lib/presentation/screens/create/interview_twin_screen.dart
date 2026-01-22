import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InterviewTwinScreen extends StatefulWidget {
  const InterviewTwinScreen({super.key});

  @override
  State<InterviewTwinScreen> createState() => _InterviewTwinScreenState();
}

class _InterviewTwinScreenState extends State<InterviewTwinScreen> {
  // Controllers
  final _podcastNameController = TextEditingController(
    text: 'Interview Twin ${DateTime.now().toString().split(' ')[0]}',
  );
  final _jdController = TextEditingController();
  final _yourNameController = TextEditingController(text: 'John Doe');

  // State
  String _selectedTopic = 'Tell me about yourself';
  bool _useMasterProfile = true;
  String _yourVoice = 'Male';
  String _yourAccent = 'US';
  String _difficulty = 'Medium';
  String _interviewer = 'Rachel';
  String _duration = 'Short';

  @override
  void dispose() {
    _podcastNameController.dispose();
    _jdController.dispose();
    _yourNameController.dispose();
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
          'The Interview Twin',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Generate a realistic, role-play interview with your digital twin tailored to your resume. Choose your difficulty and listener persona.',
                style: TextStyle(color: Color(0xFFA3A3A3), fontSize: 13),
              ),
              const SizedBox(height: 24),

              // 1. Podcast Name & Topic
              _buildSectionTitle('1', 'Podcast Name & Topic'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Podcast Name (Required)'),
                    const SizedBox(height: 8),
                    _buildTextField(_podcastNameController, ''),
                    const SizedBox(height: 16),
                    _buildLabel('Choose Topic'),
                    const SizedBox(height: 8),
                    _buildDropdown(_selectedTopic, [
                      'Tell me about yourself',
                      'System Design',
                      'Behavioral',
                      'Coding Challenge',
                    ], (v) => setState(() => _selectedTopic = v!)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Add Context
              _buildSectionTitle('2', 'Add Context'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    // Toggle Switch
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A), // Slate 900
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF1E293B)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _useMasterProfile = true),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: _useMasterProfile
                                      ? const Color(0xFF059669)
                                      : Colors.transparent, // Emerald
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Use Master Profile',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: _useMasterProfile
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _useMasterProfile = false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: !_useMasterProfile
                                      ? const Color(0xFF059669)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Upload Specific Resume',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: !_useMasterProfile
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Profile Status Card
                    if (_useMasterProfile) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF1E293B)),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(0xFF059669),
                              radius: 18,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Your Profile',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF10B981,
                                          ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          border: Border.all(
                                            color: const Color(
                                              0xFF10B981,
                                            ).withOpacity(0.2),
                                          ),
                                        ),
                                        child: const Text(
                                          'READY',
                                          style: TextStyle(
                                            color: Color(0xFF10B981),
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    'No Job Title Set',
                                    style: TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.flash_on,
                                        color: Color(0xFFF59E0B),
                                        size: 12,
                                      ), // Amber
                                      SizedBox(width: 4),
                                      Text(
                                        'Profile not found. Using generic context.',
                                        style: TextStyle(
                                          color: Color(0xFFF59E0B),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      // Placeholder for upload UI
                      Container(
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF334155),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Tap to upload Resume (PDF)',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    _buildLabel('Job Description (Optional)'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _jdController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: _inputDecoration(
                        'Paste the JD here to tailor the interview to a specific role...',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 3. Your Persona
              _buildSectionTitle('3', 'Your Persona'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Your Name'),
                          const SizedBox(height: 8),
                          _buildTextField(_yourNameController, ''),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Your Voice'),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDropdown(_yourVoice, [
                                  'Male',
                                  'Female',
                                ], (v) => setState(() => _yourVoice = v!)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildDropdown(
                                  _yourAccent,
                                  ['US', 'UK', 'IN', 'AU'],
                                  (v) => setState(() => _yourAccent = v!),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E293B),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFF334155),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.volume_up,
                                  color: Color(0xFF94A3B8),
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4. Difficulty Level
              _buildSectionTitle('4', 'Difficulty Level'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildSelectableCard(
                        'Easy',
                        'Supportive & Helpful',
                        _difficulty == 'Easy',
                        () => setState(() => _difficulty = 'Easy'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSelectableCard(
                        'Medium',
                        'Standard Interview',
                        _difficulty == 'Medium',
                        () => setState(() => _difficulty = 'Medium'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSelectableCard(
                        'Hard',
                        'Grilling Mode',
                        _difficulty == 'Hard',
                        () => setState(() => _difficulty = 'Hard'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 5. Choose Interviewer
              _buildSectionTitle('5', 'Choose Interviewer'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    _buildInterviewerCard(
                      'Rachel',
                      'US',
                      '🇺🇸',
                      const Color(0xFF3B82F6),
                    ),
                    const SizedBox(width: 12),
                    _buildInterviewerCard(
                      'Lucy',
                      'UK',
                      '🇬🇧',
                      const Color(0xFFEF4444),
                    ),
                    const SizedBox(width: 12),
                    _buildInterviewerCard(
                      'Sita',
                      'India',
                      '🇮🇳',
                      const Color(0xFFF97316),
                    ),
                    const SizedBox(width: 12),
                    _buildInterviewerCard(
                      'Ella',
                      'Aus',
                      '🇦🇺',
                      const Color(0xFF10B981),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 6. Duration
              _buildSectionTitle('6', 'Duration'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildDurationCard(
                        'Short (~3 min)',
                        'Quick warmup',
                        true,
                        false,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDurationCard(
                        'Standard (~15 min)',
                        'Full interview',
                        false,
                        true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDurationCard(
                        'Deep Dive (~20 min)',
                        'Detailed analysis',
                        false,
                        true,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Footer Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Activate logic using duration
                    debugPrint(
                      'Activating Interview Twin with duration: $_duration',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF059669), // Emerald 600
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.play_arrow, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Activate Interview Twin',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionTitle(String number, String title) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B), // Slate 800
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF334155)),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFF0F172A).withOpacity(0.5), // Slate 900 / 50%
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF1E293B)),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF94A3B8),
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: _inputDecoration(hint),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF475569)),
      filled: true,
      fillColor: const Color(0xFF020617), // Slate 950
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        borderSide: const BorderSide(color: Color(0xFF3B82F6)),
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

  Widget _buildSelectableCard(
    String title,
    String subtitle,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1E3A8A).withOpacity(0.3)
              : const Color(0xFF020617),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B82F6)
                : const Color(0xFF1E293B),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: const Color(0xFF64748B), fontSize: 10),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterviewerCard(
    String name,
    String country,
    String flag,
    Color color,
  ) {
    final bool isSelected = _interviewer == name;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _interviewer = name),
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: const Color(0xFF020617),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6366F1)
                  : const Color(0xFF1E293B),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundColor: color,
                    radius: 20,
                    child: Text(
                      name[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 14,
                    height: 14,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0F172A),
                      shape: BoxShape.circle,
                    ),
                    child: Text(flag, style: const TextStyle(fontSize: 9)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                country,
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDurationCard(
    String title,
    String subtitle,
    bool isSelected,
    bool isLocked,
  ) {
    return GestureDetector(
      onTap: isLocked
          ? null
          : () => setState(() => _duration = title.split(' ')[0]),
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF020617),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF10B981)
                : const Color(0xFF1E293B),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: isLocked ? 0.5 : 1.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF10B981)
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            if (isLocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF020617).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        color: Color(0xFFF59E0B),
                        size: 20,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'PREMIUM',
                        style: const TextStyle(
                          color: Color(0xFFF59E0B),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
