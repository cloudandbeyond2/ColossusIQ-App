import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PLACEMENT: PLACEMENT ANALYTICS & INDUSTRY OUTCOMES SCREEN
// Matches Screenshots 1, 2, 3, 4 & 5:
// - Blueprint grid hero banner with analytics watermark, PLACEMENT & Phase 2 badges
// - Section Header: Placement Analytics & Industry Outcomes (AY 2026-27 Cohort, Placement Officer Desk)
//   Actions: Refresh, Export Report (CSV), Set Targets, Hide/Show Related Workflows
// - Related Portals & Action Workflows Across Roles Card (Deep linked)
// - Department Scope Dropdown Filter: All Departments (Institutional)
// - College Placement Goal Card: 86% placed (604 of 702), 6.0% to Target (92%), Targets metrics
// - 6 KPI Metric Cards (Total Offers 538, Highest CTC 44 LPA, Average CTC 9.8 LPA,
//                       Super Dream 76, Dream 152, Seeking Placement 7)
// - 5 Tabs Navigation:
//   1. Executive Overview (Salary CTC Tier Distribution, Campus Recruitment Funnel, Marquee Placement Drives)
//   2. Department League (10) (Department Placement Matrix table)
//   3. Recruiter & Drive Analytics (7) (Campus Recruitment Drives table)
//   4. Readiness & Skill Gaps (5) (Skill gap cards with interventions)
//   5. Placed Student Directory (16) (Directory of placed students)
// - Set Targets Dialog: Edit Placement Goal, Avg CTC Target, Mock Interview Target
// =============================================================================

class PlacementAnalyticsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PlacementAnalyticsScreen({super.key, this.onBack});

  @override
  State<PlacementAnalyticsScreen> createState() =>
      _PlacementAnalyticsScreenState();
}

class _PlacementAnalyticsScreenState extends State<PlacementAnalyticsScreen> {
  String _selectedDepartmentScope = "All Departments (Institutional)";
  bool _hideRelatedWorkflows = false;
  int _selectedTabIndex = 0;

  // Search & Filters
  final TextEditingController _deptSearchCtrl = TextEditingController();
  String _selectedRecruiterTier = "All Tiers";
  final TextEditingController _studentSearchCtrl = TextEditingController();

  // Targets State
  final double _placementPercent = 86.0;
  final int _placedCount = 604;
  final int _totalEligible = 702;
  double _placementTarget = 92.0;
  String _avgCtcTarget = "10.5";
  int _mockInterviewGoal = 95;

  // 10 Departments Data (Image 3)
  final List<Map<String, dynamic>> _departments = [
    {
      "name": "Computer Science & Engineering",
      "code": "CSE",
      "totalEligible": "145 / 138",
      "placed": 128,
      "percent": 92.8,
      "avgCtc": "₹12.4 LPA",
      "highestCtc": "₹44 LPA",
      "readiness": 90,
      "topRecruiter": "Google Apex Engineering",
    },
    {
      "name": "Artificial Intelligence & Data Science",
      "code": "AIDS",
      "totalEligible": "68 / 65",
      "placed": 61,
      "percent": 93.8,
      "avgCtc": "₹11.8 LPA",
      "highestCtc": "₹36.5 LPA",
      "readiness": 91,
      "topRecruiter": "Microsoft Cloud & AI",
    },
    {
      "name": "Information Technology",
      "code": "IT",
      "totalEligible": "113 / 108",
      "placed": 98,
      "percent": 90.7,
      "avgCtc": "₹10.2 LPA",
      "highestCtc": "₹28 LPA",
      "readiness": 88,
      "topRecruiter": "Amazon AWS Autumn",
    },
    {
      "name": "Biomedical Engineering",
      "code": "BME",
      "totalEligible": "54 / 50",
      "placed": 43,
      "percent": 86.0,
      "avgCtc": "₹8.6 LPA",
      "highestCtc": "₹18.5 LPA",
      "readiness": 86,
      "topRecruiter": "MediTech Diagnostics",
    },
    {
      "name": "Electrical & Electronics Engineering",
      "code": "EEE",
      "totalEligible": "72 / 68",
      "placed": 52,
      "percent": 76.5,
      "avgCtc": "₹7.8 LPA",
      "highestCtc": "₹16 LPA",
      "readiness": 78,
      "topRecruiter": "Larsen & Toubro Core",
    },
    {
      "name": "Mechanical Engineering",
      "code": "MECH",
      "totalEligible": "64 / 53",
      "placed": 30,
      "percent": 56.6,
      "avgCtc": "₹6.4 LPA",
      "highestCtc": "₹12 LPA",
      "readiness": 71,
      "topRecruiter": "Tata Motors Automotive",
    },
    {
      "name": "Electronics & Communication",
      "code": "E&C",
      "totalEligible": "60 / 55",
      "placed": 48,
      "percent": 87.3,
      "avgCtc": "₹8.5 LPA",
      "highestCtc": "₹18 LPA",
      "readiness": 82,
      "topRecruiter": "Tata Consultancy Services (TCS)",
    },
    {
      "name": "Electrical & Electronics",
      "code": "E&E",
      "totalEligible": "60 / 55",
      "placed": 48,
      "percent": 87.3,
      "avgCtc": "₹8.5 LPA",
      "highestCtc": "₹18 LPA",
      "readiness": 82,
      "topRecruiter": "Tata Consultancy Services (TCS)",
    },
    {
      "name": "Civil Engineering",
      "code": "CE",
      "totalEligible": "60 / 55",
      "placed": 48,
      "percent": 87.3,
      "avgCtc": "₹8.5 LPA",
      "highestCtc": "₹18 LPA",
      "readiness": 82,
      "topRecruiter": "Tata Consultancy Services (TCS)",
    },
    {
      "name": "Science & Humanities",
      "code": "S&H",
      "totalEligible": "60 / 55",
      "placed": 48,
      "percent": 87.3,
      "avgCtc": "₹8.5 LPA",
      "highestCtc": "₹18 LPA",
      "readiness": 82,
      "topRecruiter": "Tata Consultancy Services (TCS)",
    },
  ];

  // 7 Campus Drives Analytics (Image 4)
  final List<Map<String, dynamic>> _recruiterDrives = [
    {
      "company": "Tata Consultancy Services (TCS)",
      "role": "Digital Innovator & Prime Engineer",
      "tier": "Core",
      "sector": "IT Consulting",
      "ctc": "₹9.5 LPA",
      "registered": 160,
      "shortlisted": 58,
      "offers": 28,
      "conversion": "17.5%",
      "status": "Completed",
    },
    {
      "company": "Zoho Corporation",
      "role": "Software Engineer",
      "tier": "Core",
      "sector": "Technology / Enterprise",
      "ctc": "₹9 LPA",
      "registered": 110,
      "shortlisted": 32,
      "offers": 18,
      "conversion": "16.4%",
      "status": "Completed",
    },
    {
      "company": "Amazon AWS",
      "role": "Associate Cloud Support Engineer",
      "tier": "Super Dream",
      "sector": "Cloud & Infrastructure",
      "ctc": "₹18 LPA",
      "registered": 54,
      "shortlisted": 16,
      "offers": 6,
      "conversion": "11.1%",
      "status": "Active",
    },
    {
      "company": "Google India",
      "role": "Software Development Engineer (SDE-1)",
      "tier": "Super Dream",
      "sector": "Technology / Enterprise",
      "ctc": "₹32.5 LPA",
      "registered": 48,
      "shortlisted": 14,
      "offers": 6,
      "conversion": "12.5%",
      "status": "Active",
    },
    {
      "company": "Microsoft Corporation",
      "role": "Cloud Solution & DevOps Engineer",
      "tier": "Super Dream",
      "sector": "Cloud & Infrastructure",
      "ctc": "₹26 LPA",
      "registered": 65,
      "shortlisted": 20,
      "offers": 8,
      "conversion": "12.3%",
      "status": "Active",
    },
    {
      "company": "L&T Technology Services",
      "role": "Embedded Systems & IoT Engineer",
      "tier": "Core",
      "sector": "Technology / Enterprise",
      "ctc": "₹8 LPA",
      "registered": 195,
      "shortlisted": 36,
      "offers": 14,
      "conversion": "7.2%",
      "status": "Upcoming",
    },
    {
      "company": "Google Apex Engineering",
      "role": "Software Development Engineer (SDE-1)",
      "tier": "Super Dream",
      "sector": "Technology / Cloud",
      "ctc": "₹44 LPA",
      "registered": 168,
      "shortlisted": 24,
      "offers": 8,
      "conversion": "4.8%",
      "status": "Completed",
    },
  ];

  // 5 Readiness & Skill Gaps (Image 5)
  final List<Map<String, dynamic>> _skillGaps = [
    {
      "title": "System Design & Distributed Scalability",
      "tag": "Critical (29%)",
      "tagColor": 0xFFDC2626,
      "tagBg": 0xFFFEE2E2,
      "progress": 0.29,
      "proficient": 103,
      "criticalGaps": 12,
      "intervention":
          "Conduct weekend intensive system design workshops covering microservices caching and Kafka event streams.",
    },
    {
      "title": "Data Structures & Algorithmic Complexity",
      "tag": "Attention (11%)",
      "tagColor": 0xFFD97706,
      "tagBg": 0xFFFEF3C7,
      "progress": 0.55,
      "proficient": 150,
      "criticalGaps": 10,
      "intervention":
          "Active weekly leetcode-style timed contests on ColossusIQ Mock Tests arena.",
    },
    {
      "title": "Technical Mock Interview Communication",
      "tag": "Attention (3%)",
      "tagColor": 0xFFD97706,
      "tagBg": 0xFFFEF3C7,
      "progress": 0.42,
      "proficient": 120,
      "criticalGaps": 15,
      "intervention":
          "Mandate 2 AI viva/mock interview practice sessions per student before upcoming Core drives.",
    },
    {
      "title": "Resume ATS Compliance & Proof Points",
      "tag": "Healthy (12%)",
      "tagColor": 0xFF059669,
      "tagBg": 0xFFDCFCE7,
      "progress": 0.70,
      "proficient": 203,
      "criticalGaps": 8,
      "intervention":
          "12% students have passed resume ATS verification benchmark (70+ score).",
    },
    {
      "title": "Domain & Core Engineering Fundamentals",
      "tag": "Healthy (84%)",
      "tagColor": 0xFF059669,
      "tagBg": 0xFFDCFCE7,
      "progress": 0.84,
      "proficient": 183,
      "criticalGaps": 25,
      "intervention":
          "Strong performance in department coursework and lab practical demonstrations.",
    },
  ];

  // Placed Students Directory (16 Students)
  final List<Map<String, dynamic>> _placedDirectory = [
    {
      "name": "Anand Kumar",
      "roll": "110124001",
      "dept": "Computer Science & Engineering",
      "company": "Tata Consultancy Services (TCS)",
      "tier": "Core",
      "package": "₹9.5 LPA",
      "date": "2026-09-15",
    },
    {
      "name": "Divya M",
      "roll": "110124032",
      "dept": "Computer Science & Engineering",
      "company": "Google Apex Engineering",
      "tier": "Super Dream",
      "package": "₹44.0 LPA",
      "date": "2026-09-22",
    },
    {
      "name": "Priya Sharma",
      "roll": "110124018",
      "dept": "Information Technology",
      "company": "Microsoft Corporation",
      "tier": "Super Dream",
      "package": "₹26.0 LPA",
      "date": "2026-09-28",
    },
    {
      "name": "Karthik Raja",
      "roll": "110124045",
      "dept": "Electronics & Communication",
      "company": "Zoho Corporation",
      "tier": "Core",
      "package": "₹9.0 LPA",
      "date": "2026-10-02",
    },
    {
      "name": "Rahul V",
      "roll": "110124056",
      "dept": "Mechanical Engineering",
      "company": "Tata Motors Automotive",
      "tier": "Core",
      "package": "₹6.4 LPA",
      "date": "2026-10-05",
    },
    {
      "name": "Sneha P",
      "roll": "110124077",
      "dept": "Civil Engineering",
      "company": "L&T Technology Services",
      "tier": "Core",
      "package": "₹8.0 LPA",
      "date": "2026-10-08",
    },
    {
      "name": "Vignesh K",
      "roll": "110124089",
      "dept": "Biomedical Engineering",
      "company": "MediTech Diagnostics",
      "tier": "Dream",
      "package": "₹8.6 LPA",
      "date": "2026-10-10",
    },
    {
      "name": "Swetha R",
      "roll": "110124012",
      "dept": "Artificial Intelligence & Data Science",
      "company": "Microsoft Cloud & AI",
      "tier": "Super Dream",
      "package": "₹36.5 LPA",
      "date": "2026-09-29",
    },
  ];

  // Set Targets Dialog (Image 1 "Set Targets" button)
  void _showSetTargetsDialog() {
    final placementTargetCtrl =
        TextEditingController(text: "$_placementTarget");
    final avgCtcCtrl = TextEditingController(text: _avgCtcTarget);
    final mockGoalCtrl = TextEditingController(text: "$_mockInterviewGoal");

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) => Dialog(
        backgroundColor: Colors.white,
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Set Placement Targets (AY 2026-27)",
                      style: GoogleFonts.poppins(
                        fontSize: 16.5,
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
                const SizedBox(height: 14),
                const Divider(
                    height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 16),
                _buildModalField(
                  label: "Placement Goal (%)",
                  controller: placementTargetCtrl,
                  hint: "e.g. 92",
                ),
                const SizedBox(height: 14),
                _buildModalField(
                  label: "Target Average CTC (LPA)",
                  controller: avgCtcCtrl,
                  hint: "e.g. 10.5",
                ),
                const SizedBox(height: 14),
                _buildModalField(
                  label: "Mock Interview Participation Goal (%)",
                  controller: mockGoalCtrl,
                  hint: "e.g. 95",
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(dialogCtx),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
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
                        setState(() {
                          _placementTarget = double.tryParse(
                                  placementTargetCtrl.text.trim()) ??
                              92.0;
                          _avgCtcTarget = avgCtcCtrl.text.trim().isNotEmpty
                              ? avgCtcCtrl.text.trim()
                              : "10.5";
                          _mockInterviewGoal = int.tryParse(
                                  mockGoalCtrl.text.trim()) ??
                              95;
                        });
                        Navigator.pop(dialogCtx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Placement benchmark targets updated successfully.",
                              style: GoogleFonts.poppins(),
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2865),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 11),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: Text(
                        "Save Targets",
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
      ),
    );
  }

  Widget _buildModalField({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          style: GoogleFonts.poppins(fontSize: 12.5),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
                fontSize: 12, color: const Color(0xFF94A3B8)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
          ),
        ),
      ],
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
              // 1. Top Blueprint Hero Banner (Image 1)
              _buildTopHeroBanner(),
              const SizedBox(height: 20),

              // 2. Section Header with Cohort badge, Desk tag & Action buttons (Image 1)
              _buildSectionHeader(),
              const SizedBox(height: 16),

              // 3. Related Portals & Action Workflows Card (Collapsible - Image 1)
              if (!_hideRelatedWorkflows) ...[
                _buildRelatedWorkflowsCard(),
                const SizedBox(height: 16),
              ],

              // 4. Department Scope Dropdown (Image 1)
              _buildDepartmentScopeSelector(),
              const SizedBox(height: 16),

              // 5. College Placement Goal Bar (Image 1)
              _buildCollegePlacementGoalBar(),
              const SizedBox(height: 16),

              // 6. 6 KPI Metric Cards (Image 2)
              _buildMetricCardsGrid(),
              const SizedBox(height: 20),

              // 7. Navigation Tabs Row (Executive Overview, Department League, etc.)
              _buildNavigationTabs(),
              const SizedBox(height: 18),

              // 8. Tab Contents (Image 2, 3, 4, 5)
              _buildActiveTabContent(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HERO BLUEPRINT BANNER (Matches Image 1)
  // ===========================================================================
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
                painter: _BlueprintGridPainter(),
              ),
            ),
          ),
          Positioned(
            right: -20,
            bottom: -30,
            child: Icon(
              Icons.show_chart_rounded,
              size: 200,
              color: Colors.white.withValues(alpha: 0.04),
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
                      'Home  ›  Placement  ›  Placement Analytics',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: Colors.white.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2865),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        'PLACEMENT',
                        style: GoogleFonts.poppins(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.8,
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
                        'Phase 2',
                        style: GoogleFonts.poppins(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFFF59E0B)
                                .withValues(alpha: 0.4)),
                      ),
                      child: const Icon(
                        Icons.insights_rounded,
                        color: Color(0xFFFBBF24),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Placement Analytics',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Readiness, resume completion, mock-interview participation and offers.',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.8),
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

  // ===========================================================================
  // 2. SECTION HEADER (Matches Image 1)
  // ===========================================================================
  Widget _buildSectionHeader() {
    return LayoutBuilder(
      builder: (context, c) {
        final isNarrow = c.maxWidth < 780;

        final titleCol = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Placement Analytics & Industry Outcomes",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "AY 2026-27 (Graduating Cohort)",
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4338CA),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Placement Officer Desk",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFD97706),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Anna Institute of Technology Chennai · Placement conversion, package tiers, hiring funnels, and department benchmarks.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        );

        final actionButtons = Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: () {
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Analytics cache updated with latest campus recruitment data.",
                      style: GoogleFonts.poppins(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.sync_rounded, size: 14),
              label: Text("Refresh",
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Exporting Placement Analytics Report (CSV)...",
                      style: GoogleFonts.poppins(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.file_download_outlined, size: 14),
              label: Text("Export Report (CSV)",
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _showSetTargetsDialog,
              icon: const Icon(Icons.track_changes_outlined, size: 14),
              label: Text("Set Targets",
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _hideRelatedWorkflows = !_hideRelatedWorkflows;
                });
              },
              icon: const Icon(Icons.link_outlined, size: 14),
              label: Text(
                _hideRelatedWorkflows
                    ? "Show Related Workflows"
                    : "Hide Related Workflows",
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleCol,
              const SizedBox(height: 12),
              actionButtons,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: titleCol),
            const SizedBox(width: 14),
            actionButtons,
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 3. RELATED WORKFLOWS CARD (Matches Image 1)
  // ===========================================================================
  Widget _buildRelatedWorkflowsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBF8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 640;

              final titleRow = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2865),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.north_east_rounded,
                        size: 13, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "Related Portals & Action Workflows Across Roles",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ],
              );

              final subtext = Text(
                "Deep linked to student preparation, drives, and recruiter shortlists",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleRow,
                    const SizedBox(height: 4),
                    subtext,
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleRow,
                  const SizedBox(width: 12),
                  Flexible(child: subtext),
                ],
              );
            },
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, c) {
              final width = c.maxWidth >= 900
                  ? (c.maxWidth - 36) / 4
                  : (c.maxWidth >= 540 ? (c.maxWidth - 12) / 2 : c.maxWidth);

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: width,
                    child: _buildWorkflowPill(
                      icon: Icons.hub_outlined,
                      iconColor: const Color(0xFF0D9488),
                      iconBg: const Color(0xFFCCFBF1),
                      title: "Department Skills ↗",
                      desc: "Launch targeted bridge courses to fix System Design & DSA gaps.",
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _buildWorkflowPill(
                      icon: Icons.people_outline_rounded,
                      iconColor: const Color(0xFF7C3AED),
                      iconBg: const Color(0xFFEDE9FE),
                      title: "Placement Readiness Board ↗",
                      desc: "Filter students by verified readiness and shortlist for upcoming drives.",
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _buildWorkflowPill(
                      icon: Icons.search_rounded,
                      iconColor: const Color(0xFFD97706),
                      iconBg: const Color(0xFFFEF3C7),
                      title: "Recruiter Talent Search ↗",
                      desc: "View how external recruiters discover and shortlist candidate profiles.",
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: _buildWorkflowPill(
                      icon: Icons.calendar_month_outlined,
                      iconColor: const Color(0xFF2563EB),
                      iconBg: const Color(0xFFDBEAFE),
                      title: "Placement Drives ↗",
                      desc: "Schedule campus drives, criteria rules, and registration windows.",
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, thickness: 0.8, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 8),
          Text(
            "Additional Linked Pages: Curriculum Studio (Electives) · Early Warning Alerts · Institutional BI · AICTE Compliance · Recruiter Panels",
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowPill({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: const Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. DEPARTMENT SCOPE SELECTOR (Image 1)
  // ===========================================================================
  Widget _buildDepartmentScopeSelector() {
    final scopes = [
      "All Departments (Institutional)",
      "Computer Science & Engineering (CSE)",
      "Artificial Intelligence & Data Science (AIDS)",
      "Information Technology (IT)",
      "Biomedical Engineering (BME)",
      "Electrical & Electronics Engineering (EEE)",
      "Mechanical Engineering (MECH)",
      "Electronics & Communication (ECE)",
      "Civil Engineering (CE)",
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          final isNarrow = c.maxWidth < 620;

          final label = Text(
            "DEPARTMENT SCOPE:",
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF64748B),
              letterSpacing: 0.5,
            ),
          );

          final dropdown = DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedDepartmentScope,
              isExpanded: true,
              isDense: true,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
              selectedItemBuilder: (context) => scopes
                  .map((s) => Text(
                        s,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ))
                  .toList(),
              items: scopes
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(s, overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedDepartmentScope = val);
                }
              },
            ),
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                label,
                const SizedBox(height: 4),
                dropdown,
              ],
            );
          }

          return Row(
            children: [
              label,
              const SizedBox(width: 12),
              Expanded(child: dropdown),
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 5. COLLEGE PLACEMENT GOAL BAR (Image 1)
  // ===========================================================================
  Widget _buildCollegePlacementGoalBar() {
    final remaining = (_placementTarget - _placementPercent).clamp(0.0, 100.0);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Label, Badge & Target summary metrics
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 620;

              final goalHeading = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "COLLEGE PLACEMENT GOAL",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B),
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "${remaining.toStringAsFixed(1)}% to Target (${_placementTarget.toInt()}%)",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFD97706),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${_placementPercent.toInt()}% of eligible students placed ($_placedCount of $_totalEligible)",
                    style: GoogleFonts.poppins(
                      fontSize: isNarrow ? 15 : 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              );

              final targetSummary = Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildGoalStatMini("Placement Target", "${_placementTarget.toInt()}%", const Color(0xFF0F172A)),
                  _buildGoalStatMini("Avg CTC Target", "₹$_avgCtcTarget LPA", const Color(0xFF0F172A)),
                  _buildGoalStatMini("Mock Interview Goal", "$_mockInterviewGoal%", const Color(0xFF059669)),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    goalHeading,
                    const SizedBox(height: 12),
                    targetSummary,
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  goalHeading,
                  targetSummary,
                ],
              );
            },
          ),
          const SizedBox(height: 14),

          // Thick Navy Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (_placementPercent / 100).clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF1E2865)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalStatMini(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 6. 6 KPI METRIC CARDS (Matches Image 2)
  // ===========================================================================
  Widget _buildMetricCardsGrid() {
    return LayoutBuilder(
      builder: (context, c) {
        final isMobile = c.maxWidth < 750;
        final cardList = [
          _buildKpiMetricCard(
            title: "Total Offers",
            value: "538",
            subtitle: "+81 multi-offers",
            subtitleColor: const Color(0xFF059669),
          ),
          _buildKpiMetricCard(
            title: "Highest CTC",
            value: "₹44 LPA",
            subtitle: "Google Apex Eng.",
            subtitleColor: const Color(0xFF64748B),
          ),
          _buildKpiMetricCard(
            title: "Average CTC",
            value: "₹9.8 LPA",
            subtitle: "Median: ₹8.2 LPA",
            subtitleColor: const Color(0xFF64748B),
          ),
          _buildKpiMetricCard(
            title: "Super Dream (>15 LPA)",
            value: "76",
            subtitle: "14.1% of all offers",
            subtitleColor: const Color(0xFF64748B),
          ),
          _buildKpiMetricCard(
            title: "Dream (10-15 LPA)",
            value: "152",
            subtitle: "28.2% of all offers",
            subtitleColor: const Color(0xFF64748B),
          ),
          _buildKpiMetricCard(
            title: "Seeking Placement",
            value: "7",
            subtitle: "Review students ↗",
            subtitleColor: const Color(0xFFDC2626),
            isAction: true,
          ),
        ];

        if (isMobile) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: cardList
                  .map((card) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(width: 155, child: card),
                      ))
                  .toList(),
            ),
          );
        }

        return Row(
          children: cardList
              .map((card) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: card,
                    ),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildKpiMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required Color subtitleColor,
    bool isAction = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: isAction
                ? () {
                    setState(() => _selectedTabIndex = 4);
                  }
                : null,
            child: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: isAction ? FontWeight.w600 : FontWeight.w400,
                color: subtitleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 7. NAVIGATION TABS (Executive Overview, Department League, etc.)
  // ===========================================================================
  Widget _buildNavigationTabs() {
    final tabs = [
      "Executive Overview",
      "Department League (10)",
      "Recruiter & Drive Analytics (7)",
      "Readiness & Skill Gaps (5)",
      "Placed Student Directory (16)",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(tabs.length, (idx) {
          final isSelected = _selectedTabIndex == idx;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => setState(() => _selectedTabIndex = idx),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E2865) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1E2865)
                          : const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  tabs[idx],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // 8. ACTIVE TAB CONTENT DISPATCHER
  // ===========================================================================
  Widget _buildActiveTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildExecutiveOverviewTab();
      case 1:
        return _buildDepartmentLeagueTab();
      case 2:
        return _buildRecruiterDrivesTab();
      case 3:
        return _buildReadinessSkillGapsTab();
      case 4:
        return _buildPlacedDirectoryTab();
      default:
        return _buildExecutiveOverviewTab();
    }
  }

  // ===========================================================================
  // TAB 1: EXECUTIVE OVERVIEW (Matches Image 2)
  // ===========================================================================
  Widget _buildExecutiveOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Salary CTC Tier Distribution
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Salary CTC Tier Distribution",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    "Total: 538 Offers",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                "Breakdown of released offers across compensation tiers",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 14),

              // Multi-segment horizontal stacked bar
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 14,
                  child: Row(
                    children: [
                      Expanded(flex: 76, child: Container(color: const Color(0xFF0D9488))),
                      Expanded(flex: 152, child: Container(color: const Color(0xFF1E2865))),
                      Expanded(flex: 204, child: Container(color: const Color(0xFFD97706))),
                      Expanded(flex: 106, child: Container(color: const Color(0xFFF1F5F9))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Legend
              LayoutBuilder(
                builder: (context, c) {
                  final isMobile = c.maxWidth < 620;
                  final items = [
                    _buildTierLegendItem("Super Dream (> ₹15 LPA)", "76", "14.1%", const Color(0xFF0D9488)),
                    _buildTierLegendItem("Dream (₹10 – ₹15 LPA)", "152", "28.3%", const Color(0xFF1E2865)),
                    _buildTierLegendItem("Core Engineering (₹6 – ₹10 LPA)", "204", "37.9%", const Color(0xFFD97706)),
                    _buildTierLegendItem("Regular & IT Services (₹3.5 – ₹6 LPA)", "106", "19.7%", const Color(0xFF64748B)),
                  ];

                  if (isMobile) {
                    return Wrap(
                      spacing: 16,
                      runSpacing: 10,
                      children: items,
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: items,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 2. 2-Column Row: Campus Recruitment Funnel & Marquee Placement Drives
        LayoutBuilder(
          builder: (context, c) {
            final isMulti = c.maxWidth >= 860;
            if (isMulti) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildRecruitmentFunnelBox()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildMarqueeDrivesBox()),
                ],
              );
            }
            return Column(
              children: [
                _buildRecruitmentFunnelBox(),
                const SizedBox(height: 16),
                _buildMarqueeDrivesBox(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTierLegendItem(String title, String count, String pct, Color dotColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Text(
              count,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(width: 6),
            Text(
              pct,
              style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecruitmentFunnelBox() {
    final stages = [
      {"step": "1", "name": "Registered for Drives", "count": 702, "pct": 100},
      {"step": "2", "name": "Online Assessment Shortlisted", "count": 576, "pct": 82},
      {"step": "3", "name": "Technical Panel Cleared", "count": 421, "pct": 60},
      {"step": "4", "name": "HR & Leadership Round", "count": 351, "pct": 50},
      {"step": "5", "name": "Final Offer Released", "count": 604, "pct": 86},
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Campus Recruitment Funnel",
                style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
              ),
              InkWell(
                onTap: () => setState(() => _selectedTabIndex = 2),
                child: Text(
                  "Manage Drives ↗",
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF2563EB)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            "Student progression from registration through final offer",
            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 14),
          ...stages.map((st) {
            final pct = st['pct'] as int;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${st['step']}",
                          style: GoogleFonts.poppins(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          st['name'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 11.5, color: const Color(0xFF334155)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${st['count']} ($pct%)",
                        style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: pct / 100.0,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E2865)),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMarqueeDrivesBox() {
    final marquee = [
      {
        "company": "Tata Consultancy Services (TCS)",
        "badge": "Core",
        "ctc": "₹9.5 LPA",
        "offers": "28 offers",
        "desc": "Digital Innovator & Prime Engineer · IT Consulting",
      },
      {
        "company": "Zoho Corporation",
        "badge": "Core",
        "ctc": "₹9 LPA",
        "offers": "18 offers",
        "desc": "Software Engineer · Technology / Enterprise",
      },
      {
        "company": "Amazon AWS",
        "badge": "Super Dream",
        "ctc": "₹18 LPA",
        "offers": "6 offers",
        "desc": "Associate Cloud Support Engineer · Cloud & Infrastructure",
      },
      {
        "company": "Google India",
        "badge": "Super Dream",
        "ctc": "₹32.5 LPA",
        "offers": "6 offers",
        "desc": "Software Development Engineer (SDE-1) · Technology / Enterprise",
      },
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Marquee Placement Drives",
                style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
              ),
              InkWell(
                onTap: () => setState(() => _selectedTabIndex = 2),
                child: Text(
                  "Recruiter Pool ↗",
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF2563EB)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            "Recruiting partners with highest compensation and offer releases",
            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 14),
          ...marquee.map((m) {
            final isSuper = m['badge'] == 'Super Dream';
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF9F6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              m['company']!,
                              style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isSuper
                                    ? const Color(0xFFCCFBF1)
                                    : const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                m['badge']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w600,
                                  color: isSuper
                                      ? const Color(0xFF0D9488)
                                      : const Color(0xFFD97706),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            m['ctc']!,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A)),
                          ),
                          Text(
                            m['offers']!,
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: const Color(0xFF059669),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    m['desc']!,
                    style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 2: DEPARTMENT LEAGUE (10) (Matches Image 3)
  // ===========================================================================
  Widget _buildDepartmentLeagueTab() {
    final query = _deptSearchCtrl.text.toLowerCase().trim();
    final filtered = _departments.where((d) {
      if (query.isEmpty) return true;
      final name = (d['name'] as String).toLowerCase();
      final code = (d['code'] as String).toLowerCase();
      return name.contains(query) || code.contains(query);
    }).toList();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 640;

              final headerTexts = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Department Placement Matrix",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Comparative placement metrics, average packages, and top recruiters across departments",
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: const Color(0xFF64748B)),
                  ),
                ],
              );

              final searchBox = Wrap(
                spacing: 10,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: isNarrow ? 180 : 170,
                    height: 34,
                    child: TextField(
                      controller: _deptSearchCtrl,
                      onChanged: (_) => setState(() {}),
                      style: GoogleFonts.poppins(fontSize: 11.5),
                      decoration: InputDecoration(
                        hintText: "Search departments...",
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 11, color: const Color(0xFF94A3B8)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0))),
                      ),
                    ),
                  ),
                  Text(
                    "Bridge Courses ↗",
                    style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2563EB)),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerTexts,
                    const SizedBox(height: 10),
                    searchBox,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: headerTexts),
                  const SizedBox(width: 12),
                  searchBox,
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Department Matrix Table (Image 3)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 840),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(const Color(0xFFFBF8F2)),
                headingRowHeight: 40,
                dataRowMinHeight: 48,
                dataRowMaxHeight: 56,
                horizontalMargin: 12,
                columnSpacing: 16,
                columns: [
                  DataColumn(label: Text("Department", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Total / Eligible", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Placed", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Placement %", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Avg CTC", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Highest CTC", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Readiness", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Top Hiring Partner", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Quick Action", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                ],
                rows: filtered.map((d) {
                  final pct = d['percent'] as double;
                  final r = d['readiness'] as int;
                  final isGoodR = r >= 85;

                  return DataRow(
                    cells: [
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(d['name'], style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A))),
                            Text(d['code'], style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8))),
                          ],
                        ),
                      ),
                      DataCell(Text(d['totalEligible'], style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF475569)))),
                      DataCell(Text("${d['placed']}", style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)))),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("$pct%", style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 36,
                              height: 4,
                              child: LinearProgressIndicator(
                                value: pct / 100.0,
                                backgroundColor: const Color(0xFFE2E8F0),
                                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E2865)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(Text(d['avgCtc'], style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)))),
                      DataCell(Text(d['highestCtc'], style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF0D9488)))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isGoodR ? const Color(0xFFCCFBF1) : const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "$r/100",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isGoodR ? const Color(0xFF0D9488) : const Color(0xFFD97706),
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(d['topRecruiter'], style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF334155)))),
                      DataCell(
                        InkWell(
                          onTap: () {
                            setState(() => _selectedTabIndex = 4);
                          },
                          child: Text("View Students ↗", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF2563EB))),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 3: RECRUITER & DRIVE ANALYTICS (7) (Matches Image 4)
  // ===========================================================================
  Widget _buildRecruiterDrivesTab() {
    final filtered = _recruiterDrives.where((d) {
      if (_selectedRecruiterTier == "All Tiers") return true;
      return d['tier'] == _selectedRecruiterTier;
    }).toList();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 640;

              final headerTexts = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Campus Recruitment Drives",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A))),
                  const SizedBox(height: 2),
                  Text("Drive attendance, shortlisting ratio, and final offers",
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: const Color(0xFF64748B))),
                ],
              );

              final controls = Wrap(
                spacing: 10,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF9F6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedRecruiterTier,
                        isDense: true,
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF334155)),
                        items: ["All Tiers", "Core", "Super Dream", "Dream"]
                            .map((t) =>
                                DropdownMenuItem(value: t, child: Text(t)))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _selectedRecruiterTier = v);
                          }
                        },
                      ),
                    ),
                  ),
                  Text("Placement Drives Hub ↗",
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2563EB))),
                ],
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerTexts,
                    const SizedBox(height: 10),
                    controls,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: headerTexts),
                  const SizedBox(width: 12),
                  controls,
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Drives Data Table (Image 4)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 860),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(const Color(0xFFFBF8F2)),
                headingRowHeight: 40,
                dataRowMinHeight: 48,
                dataRowMaxHeight: 56,
                horizontalMargin: 12,
                columnSpacing: 16,
                columns: [
                  DataColumn(label: Text("Company", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Role", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Tier & Sector", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("CTC", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Registered", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Shortlisted", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Offers", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Conversion", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Status", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Linked Actions", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                ],
                rows: filtered.map((d) {
                  final isSuper = d['tier'] == 'Super Dream';
                  final status = d['status'] as String;

                  Color statusBg = const Color(0xFFDCFCE7);
                  Color statusColor = const Color(0xFF15803D);
                  if (status == 'Active') {
                    statusBg = const Color(0xFFDBEAFE);
                    statusColor = const Color(0xFF1E40AF);
                  } else if (status == 'Upcoming') {
                    statusBg = const Color(0xFFEFF6FF);
                    statusColor = const Color(0xFF2563EB);
                  }

                  return DataRow(
                    cells: [
                      DataCell(Text(d['company'], style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)))),
                      DataCell(Text(d['role'], style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF475569)))),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isSuper ? const Color(0xFFCCFBF1) : const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                d['tier'],
                                style: GoogleFonts.poppins(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w600,
                                  color: isSuper ? const Color(0xFF0D9488) : const Color(0xFFD97706),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(d['sector'], style: GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF94A3B8))),
                          ],
                        ),
                      ),
                      DataCell(Text(d['ctc'], style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)))),
                      DataCell(Text("${d['registered']}", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF475569)))),
                      DataCell(Text("${d['shortlisted']}", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF475569)))),
                      DataCell(Text("${d['offers']}", style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF059669)))),
                      DataCell(Text(d['conversion'], style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF334155)))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(6)),
                          child: Text(status, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: statusColor)),
                        ),
                      ),
                      DataCell(
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Viewing candidate shortlists for ${d['company']}."),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Text("Shortlist Students ↗", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF2563EB))),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 4: READINESS & SKILL GAPS (5) (Matches Image 5)
  // ===========================================================================
  Widget _buildReadinessSkillGapsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, c) {
            final isNarrow = c.maxWidth < 620;

            final noteText = Text(
              "Identified critical gaps across departments. Click \"Launch Bridge Course\" to push interventions directly into Department Skills.",
              style: GoogleFonts.poppins(
                  fontSize: 11.5, color: const Color(0xFF64748B)),
            );

            final linkBtn = Text(
              "Open Department Skills Desk ↗",
              style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2563EB)),
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  noteText,
                  const SizedBox(height: 8),
                  linkBtn,
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: noteText),
                const SizedBox(width: 12),
                linkBtn,
              ],
            );
          },
        ),
        const SizedBox(height: 14),

        // 2-Column Grid of Skill Gap Cards
        LayoutBuilder(
          builder: (context, c) {
            final isMulti = c.maxWidth >= 760;
            final width = isMulti ? (c.maxWidth - 16) / 2 : c.maxWidth;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _skillGaps.map((sg) {
                return SizedBox(
                  width: width,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                sg['title'],
                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: Color(sg['tagBg']),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                sg['tag'],
                                style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: Color(sg['tagColor'])),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Progress Bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: sg['progress'],
                            minHeight: 6,
                            backgroundColor: const Color(0xFFF1F5F9),
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E2865)),
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Proficient: ${sg['proficient']} students", style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B))),
                            Text("Critical Gaps: ${sg['criticalGaps']} students", style: GoogleFonts.poppins(fontSize: 10.5, fontWeight: FontWeight.w600, color: const Color(0xFFDC2626))),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Recommended Intervention Box
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAF9F6),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recommended Intervention:",
                                style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                sg['intervention'],
                                style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF475569)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Action links
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Bridge course workflow dispatched for ${sg['title']}."),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.add_circle_outline, size: 13, color: Color(0xFF2563EB)),
                                  const SizedBox(width: 4),
                                  Text("Launch Bridge Course ↗", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF2563EB))),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Opening Early Warning list for ${sg['title']}."),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              child: Text("Check Early Warning ↗", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // TAB 5: PLACED STUDENT DIRECTORY (16)
  // ===========================================================================
  Widget _buildPlacedDirectoryTab() {
    final query = _studentSearchCtrl.text.toLowerCase().trim();
    final filtered = _placedDirectory.where((s) {
      if (query.isEmpty) return true;
      final name = (s['name'] as String).toLowerCase();
      final roll = (s['roll'] as String).toLowerCase();
      final comp = (s['company'] as String).toLowerCase();
      return name.contains(query) || roll.contains(query) || comp.contains(query);
    }).toList();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, c) {
              final isNarrow = c.maxWidth < 640;

              final headerTexts = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Placed Student Directory (AY 2026-27)",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A))),
                  const SizedBox(height: 2),
                  Text("Verified offers and corporate placement confirmations",
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: const Color(0xFF64748B))),
                ],
              );

              final searchBox = SizedBox(
                width: isNarrow ? double.infinity : 220,
                height: 34,
                child: TextField(
                  controller: _studentSearchCtrl,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(fontSize: 11.5),
                  decoration: InputDecoration(
                    hintText: "Search student, roll, recruiter...",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 11, color: const Color(0xFF94A3B8)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            const BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                ),
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerTexts,
                    const SizedBox(height: 10),
                    searchBox,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: headerTexts),
                  const SizedBox(width: 12),
                  searchBox,
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 780),
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(const Color(0xFFFBF8F2)),
                headingRowHeight: 40,
                dataRowMinHeight: 46,
                dataRowMaxHeight: 52,
                horizontalMargin: 12,
                columnSpacing: 18,
                columns: [
                  DataColumn(label: Text("Student Name", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Roll No", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Department", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Placed Company", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Tier", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("CTC Offered", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                  DataColumn(label: Text("Offer Date", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF475569)))),
                ],
                rows: filtered.map((s) {
                  return DataRow(
                    cells: [
                      DataCell(Text(s['name'], style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)))),
                      DataCell(Text(s['roll'], style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)))),
                      DataCell(Text(s['dept'], style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF334155)))),
                      DataCell(Text(s['company'], style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E2865)))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: s['tier'] == 'Super Dream' ? const Color(0xFFCCFBF1) : const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            s['tier'],
                            style: GoogleFonts.poppins(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w600,
                              color: s['tier'] == 'Super Dream' ? const Color(0xFF0D9488) : const Color(0xFFD97706),
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(s['package'], style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF059669)))),
                      DataCell(Text(s['date'], style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8)))),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT GRID PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    const double step = 28.0;

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
