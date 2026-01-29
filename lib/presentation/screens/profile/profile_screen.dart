import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _jobTitleController = TextEditingController(
    text: 'Associate Consultant / Solution Architect',
  );
  final TextEditingController _bioController = TextEditingController(
    text:
        'Innovative and results-driven Technical Lead and Solution Architect with over 18 years of experience in architecting, designing, and delivering enterprise-grade applications using Microsoft and Azure technologies.',
  );

  // Twin Persona State
  String _twinGender = 'Male';
  String _twinAccent = 'EN - United States';

  // Interviewer Persona State
  String _interviewerGender = 'Female';
  String _interviewerAccent = 'EN - United States';

  final List<String> _skills = [
    'Azure App Services',
    'Azure Functions',
    'Azure Storage',
    'Azure SQL',
    'Azure Cognitive Services',
    'LUIS',
    'Computer Vision',
    'Azure DevOps',
    'CI/CD',
    'YAML Pipelines',
    'REST',
    'Web API',
    'ASP.NET Core',
    'Agile',
    'Scrum',
  ];

  final List<Map<String, String>> _accents = [
    {'name': 'EN - United States', 'flag': '🇺🇸'},
    {'name': 'EN - United Kingdom', 'flag': '🇬🇧'},
    {'name': 'EN - India', 'flag': '🇮🇳'},
    {'name': 'EN - Australia', 'flag': '🇦🇺'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _jobTitleController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // NO Scaffold - DashboardScreen provides it
    return ColoredBox(
      color: const Color(0xFF030712),
      child: SafeArea(
        child: Column(
          children: [
            // Top Section: Data Ingestion Port
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildIngestionPort(),
            ),

            // Tabs
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              indicatorColor: const Color(0xFF6366F1), // Indigo
              labelColor: const Color(0xFF818CF8),
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Twin Persona'),
                Tab(text: 'Interviewer Persona'),
                Tab(text: 'Experience'),
                Tab(text: 'Education'),
                Tab(text: 'Twin Brain Dump'),
              ],
            ),
            const Divider(color: Color(0xFF1F2937), height: 1),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(),
                  _buildTwinPersonaTab(),
                  _buildInterviewerPersonaTab(),
                  _buildPlaceholderTab('Experience Data'),
                  _buildPlaceholderTab('Education Data'),
                  _buildPlaceholderTab('Raw Resume Text'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets ---

  Widget _buildIngestionPort() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.cloud_upload_outlined,
              color: Color(0xFF60A5FA), // Blue
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Ingestion Port',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Upload Resume (PDF/DOCX) to overwrite current memory banks.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F2937),
              foregroundColor: const Color(0xFF818CF8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Color(0xFF374151)),
              ),
            ),
            child: const Text(
              'INITIATE UPLOAD',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // --- Tab 1: Overview ---
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Layout: On mobile, we stack the Profile Card and the Overview content.
          // Screenshot shows 2 columns. We'll do a simple Column here.

          // Identity Section Header
          const Text(
            'Who are you?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'This context defines the core professional identity of your twin.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 24),

          // Profile Card (Left side in screenshot)
          _buildProfileCard(),
          const SizedBox(height: 24),

          // Twin Brain Card
          _buildTwinBrainCard(),
          const SizedBox(height: 24),

          // Form Fields (Right side in screenshot)
          _buildLabel('Current Job Title'),
          _buildTextField(_jobTitleController),
          const SizedBox(height: 16),

          _buildLabel('Bio / Professional Summary'),
          _buildTextField(_bioController, maxLines: 5),
          const SizedBox(height: 24),

          // Skills
          _buildLabel('Detected Skills'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _skills.map((skill) => _buildSkillChip(skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1219), // Darker Navy
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF6366F1).withOpacity(0.3),
                  ),
                  color: const Color(0xFF111827),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.green, // Active dot? or just decorative
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'YOUR TWIN',
            style: TextStyle(
              color: Color(0xFF818CF8),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$_twinGender • $_twinAccent • AI Replica',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 24),

          // Active Design Stat
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIVE DESIGN',
                      style: TextStyle(
                        color: const Color(0xFF6366F1),
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$_twinGender / US',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.flash_on, color: Color(0xFF6366F1), size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwinBrainCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1219),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.psychology, color: Colors.white60, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'TWIN BRAIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.info_outline,
                color: Colors.white.withOpacity(0.3),
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Placeholder for Brain Visual
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.purple.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: const Center(
                child: Icon(Icons.hub, color: Color(0xFF818CF8), size: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Tab 2: Twin Persona ---
  Widget _buildTwinPersonaTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Twin Gender'),
          Row(
            children: [
              Expanded(
                child: _buildGenderChoice(
                  'Male',
                  _twinGender,
                  (v) => setState(() => _twinGender = v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildGenderChoice(
                  'Female',
                  _twinGender,
                  (v) => setState(() => _twinGender = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildLabel('Twin Accent'),
          ..._accents.map(
            (accent) => _buildAccentTile(
              accent,
              _twinAccent,
              (v) => setState(() => _twinAccent = v),
            ),
          ),
        ],
      ),
    );
  }

  // --- Tab 3: Interviewer Persona ---
  Widget _buildInterviewerPersonaTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Interviewer Gender'),
          Row(
            children: [
              Expanded(
                child: _buildGenderChoice(
                  'Male',
                  _interviewerGender,
                  (v) => setState(() => _interviewerGender = v),
                  isPink: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildGenderChoice(
                  'Female',
                  _interviewerGender,
                  (v) => setState(() => _interviewerGender = v),
                  isPink: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildLabel('Interviewer Accent'),
          ..._accents.map(
            (accent) => _buildAccentTile(
              accent,
              _interviewerAccent,
              (v) => setState(() => _interviewerAccent = v),
              isPink: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderTab(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.build, size: 48, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  // --- Common Widgets ---
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF0F1219),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF374151)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF374151)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF6366F1)),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A8A).withOpacity(0.5), // Blue/Indigo tint
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF93C5FD),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildGenderChoice(
    String label,
    String groupValue,
    ValueChanged<String> onChanged, {
    bool isPink = false,
  }) {
    final isSelected = groupValue == label;
    final activeColor = isPink
        ? const Color(0xFFEC4899)
        : const Color(0xFF6366F1);

    return InkWell(
      onTap: () => onChanged(label),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withOpacity(0.2)
              : const Color(0xFF0F1219),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? activeColor : const Color(0xFF374151),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAccentTile(
    Map<String, String> accent,
    String groupValue,
    ValueChanged<String> onChanged, {
    bool isPink = false,
  }) {
    final isSelected = groupValue == accent['name'];
    final activeColor = isPink
        ? const Color(0xFFEC4899)
        : const Color(0xFF6366F1);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () => onChanged(accent['name']!),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? activeColor.withOpacity(0.1)
                : const Color(0xFF0F1219),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? activeColor : const Color(0xFF374151),
            ),
          ),
          child: Row(
            children: [
              Text(accent['flag']!, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  accent['name']!,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontSize: 13,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected) Icon(Icons.check, color: activeColor, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
