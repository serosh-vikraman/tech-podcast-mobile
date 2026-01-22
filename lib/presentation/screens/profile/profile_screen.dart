import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _resumeTextController = TextEditingController();

  // Dropdown values
  String _twinGender = 'Male';
  String _twinAccent = 'US Accent';
  String _interviewerGender = 'Female';
  String _interviewerAccent = 'US Accent';

  @override
  void dispose() {
    _jobTitleController.dispose();
    _bioController.dispose();
    _resumeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030712), // Dark App Background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            24,
            20,
            100,
          ), // Bottom padding for FAB/Navigation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              // Header
              const Text(
                'Twin Profile',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Manage your "Master Profile" context. This data is used by the AI to simulate realistic interviews.',
                style: TextStyle(
                  color: Color(0xFFA3A3A3),
                  fontSize: 14,
                ), // Neutral 400
              ),
              const SizedBox(height: 24),

              // Resume Context Card
              _buildResumeContextCard(),
              const SizedBox(height: 24),

              // Section: Overview
              _buildSectionHeader('Overview', 'Who are you professionally?'),
              const SizedBox(height: 12),
              _buildOverviewCard(),
              const SizedBox(height: 24),

              // Section: Twin Persona
              _buildSectionHeader(
                'Twin Persona',
                'Customize your AI counterpart.',
              ),
              const SizedBox(height: 12),
              _buildPersonaCard(
                title: "Your Twin's Voice",
                subtitle: "How your digital twin sounds.",
                icon: Icons.person_outline,
                genderValue: _twinGender,
                accentValue: _twinAccent,
                onGenderChanged: (v) => setState(() => _twinGender = v!),
                onAccentChanged: (v) => setState(() => _twinAccent = v!),
              ),
              const SizedBox(height: 16),
              _buildPersonaCard(
                title: "Default Interviewer",
                subtitle: "The persona interviewing you.",
                icon: Icons.badge_outlined,
                genderValue: _interviewerGender,
                accentValue: _interviewerAccent,
                onGenderChanged: (v) => setState(() => _interviewerGender = v!),
                onAccentChanged: (v) => setState(() => _interviewerAccent = v!),
                iconColor: const Color(0xFFEF4444),
                borderColor: const Color(0xFFEF4444).withOpacity(0.3),
              ),
              const SizedBox(height: 24),

              // Section: Experience
              _buildSectionHeader('Experience', 'Your professional journey.'),
              const SizedBox(height: 12),
              _buildPlaceholderCard(
                'No experience data parsed yet.',
                Icons.work_outline,
              ),
              const SizedBox(height: 24),

              // Section: Education
              _buildSectionHeader('Education', 'Your academic background.'),
              const SizedBox(height: 12),
              _buildPlaceholderCard(
                'No education data parsed yet.',
                Icons.school_outlined,
              ),
              const SizedBox(height: 24),

              // Section: Data & Resume
              _buildSectionHeader(
                'Data Source',
                'The raw data powering your twin.',
              ),
              const SizedBox(height: 12),
              _buildResumeDataTile(),

              const SizedBox(height: 32),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: Color(0xFF737373), fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildResumeContextCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF171717), // Neutral 900
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF262626)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.upload_file_outlined,
                color: Color(0xFF34D399),
                size: 20,
              ), // Emerald 400
              const SizedBox(width: 8),
              const Text(
                'Resume Context',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Upload your primary CV to auto-fill your profile.',
            style: TextStyle(color: Color(0xFFA3A3A3), fontSize: 13),
          ),
          const SizedBox(height: 16),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {}, // Upload logic
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF404040),
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF262626).withOpacity(0.5),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF059669,
                        ).withOpacity(0.2), // Emerald bg
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cloud_upload_outlined,
                        color: Color(0xFF34D399),
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Tap to Upload PDF/DOCX',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF171717),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF262626)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Current Job Title'),
          _buildTextField(_jobTitleController, 'e.g. Senior Software Engineer'),
          const SizedBox(height: 20),
          _buildLabel('Bio / Professional Summary'),
          _buildTextField(
            _bioController,
            'Short professional bio...',
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonaCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String genderValue,
    required String accentValue,
    required ValueChanged<String?> onGenderChanged,
    required ValueChanged<String?> onAccentChanged,
    Color? iconColor,
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF171717),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor ?? const Color(0xFF262626)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor ?? const Color(0xFF818CF8), size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF737373),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Gender'),
                    _buildDropdown(genderValue, [
                      'Male',
                      'Female',
                    ], onGenderChanged),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Accent'),
                    _buildDropdown(accentValue, [
                      'US Accent',
                      'British Accent',
                      'Australian Accent',
                    ], onAccentChanged),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderCard(String message, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF171717),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF262626)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: const Color(0xFF404040)),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(color: Color(0xFF737373), fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildResumeDataTile() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF171717),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF262626)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: const Text(
            'Resume Raw Text',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: const Text(
            'View or edit the parsed text.',
            style: TextStyle(color: Color(0xFF737373), fontSize: 12),
          ),
          leading: const Icon(Icons.data_object, color: Color(0xFFA3A3A3)),
          childrenPadding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: _resumeTextController,
              maxLines: 10,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'Monospace',
              ),
              decoration: const InputDecoration(
                hintText: 'Paste your full resume content here...',
                hintStyle: TextStyle(color: Color(0xFF525252)),
                filled: true,
                fillColor: Color(0xFF0A0A0A),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF262626)),
                ),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFA3A3A3),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF525252)),
        filled: true,
        fillColor: const Color(0xFF0A0A0A),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF262626)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4F46E5)),
        ),
        contentPadding: const EdgeInsets.all(16),
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
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF262626)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: const Color(0xFF171717),
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF737373),
            size: 20,
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

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5), // Indigo 600
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.delete_outline, size: 20),
          label: const Text('Delete Profile'),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFEF4444), // Red
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ],
    );
  }
}
