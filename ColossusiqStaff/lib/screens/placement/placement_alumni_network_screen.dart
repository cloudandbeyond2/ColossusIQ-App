import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PLACEMENT OFFICER: ALUMNI NETWORK & MENTORSHIP PIPELINE SCREEN
// Matches Images 3, 4, 5:
// - Blueprint grid hero banner with breadcrumbs & badges (CAMPUS LIFE, Phase 3)
// - 4 Metric KPI Stat Cards (Alumni Mentors, Available Now, Active Requests, Top Employers)
// - Tabs: "Alumni Mentors" (8) and "Mentorship Requests" (1) + "+ Add Alumni Mentor"
// - Dialog Modal (Image 3): Register New Alumni Mentor with full form & Save action
// - Dialog Modal (Image 4): Request Mentorship with <Name> with details, topic, mode, goals & Send action
// - Tab 0: Table with Match scores & interactive "Request" buttons
// - Tab 1: Pipeline (Image 5) with Mentorship Requests Pipeline (1), Pending badges & Cancel Request action
// =============================================================================

class PlacementAlumniNetworkScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PlacementAlumniNetworkScreen({super.key, this.onBack});

  @override
  State<PlacementAlumniNetworkScreen> createState() =>
      _PlacementAlumniNetworkScreenState();
}

class _PlacementAlumniNetworkScreenState
    extends State<PlacementAlumniNetworkScreen> {
  int _selectedTab = 0; // 0: Alumni Mentors, 1: Mentorship Requests
  final TextEditingController _searchController = TextEditingController();
  String _selectedTopic = 'All Topics';
  bool _availableOnly = false;

  final List<String> _topics = [
    'All Topics',
    'Placement Prep',
    'Mock Interviews & System Design',
    'Resume Review & Startups',
    'ML & Analytics Career Guidance',
  ];

  final List<Map<String, dynamic>> _alumni = [
    {
      'initials': 'KS',
      'name': 'Karthik Sharma',
      'location': 'Bengaluru, India',
      'batch': 'Batch 2021',
      'position': 'System Analyst',
      'company': 'Microsoft',
      'topic': 'Placement Prep',
      'badgeColor': const Color(0xFF0D9488),
      'badgeBg': const Color(0xFFCCFBF1),
      'match': 85,
      'available': true,
    },
    {
      'initials': 'AK',
      'name': 'Anand Kumar',
      'location': 'Hyderabad, India',
      'batch': 'Batch 2019',
      'position': 'Tech Lead',
      'company': 'Microsoft',
      'topic': 'Mock Interviews & System Design',
      'badgeColor': const Color(0xFF7C3AED),
      'badgeBg': const Color(0xFFEDE9FE),
      'match': 85,
      'available': true,
    },
    {
      'initials': 'NS',
      'name': 'Nikhil Sharma',
      'location': 'Bengaluru, India',
      'batch': 'Batch 2021',
      'position': 'Data Scientist',
      'company': 'Amazon',
      'topic': 'Resume Review & Startups',
      'badgeColor': const Color(0xFFD97706),
      'badgeBg': const Color(0xFFFEF3C7),
      'match': 85,
      'available': true,
    },
    {
      'initials': 'FN',
      'name': 'Fathima Nair',
      'location': 'Chennai, India',
      'batch': 'Batch 2021',
      'position': 'Product Manager',
      'company': 'Amazon',
      'topic': 'ML & Analytics Career Guidance',
      'badgeColor': const Color(0xFF2563EB),
      'badgeBg': const Color(0xFFEFF6FF),
      'match': 85,
      'available': true,
    },
    {
      'initials': 'RS',
      'name': 'Revathi Srinivasan',
      'location': 'Bengaluru, India',
      'batch': 'Batch 2019',
      'position': 'Tech Lead',
      'company': 'IBM',
      'topic': 'Placement Prep',
      'badgeColor': const Color(0xFF0D9488),
      'badgeBg': const Color(0xFFCCFBF1),
      'match': 85,
      'available': true,
    },
    {
      'initials': 'RI',
      'name': 'Rohan Iyer',
      'location': 'Bengaluru / Singapore',
      'batch': 'Batch 2022',
      'position': 'Data Scientist',
      'company': 'Google',
      'topic': 'ML & Analytics Career Guidance',
      'badgeColor': const Color(0xFF2563EB),
      'badgeBg': const Color(0xFFEFF6FF),
      'match': 85,
      'available': true,
    },
    {
      'initials': 'DP',
      'name': 'Divya Prakash',
      'location': 'Hyderabad, India',
      'batch': 'Batch 2020',
      'position': 'Software Engineer',
      'company': 'Cisco',
      'topic': 'Resume Review & Startups',
      'badgeColor': const Color(0xFFD97706),
      'badgeBg': const Color(0xFFFEF3C7),
      'match': 88,
      'available': true,
    },
    {
      'initials': 'VR',
      'name': 'Vigneshwaran R',
      'location': 'Chennai, India',
      'batch': 'Batch 2018',
      'position': 'Engineering Manager',
      'company': 'Zoho',
      'topic': 'Placement Prep',
      'badgeColor': const Color(0xFF0D9488),
      'badgeBg': const Color(0xFFCCFBF1),
      'match': 92,
      'available': true,
    },
  ];

  // Pipeline requests matching Image 5
  final List<Map<String, dynamic>> _mentorshipRequests = [
    {
      'id': 'REQ-101',
      'mentorName': 'Anand Kumar',
      'company': 'Microsoft',
      'role': 'Tech Lead',
      'batch': 'Batch 2019',
      'department': 'B.E. Computer Science & Engineering',
      'topic': 'Mock Interviews & System Design',
      'mode': 'Virtual Call',
      'requestedDate': '6 Nov 2026',
      'status': 'Pending',
      'questions':
          'Review system design architectures and mock interviews for senior campus recruitment.',
    },
  ];

  // ---------------------------------------------------------------------------
  // Modal 1: Register New Alumni Mentor (Image 3)
  // ---------------------------------------------------------------------------
  void _showRegisterAlumniMentorDialog() {
    final nameCtrl = TextEditingController();
    final batchCtrl = TextEditingController(text: "Batch 2022");
    final companyCtrl = TextEditingController();
    final positionCtrl = TextEditingController();
    final skillsCtrl = TextEditingController();
    final bioCtrl = TextEditingController();
    String area = 'Placement Prep';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header with Title & Close 'X'
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Register New Alumni Mentor",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            icon: const Icon(Icons.close_rounded,
                                size: 20, color: Color(0xFF64748B)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Divider(
                          height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 18),

                      // Alumnus Full Name
                      _buildFieldLabel("Alumnus Full Name"),
                      const SizedBox(height: 6),
                      _buildInputField(
                        controller: nameCtrl,
                        hintText: "e.g. Priyadarshini Sundaram",
                      ),
                      const SizedBox(height: 14),

                      // Batch & Company Row
                      LayoutBuilder(
                        builder: (context, c) {
                          if (c.maxWidth < 420) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel("Batch"),
                                const SizedBox(height: 6),
                                _buildInputField(
                                  controller: batchCtrl,
                                  hintText: "Batch 2022",
                                ),
                                const SizedBox(height: 14),
                                _buildFieldLabel("Company"),
                                const SizedBox(height: 6),
                                _buildInputField(
                                  controller: companyCtrl,
                                  hintText: "e.g. Google",
                                ),
                              ],
                            );
                          }
                          return Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel("Batch"),
                                    const SizedBox(height: 6),
                                    _buildInputField(
                                      controller: batchCtrl,
                                      hintText: "Batch 2022",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFieldLabel("Company"),
                                    const SizedBox(height: 6),
                                    _buildInputField(
                                      controller: companyCtrl,
                                      hintText: "e.g. Google",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 14),

                      // Current Position
                      _buildFieldLabel("Current Position"),
                      const SizedBox(height: 6),
                      _buildInputField(
                        controller: positionCtrl,
                        hintText: "e.g. Senior Software Engineer",
                      ),
                      const SizedBox(height: 14),

                      // Core Mentorship Area
                      _buildFieldLabel("Core Mentorship Area"),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: area,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: Color(0xFF64748B)),
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF0F172A),
                            ),
                            items: _topics
                                .where((t) => t != 'All Topics')
                                .map((t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(t),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setModalState(() => area = val);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Skills (comma-separated)
                      _buildFieldLabel("Skills (comma-separated)"),
                      const SizedBox(height: 6),
                      _buildInputField(
                        controller: skillsCtrl,
                        hintText:
                            "e.g. Python, Machine Learning, AWS, System Design",
                      ),
                      const SizedBox(height: 14),

                      // Short Bio / Background
                      _buildFieldLabel("Short Bio / Background"),
                      const SizedBox(height: 6),
                      _buildInputField(
                        controller: bioCtrl,
                        hintText: "Brief bio about their career journey...",
                        maxLines: 3,
                      ),
                      const SizedBox(height: 22),

                      // Action Buttons: Cancel | Save Alumni Mentor
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              final name = nameCtrl.text.trim();
                              if (name.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Please enter alumnus name.",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }

                              final company = companyCtrl.text.trim().isNotEmpty
                                  ? companyCtrl.text.trim()
                                  : "Tech Enterprise";
                              final batch = batchCtrl.text.trim().isNotEmpty
                                  ? batchCtrl.text.trim()
                                  : "Batch 2022";
                              final pos = positionCtrl.text.trim().isNotEmpty
                                  ? positionCtrl.text.trim()
                                  : "Software Engineer";

                              final initials = name
                                  .split(' ')
                                  .where((s) => s.isNotEmpty)
                                  .map((s) => s[0].toUpperCase())
                                  .take(2)
                                  .join();

                              setState(() {
                                _alumni.insert(0, {
                                  'initials':
                                      initials.isNotEmpty ? initials : 'AL',
                                  'name': name,
                                  'location': 'Bengaluru, India',
                                  'batch': batch,
                                  'position': pos,
                                  'company': company,
                                  'topic': area,
                                  'badgeColor': const Color(0xFF0D9488),
                                  'badgeBg': const Color(0xFFCCFBF1),
                                  'match': 90,
                                  'available': true,
                                });
                              });

                              Navigator.pop(dialogCtx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.check_circle_rounded,
                                          color: Color(0xFF10B981), size: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        "$name registered as an alumni mentor.",
                                        style: GoogleFonts.poppins(fontSize: 12.5),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: const Color(0xFF0F172A),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E2865),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              "Save Alumni Mentor",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Modal 2: Request Mentorship with <Mentor> (Image 4)
  // ---------------------------------------------------------------------------
  void _showRequestMentorshipDialog(Map<String, dynamic> mentor) {
    String selectedTopic = mentor['topic'] as String? ?? 'Mock Interviews & System Design';
    if (!_topics.contains(selectedTopic)) {
      selectedTopic = 'Mock Interviews & System Design';
    }
    String selectedMode = 'Virtual Call';
    final goalsCtrl = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header with Title & Close 'X'
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Request Mentorship with ${mentor['name']}",
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            icon: const Icon(Icons.close_rounded,
                                size: 20, color: Color(0xFF64748B)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(
                          height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 16),

                      // Beige Mentor Summary Card (Image 4)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBF8F2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFF2ECE1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${mentor['position']} at ${mentor['company']}",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${mentor['batch']} • B.E. Computer Science & Engineering",
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Mentorship Topic
                      _buildFieldLabel("Mentorship Topic"),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedTopic,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: Color(0xFF64748B)),
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF0F172A),
                            ),
                            items: _topics
                                .where((t) => t != 'All Topics')
                                .map((t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(t),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setModalState(() => selectedTopic = val);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Preferred Mode
                      _buildFieldLabel("Preferred Mode"),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedMode,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: Color(0xFF64748B)),
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: const Color(0xFF0F172A),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "Virtual Call",
                                child: Text("Virtual Call"),
                              ),
                              DropdownMenuItem(
                                value: "In-Person",
                                child: Text("In-Person"),
                              ),
                              DropdownMenuItem(
                                value: "Chat / Email",
                                child: Text("Chat / Email"),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setModalState(() => selectedMode = val);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Specific Questions or Goals
                      _buildFieldLabel("Specific Questions or Goals"),
                      const SizedBox(height: 6),
                      _buildInputField(
                        controller: goalsCtrl,
                        hintText:
                            "Share your goals (e.g. preparing for technical interview, reviewing resume, or transitioning to data science)...",
                        maxLines: 4,
                      ),
                      const SizedBox(height: 14),

                      // Informational note box (Image 4)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          "✓ Once submitted, your request is forwarded to the mentor and saved in your institution's alumni mentorship pipeline.",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF475569),
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Action Buttons: Cancel | Send Request
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              final questions = goalsCtrl.text.trim();
                              setState(() {
                                _mentorshipRequests.insert(0, {
                                  'id':
                                      'REQ-${DateTime.now().millisecondsSinceEpoch}',
                                  'mentorName': mentor['name'],
                                  'company': mentor['company'],
                                  'role': mentor['position'],
                                  'batch': mentor['batch'],
                                  'department':
                                      'B.E. Computer Science & Engineering',
                                  'topic': selectedTopic,
                                  'mode': selectedMode,
                                  'requestedDate': 'Today',
                                  'status': 'Pending',
                                  'questions': questions.isNotEmpty
                                      ? questions
                                      : 'Comprehensive guidance on $selectedTopic.',
                                });
                                _selectedTab = 1; // Switch to requests tab
                              });

                              Navigator.pop(dialogCtx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.check_circle_rounded,
                                          color: Color(0xFF10B981), size: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Mentorship request forwarded to ${mentor['name']}.",
                                        style: GoogleFonts.poppins(fontSize: 12.5),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: const Color(0xFF0F172A),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E2865),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              "Send Request",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF0F172A),
      ),
    );
  }

  static Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: 12.5,
        color: const Color(0xFF0F172A),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 12,
          color: const Color(0xFF94A3B8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeroBanner(),
              const SizedBox(height: 16),
              _buildKpiStatRow(),
              const SizedBox(height: 16),
              _buildTabAndActionHeader(),
              const SizedBox(height: 14),
              if (_selectedTab == 0) ...[
                _buildSearchAndFilters(),
                const SizedBox(height: 14),
                _buildMentorsTable(),
              ] else ...[
                if (_mentorshipRequests.isNotEmpty)
                  _buildMentorshipRequestsPipeline()
                else
                  _buildMentorshipRequestsEmptyState(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. TOP HERO BANNER (Image 4)
  // ---------------------------------------------------------------------------
  Widget _buildTopHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF161E4A),
            Color(0xFF223075),
            Color(0xFF2E3D8F),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomPaint(
                painter: _AlumniBlueprintGridPainter(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (widget.onBack != null) ...[
                      IconButton(
                        onPressed: widget.onBack,
                        icon: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Text(
                      'Home  ›  Placement  ›  Alumni Network',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: Colors.white.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'CAMPUS LIFE',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD97706),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Phase 3',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: const Icon(
                        Icons.school_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alumni Mentorship Network',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Connect students with alumni mentors at Microsoft, Amazon, Google, IBM and top tech companies.',
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: Colors.white.withValues(alpha: 0.8),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. 4 METRIC KPI STAT CARDS
  // ---------------------------------------------------------------------------
  Widget _buildKpiStatRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 960;
        final isTablet =
            constraints.maxWidth >= 540 && constraints.maxWidth < 960;

        final cards = [
          _buildStatCard(
            title: 'ALUMNI MENTORS',
            value: '${_alumni.length}',
            badgeText: 'verified',
            badgeBg: const Color(0xFFE2E8F0),
            badgeColor: const Color(0xFF475569),
            footer: 'across 4 departments',
            icon: Icons.people_alt_outlined,
          ),
          _buildStatCard(
            title: 'AVAILABLE NOW',
            value: '${_alumni.where((a) => a['available'] == true).length}',
            badgeText: 'open',
            badgeBg: const Color(0xFFCCFBF1),
            badgeColor: const Color(0xFF0D9488),
            footer: 'taking 1-on-1 requests',
            icon: Icons.check_circle_outline,
          ),
          _buildStatCard(
            title: 'ACTIVE REQUESTS',
            value: '${_mentorshipRequests.length}',
            badgeText: 'pipeline',
            badgeBg: const Color(0xFFFEF3C7),
            badgeColor: const Color(0xFFD97706),
            footer: 'pending mentor review',
            icon: Icons.hourglass_empty_rounded,
          ),
          _buildStatCard(
            title: 'TOP EMPLOYERS',
            value: '4',
            badgeText: 'top tier',
            badgeBg: const Color(0xFFF1F5F9),
            badgeColor: const Color(0xFF475569),
            footer: 'Google, MSFT, Amazon, IBM',
            icon: Icons.business_outlined,
          ),
        ];

        if (isDesktop) {
          return Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 12),
              Expanded(child: cards[1]),
              const SizedBox(width: 12),
              Expanded(child: cards[2]),
              const SizedBox(width: 12),
              Expanded(child: cards[3]),
            ],
          );
        } else if (isTablet) {
          return Column(
            children: [
              Row(children: [
                Expanded(child: cards[0]),
                const SizedBox(width: 12),
                Expanded(child: cards[1]),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: cards[2]),
                const SizedBox(width: 12),
                Expanded(child: cards[3]),
              ]),
            ],
          );
        } else {
          return Column(
            children: [
              cards[0],
              const SizedBox(height: 10),
              cards[1],
              const SizedBox(height: 10),
              cards[2],
              const SizedBox(height: 10),
              cards[3],
            ],
          );
        }
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String badgeText,
    required Color badgeBg,
    required Color badgeColor,
    required String footer,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badgeText,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            footer,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. TABS AND "+ Add Alumni Mentor" (Images 4 & 5)
  // ---------------------------------------------------------------------------
  Widget _buildTabAndActionHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 620;
        final tabsRow = SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTabPill(
                title: 'Alumni Mentors',
                count: '${_alumni.length}',
                isSelected: _selectedTab == 0,
                onTap: () => setState(() => _selectedTab = 0),
              ),
              const SizedBox(width: 8),
              _buildTabPill(
                title: 'Mentorship Requests',
                count: '${_mentorshipRequests.length}',
                isSelected: _selectedTab == 1,
                onTap: () => setState(() => _selectedTab = 1),
              ),
            ],
          ),
        );

        final addBtn = ElevatedButton.icon(
          onPressed: _showRegisterAlumniMentorDialog,
          icon: const Icon(Icons.add, size: 15),
          label: Text(
            'Add Alumni Mentor',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2865),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              tabsRow,
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: addBtn,
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: tabsRow),
            const SizedBox(width: 12),
            addBtn,
          ],
        );
      },
    );
  }

  Widget _buildTabPill({
    required String title,
    required String count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E2865) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? null
              : Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.2)
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. SEARCH AND FILTERS (Tab 0)
  // ---------------------------------------------------------------------------
  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 700;

          final searchField = SizedBox(
            height: 38,
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              style: GoogleFonts.poppins(fontSize: 12),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search,
                    size: 16, color: Color(0xFF94A3B8)),
                hintText: 'Search mentors by name, role, company or skill...',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF94A3B8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
          );

          final topicDropdown = Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedTopic,
                icon: const Icon(Icons.keyboard_arrow_down,
                    size: 16, color: Color(0xFF64748B)),
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF0F172A),
                ),
                items: _topics
                    .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(t),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedTopic = val);
                  }
                },
              ),
            ),
          );

          final availableCheckbox = InkWell(
            onTap: () => setState(() => _availableOnly = !_availableOnly),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: _availableOnly,
                    onChanged: (v) =>
                        setState(() => _availableOnly = v ?? false),
                    activeColor: const Color(0xFF1E2865),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Available only',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchField,
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: topicDropdown),
                    const SizedBox(width: 10),
                    availableCheckbox,
                  ],
                ),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: searchField),
              const SizedBox(width: 12),
              topicDropdown,
              const SizedBox(width: 14),
              availableCheckbox,
            ],
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 5. MENTORS DIRECTORY TABLE (Tab 0)
  // ---------------------------------------------------------------------------
  Widget _buildMentorsTable() {
    final query = _searchController.text.toLowerCase().trim();
    final filtered = _alumni.where((a) {
      if (_availableOnly && a['available'] != true) return false;
      if (_selectedTopic != 'All Topics' && a['topic'] != _selectedTopic) {
        return false;
      }
      if (query.isNotEmpty) {
        final name = (a['name'] as String).toLowerCase();
        final company = (a['company'] as String).toLowerCase();
        final position = (a['position'] as String).toLowerCase();
        if (!name.contains(query) &&
            !company.contains(query) &&
            !position.contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 880),
            child: DataTable(
              headingRowHeight: 40,
              dataRowMaxHeight: 56,
              dataRowMinHeight: 52,
              headingRowColor:
                  WidgetStateProperty.all(const Color(0xFFF8FAFC)),
              columns: [
                DataColumn(
                  label: Text(
                    'NAME & ROLE',
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'BATCH',
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'CURRENT POSITION',
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'COMPANY',
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'CAN MENTOR IN',
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'MATCH SCORE',
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ACTION',
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
              rows: filtered.map((a) {
                return DataRow(
                  cells: [
                    // NAME & ROLE
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: const Color(0xFF1E2865),
                            child: Text(
                              a['initials'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                a['name'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                a['location'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // BATCH
                    DataCell(
                      Text(
                        a['batch'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                    // CURRENT POSITION
                    DataCell(
                      Text(
                        a['position'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    // COMPANY
                    DataCell(
                      Text(
                        a['company'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    // CAN MENTOR IN
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: a['badgeBg'] as Color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          a['topic'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: a['badgeColor'] as Color,
                          ),
                        ),
                      ),
                    ),
                    // MATCH SCORE
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 65,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (a['match'] as int) / 100.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D9488),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${a['match']}%",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0D9488),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ACTION (Opens Request Modal - Image 4)
                    DataCell(
                      OutlinedButton(
                        onPressed: () => _showRequestMentorshipDialog(a),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Request',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 6. TAB 1: MENTORSHIP REQUESTS PIPELINE (Matching Image 5)
  // ---------------------------------------------------------------------------
  Widget _buildMentorshipRequestsPipeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header (Matching Image 5)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Mentorship Requests Pipeline (${_mentorshipRequests.length})",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            Text(
              "Status updates automatically with mentor response",
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // List of Active Pipeline Requests
        for (int i = 0; i < _mentorshipRequests.length; i++) ...[
          _buildPipelineCard(_mentorshipRequests[i], i),
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  Widget _buildPipelineCard(Map<String, dynamic> req, int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 620;

          final contentCol = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mentor Name & Company + Status Badge
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: req['mentorName'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        TextSpan(
                          text: " (${req['company']})",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      req['status'] as String? ?? "Pending",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFD97706),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Metadata line: Topic • Mode • Requested
              Text(
                "Topic: ${req['topic']}   •   Mode: ${req['mode']}   •   Requested: ${req['requestedDate']}",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          );

          final cancelBtn = OutlinedButton(
            onPressed: () {
              final removed = _mentorshipRequests[index];
              setState(() {
                _mentorshipRequests.removeAt(index);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Request to ${removed['mentorName']} cancelled.",
                    style: GoogleFonts.poppins(),
                  ),
                  action: SnackBarAction(
                    label: "Undo",
                    textColor: const Color(0xFF38BDF8),
                    onPressed: () {
                      setState(() {
                        _mentorshipRequests.insert(index, removed);
                      });
                    },
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFFCA5A5)),
              foregroundColor: const Color(0xFFDC2626),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Cancel Request",
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFB91C1C),
              ),
            ),
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contentCol,
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: cancelBtn,
                ),
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: contentCol),
              const SizedBox(width: 14),
              cancelBtn,
            ],
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 7. TAB 1: EMPTY STATE FALLBACK
  // ---------------------------------------------------------------------------
  Widget _buildMentorshipRequestsEmptyState() {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mark_email_unread_outlined,
                  size: 38, color: Color(0xFF94A3B8)),
              const SizedBox(height: 12),
              Text(
                'No active mentorship requests',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Explore verified alumni mentors in the directory and request a 1-on-1 session or resume guidance.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () => setState(() => _selectedTab = 0),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Browse Alumni Mentors',
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Blueprint faint grid painter for top banner
class _AlumniBlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 0.8;

    const step = 24.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
