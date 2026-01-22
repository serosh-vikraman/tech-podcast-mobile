import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TechBattleScreen extends StatefulWidget {
  const TechBattleScreen({super.key});

  @override
  State<TechBattleScreen> createState() => _TechBattleScreenState();
}

class _TechBattleScreenState extends State<TechBattleScreen> {
  final _contenderAController = TextEditingController(text: 'e.g. React');
  final _contenderBController = TextEditingController(text: 'e.g. Vue');
  final _contextController = TextEditingController();

  String _duration = 'Standard Bout (~5m)';
  String _hostAccent = 'us American';

  @override
  void dispose() {
    _contenderAController.dispose();
    _contenderBController.dispose();
    _contextController.dispose();
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
            Icon(Icons.compare_arrows, color: Color(0xFFEF4444), size: 24),
            SizedBox(width: 8),
            Text(
              "Tech Stack Battle",
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
                'Settle the debate once and for all. Two AI hosts, two technologies, one winner.',
                style: TextStyle(color: Color(0xFFA3A3A3), fontSize: 13),
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Inputs
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel(
                                    'Contender A (Left Corner)',
                                    const Color(0xFFF87171),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildTextField(_contenderAController),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel(
                                    'Contender B (Right Corner)',
                                    const Color(0xFF60A5FA),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildTextField(_contenderBController),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildLabel(
                          'Battle Context (Optional)',
                          const Color(0xFFF59E0B),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _contextController,
                          maxLines: 4,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                "e.g. Focus on performance in 2024 and server-side rendering support...",
                            hintStyle: const TextStyle(
                              color: Color(0xFF475569),
                              fontSize: 12,
                            ),
                            filled: true,
                            fillColor: const Color(0xFF020617),
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
                                color: Color(0xFFEF4444),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Duration', Colors.white),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF020617),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: const Color(0xFF1E293B),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: _duration,
                                              dropdownColor: const Color(
                                                0xFF0F172A,
                                              ),
                                              isExpanded: true,
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Color(0xFF64748B),
                                                size: 16,
                                              ),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                              items: ['Standard Bout (~5m)']
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(e),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (_) {},
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.lock,
                                          color: Color(0xFFF59E0B),
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Host Accent', Colors.white),
                                  const SizedBox(height: 8),
                                  _buildDropdown(_hostAccent, ['us American']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Right: Info Cards
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        _buildInfoCard(
                          Icons.balance,
                          'Unbiased Analysis',
                          'Our AI hosts analyze benchmarks, community sentiment, and documentation to give a fair fight.',
                          const Color(0xFF818CF8),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          Icons.emoji_events,
                          'Clear Verdict',
                          'No "it depends" cop-outs. We tell you exactly when to pick which stack.',
                          const Color(0xFFFBBF24),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          Icons.warning_amber,
                          'Gotchas Revealed',
                          'We expose the hidden complexities and rough edges of each technology.',
                          const Color(0xFFF87171),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.sports_kabaddi, size: 18),
                  label: const Text('Start The Battle'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEA580C), // Orange-600
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
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

  Widget _buildLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
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
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
      ),
    );
  }

  Widget _buildDropdown(String value, List<String> items) {
    return GestureDetector(
      onTap: () {
        if (items.isEmpty) return;
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF020617),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF1E293B)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 13),
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

  Widget _buildInfoCard(IconData icon, String title, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10),
          ),
        ],
      ),
    );
  }
}
