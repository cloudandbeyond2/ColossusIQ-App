import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalStudentSuccessEarlyWarningScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalStudentSuccessEarlyWarningScreen({super.key, this.onBack});

  @override
  State<PrincipalStudentSuccessEarlyWarningScreen> createState() =>
      _PrincipalStudentSuccessEarlyWarningScreenState();
}

class _PrincipalStudentSuccessEarlyWarningScreenState
    extends State<PrincipalStudentSuccessEarlyWarningScreen> {
  int _activeTab = 0;
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _supportPlans = [];

  String _selectedDept = "All Departments";
  String _selectedLevel = "All Levels";
  String _selectedStatus = "All Statuses";

  final List<String> _departments = [
    "All Departments",
    "Computer Science & Engineering",
    "Information Technology",
    "Artificial Intelligence & Data Science",
    "Electronics & Communication",
    "Electrical & Electronics",
    "Mechanical Engineering",
    "Civil Engineering",
    "Science & Humanities",
  ];

  final List<String> _levels = [
    "All Levels",
    "Critical",
    "Moderate",
    "Watchlist",
    "Low Risk",
  ];

  final List<String> _statuses = [
    "All Statuses",
    "Pending review",
    "In review",
    "Resolved",
  ];

  final List<Map<String, dynamic>> _rosterStudents = [
    {
      "name": "bala",
      "roll": "27549861 · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "0%",
      "quizAlert": true,
      "certs": "0",
      "certsAlert": true,
      "interview": "0",
      "interviewAlert": true,
      "resume": "0",
      "resumeAlert": true,
      "overall": 0,
      "overallAlert": true,
      "tier": "Critical",
      "tierType": "critical",
      "signals": [
        "Zero Quizzes Attempted",
        "No Verified Certifications",
        "Mock Technical Interview Pending",
        "Resume ATS Benchmark Missing",
        "Placement Readiness Alert (0/100)",
      ],
      "status": "Pending review",
      "statusType": "pending",
      "recommendation": "1-on-1 Academic Tutoring with far",
    },
    {
      "name": "Kirshna",
      "roll": "21CS4788 · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "0%",
      "quizAlert": true,
      "certs": "0",
      "certsAlert": true,
      "interview": "0",
      "interviewAlert": true,
      "resume": "0",
      "resumeAlert": true,
      "overall": 0,
      "overallAlert": true,
      "tier": "Critical",
      "tierType": "critical",
      "signals": [
        "Zero Quizzes Attempted",
        "No Verified Certifications",
        "Mock Technical Interview Pending",
        "Resume ATS Benchmark Missing",
        "Placement Readiness Alert (0/100)",
      ],
      "status": "Pending review",
      "statusType": "pending",
      "recommendation": "1-on-1 Academic Tutoring with far",
    },
    {
      "name": "Anand Kumar",
      "roll": "110124001 · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "72%",
      "quizAlert": false,
      "certs": "7",
      "certsAlert": false,
      "interview": "17",
      "interviewAlert": true,
      "resume": "72",
      "resumeAlert": false,
      "overall": 69,
      "overallAlert": false,
      "tier": "Watchlist",
      "tierType": "watchlist",
      "signals": [
        "Low Interview Score (17/100)",
      ],
      "status": "Pending review",
      "statusType": "pending",
      "recommendation": "Mock Technical Interview Remediation with Dr. Meena Raghavan",
    },
    {
      "name": "Divya Ramesh",
      "roll": "110124002 · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "100%",
      "quizAlert": false,
      "certs": "1",
      "certsAlert": false,
      "interview": "0",
      "interviewAlert": true,
      "resume": "0",
      "resumeAlert": true,
      "overall": 40,
      "overallAlert": true,
      "tier": "Moderate",
      "tierType": "moderate",
      "signals": [
        "Mock Technical Interview Pending",
        "Resume ATS Benchmark Missing",
        "Placement Readiness Alert (40/100)",
      ],
      "status": "Pending review",
      "statusType": "pending",
      "recommendation": "Career Studio ATS Workshop with Prof. Priya Sharma",
    },
    {
      "name": "Karthik Raja",
      "roll": "110124003 · 2023–2027 (Final Year)",
      "dept": "Information Technology",
      "quiz": "0%",
      "quizAlert": true,
      "certs": "0",
      "certsAlert": true,
      "interview": "0",
      "interviewAlert": true,
      "resume": "0",
      "resumeAlert": true,
      "overall": 0,
      "overallAlert": true,
      "tier": "Critical",
      "tierType": "critical",
      "signals": [
        "Zero Quizzes Attempted",
        "No Verified Certifications",
        "Mock Technical Interview Pending",
        "Resume ATS Benchmark Missing",
        "Placement Readiness Alert (0/100)",
      ],
      "status": "Pending review",
      "statusType": "pending",
      "recommendation": "Department Faculty Continuity & Quiz Intervention",
    },
    {
      "name": "Suganya",
      "roll": "52CS1478 · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "0%",
      "quizAlert": true,
      "certs": "0",
      "certsAlert": true,
      "interview": "0",
      "interviewAlert": true,
      "resume": "0",
      "resumeAlert": true,
      "overall": 0,
      "overallAlert": true,
      "tier": "Critical",
      "tierType": "critical",
      "signals": [
        "Zero Quizzes Attempted",
        "No Verified Certifications",
        "Mock Technical Interview Pending",
        "Resume ATS Benchmark Missing",
        "Placement Readiness Alert (0/100)",
      ],
      "status": "Pending review",
      "statusType": "pending",
      "recommendation": "1-on-1 Faculty Mentorship with far",
    },
    {
      "name": "Praveen Kumar",
      "roll": "110124005 · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "0%",
      "quizAlert": true,
      "certs": "0",
      "certsAlert": true,
      "interview": "0",
      "interviewAlert": true,
      "resume": "0",
      "resumeAlert": true,
      "overall": 0,
      "overallAlert": true,
      "tier": "Critical",
      "tierType": "critical",
      "signals": [
        "Zero Quizzes Attempted",
        "No Verified Certifications",
        "Mock Technical Interview Pending",
        "Resume ATS Benchmark Missing",
        "Placement Readiness Alert (0/100)",
      ],
      "status": "Pending review",
      "statusType": "pending",
      "recommendation": "1-on-1 Academic Tutoring with far",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizPadding = constraints.maxWidth >= 1100
              ? 32.0
              : constraints.maxWidth >= 600
                  ? 20.0
                  : 14.0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(horizPadding, 20, horizPadding, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. HERO BLUEPRINT BANNER (Image 1)
                _buildHeroBanner(),
                const SizedBox(height: 16),

                // 2. TWO ADVISORY ALERT BOXES (Image 1)
                _buildAlertBox1(),
                const SizedBox(height: 10),
                _buildAlertBox2(),
                const SizedBox(height: 16),

                // 3. FILTER & ACTION TOOLBAR (Image 1)
                _buildFilterToolbar(),
                const SizedBox(height: 16),

                // 4. 5 METRIC KPI CARDS (Image 1)
                _buildKpiCards(constraints.maxWidth),
                const SizedBox(height: 20),

                // 5. SUBTABS (Image 1, 3, 4)
                _buildSubTabs(),
                const SizedBox(height: 18),

                // 6. TAB CONTENT
                if (_activeTab == 0) _buildTab0Roster(),
                if (_activeTab == 1) _buildTab1Analytics(),
                if (_activeTab == 2) _buildTab2SupportPlans(),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF131B4D), Color(0xFF1D2866), Color(0xFF283685)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            Positioned(
              right: 18,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.07,
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 180,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        if (widget.onBack != null) ...[
                          InkWell(
                            onTap: widget.onBack,
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.arrow_back_rounded,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          "Department",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          "Student Success & Early Warning",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges: DEPARTMENT, Phase 3
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          "DEPARTMENT",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
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
                          "Phase 3",
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

                  // Main Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E3B7D),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFFFBBF24), // Amber Warning Triangle
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Student Success & Early Warning",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Support recommendations for faculty and counsellors to review — never automatic labels.",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFFCBD5E1),
                                height: 1.4,
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
      ),
    );
  }

  // ===========================================================================
  // 2. TWO ADVISORY ALERT BOXES (Image 1)
  // ===========================================================================
  Widget _buildAlertBox1() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7).withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.info_outline_rounded,
              size: 16, color: Color(0xFFB45309)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Signals are suggestions for human review. Students are never automatically labelled, and decisions rest with faculty and counsellors.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF92400E),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertBox2() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7).withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.verified_user_outlined,
                size: 16, color: Color(0xFFB45309)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Ethical Advisory & Decision Principle:",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF78350F),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Signals shown here are algorithmic suggestions for proactive human review based on continuous assessments and learning outcomes. Students are never automatically penalised or labelled. All advisory actions, tutoring, and support plans rest solely with faculty advisors and counsellors.",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF92400E),
                    height: 1.4,
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
  // 3. FILTER & ACTION TOOLBAR (Image 1) - FULL RESPONSIVE
  // ===========================================================================
  Widget _buildFilterToolbar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 650;
          final isTablet = constraints.maxWidth >= 650 && constraints.maxWidth < 1050;

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Row 1: All Departments full width
                _buildDropdownPill(_selectedDept, _departments,
                    (v) => setState(() => _selectedDept = v!),
                    width: double.infinity),
                const SizedBox(height: 10),
                // Row 2: All Levels and All Statuses half-half
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownPill(_selectedLevel, _levels,
                          (v) => setState(() => _selectedLevel = v!),
                          width: double.infinity),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildDropdownPill(_selectedStatus, _statuses,
                          (v) => setState(() => _selectedStatus = v!),
                          width: double.infinity),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Row 3: Search input full width
                _buildSearchInput(width: double.infinity),
                const SizedBox(height: 12),
                // Row 4: Refresh and Audit CSV half-half
                Row(
                  children: [
                    Expanded(child: _buildRefreshButton()),
                    const SizedBox(width: 8),
                    Expanded(child: _buildAuditCsvButton()),
                  ],
                ),
                const SizedBox(height: 8),
                // Row 5: Log Support Plan full width
                SizedBox(
                  width: double.infinity,
                  child: _buildLogSupportPlanButton(),
                ),
              ],
            );
          }

          if (isTablet) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildDropdownPill(_selectedDept, _departments,
                          (v) => setState(() => _selectedDept = v!),
                          width: double.infinity),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildDropdownPill(_selectedLevel, _levels,
                          (v) => setState(() => _selectedLevel = v!),
                          width: double.infinity),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildDropdownPill(_selectedStatus, _statuses,
                          (v) => setState(() => _selectedStatus = v!),
                          width: double.infinity),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _buildSearchInput(width: double.infinity)),
                    const SizedBox(width: 10),
                    _buildRefreshButton(),
                    const SizedBox(width: 8),
                    _buildAuditCsvButton(),
                    const SizedBox(width: 8),
                    _buildLogSupportPlanButton(),
                  ],
                ),
              ],
            );
          }

          // Desktop (maxWidth >= 1050)
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 190,
                child: _buildDropdownPill(_selectedDept, _departments,
                    (v) => setState(() => _selectedDept = v!),
                    width: double.infinity),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 130,
                child: _buildDropdownPill(_selectedLevel, _levels,
                    (v) => setState(() => _selectedLevel = v!),
                    width: double.infinity),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 140,
                child: _buildDropdownPill(_selectedStatus, _statuses,
                    (v) => setState(() => _selectedStatus = v!),
                    width: double.infinity),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSearchInput(width: double.infinity),
              ),
              const SizedBox(width: 12),
              _buildRefreshButton(),
              const SizedBox(width: 8),
              _buildAuditCsvButton(),
              const SizedBox(width: 8),
              _buildLogSupportPlanButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDropdownPill(
      String value, List<String> items, ValueChanged<String?> onChanged,
      {double? width}) {
    return Container(
      width: width,
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 16, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
              fontSize: 11.5, color: const Color(0xFF0F172A)),
          items: items
              .map((it) => DropdownMenuItem(
                  value: it, child: Text(it, overflow: TextOverflow.ellipsis)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildSearchInput({double? width}) {
    return Container(
      height: 38,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.poppins(fontSize: 12),
        decoration: const InputDecoration(
          hintText: "Search student or roll no...",
          hintStyle: TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
          prefixIcon:
              Icon(Icons.search_rounded, size: 16, color: Color(0xFF94A3B8)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
      ),
    );
  }

  Widget _buildRefreshButton() {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.sync_rounded, size: 14, color: Color(0xFF475569)),
      label: Text(
        "Refresh",
        style: GoogleFonts.poppins(
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF475569),
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        side: const BorderSide(color: Color(0xFFCBD5E1)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildAuditCsvButton() {
    return OutlinedButton.icon(
      onPressed: () {},
      icon:
          const Icon(Icons.download_rounded, size: 14, color: Color(0xFF475569)),
      label: Text(
        "Audit CSV",
        style: GoogleFonts.poppins(
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF475569),
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        side: const BorderSide(color: Color(0xFFCBD5E1)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildLogSupportPlanButton() {
    return ElevatedButton.icon(
      onPressed: () => _showScheduleSupportPlanModal(),
      icon: const Icon(Icons.add_rounded, size: 15, color: Colors.white),
      label: Text(
        "Log Support Plan",
        style: GoogleFonts.poppins(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1E2865),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // ===========================================================================
  // 4. 5 METRIC KPI CARDS (Image 1)
  // ===========================================================================
  Widget _buildKpiCards(double maxWidth) {
    double cardWidth;
    if (maxWidth >= 1200) {
      cardWidth = (maxWidth - (4 * 10)) / 5;
    } else if (maxWidth >= 850) {
      cardWidth = (maxWidth - (2 * 10)) / 3;
    } else if (maxWidth >= 540) {
      cardWidth = (maxWidth - 10) / 2;
    } else {
      cardWidth = maxWidth;
    }

    final cards = [
      _buildSingleKpi(
        title: "Flagged for Attention",
        badge: "5 critical",
        badgeBg: const Color(0xFFFFE4E6),
        badgeColor: const Color(0xFFE11D48),
        value: "7",
        subtext: "Students with academic, certification..",
      ),
      _buildSingleKpi(
        title: "Critical Risk Flags",
        badge: "Urgent review",
        badgeBg: const Color(0xFFFFE4E6),
        badgeColor: const Color(0xFFE11D48),
        value: "5",
        subtext: "Requires faculty counsellor or tutor in..",
      ),
      _buildSingleKpi(
        title: "Active Support Plans",
        badge: "${_supportPlans.length} total logged",
        badgeBg: const Color(0xFFE0F2FE),
        badgeColor: const Color(0xFF0284C7),
        value: "${_supportPlans.length}",
        subtext: "Interventions currently assigned and ..",
      ),
      _buildSingleKpi(
        title: "Resolved / On Track",
        badge: "0% cohort",
        badgeBg: const Color(0xFFCCFBF1),
        badgeColor: const Color(0xFF0D9488),
        value: "0",
        subtext: "Students cleared of risk flags or met r..",
      ),
      _buildSingleKpi(
        title: "Cohort Avg Readiness",
        badge: "Uplift needed",
        badgeBg: const Color(0xFFFEF3C7),
        badgeColor: const Color(0xFFD97706),
        value: "16 / 100",
        subtext: "Combined index across quiz, certs, in..",
      ),
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: cards
          .map((c) => SizedBox(
                width: cardWidth,
                child: c,
              ))
          .toList(),
    );
  }

  Widget _buildSingleKpi({
    required String title,
    required String badge,
    required Color badgeBg,
    required Color badgeColor,
    required String value,
    required String subtext,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
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
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtext,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5. SUBTABS (Image 1, 3, 4)
  // ===========================================================================
  Widget _buildSubTabs() {
    final tabs = [
      {"label": "At-Risk Students Roster", "count": "${_rosterStudents.length}", "icon": Icons.people_outline_rounded},
      {"label": "Cohort Risk Analytics & Trends", "count": null, "icon": Icons.insert_chart_outlined_rounded},
      {"label": "Support Plans & Case Log", "count": "${_supportPlans.length}", "icon": Icons.assignment_outlined},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _activeTab == index;
          final t = tabs[index];
          return Padding(
            padding: const EdgeInsets.only(right: 22),
            child: InkWell(
              onTap: () => setState(() => _activeTab = index),
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? const Color(0xFF1E2865)
                          : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(t["icon"] as IconData,
                        size: 15,
                        color: isSelected
                            ? const Color(0xFF1E2865)
                            : const Color(0xFF64748B)),
                    const SizedBox(width: 7),
                    Text(
                      t["label"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF1E2865)
                            : const Color(0xFF64748B),
                      ),
                    ),
                    if (t["count"] != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          t["count"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // TAB 0: At-Risk Students Roster (Images 1 & 2)
  // ===========================================================================
  Widget _buildTab0Roster() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Flagged Students Requiring Advisory Attention",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Real-time algorithmic risk indicators across continuous assessments, verified credentials, and interview benchmarks.",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Showing ${_rosterStudents.length} student(s)",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1200),
              child: DataTable(
                columnSpacing: 16,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 60,
                dataRowMaxHeight: 200,
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFF7F4EE)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                columns: const [
                  DataColumn(label: Text("STUDENT & ROLL NO")),
                  DataColumn(label: Text("DEPARTMENT")),
                  DataColumn(label: Text("QUIZ AVG")),
                  DataColumn(label: Text("CERTS")),
                  DataColumn(label: Text("INTERVIEW")),
                  DataColumn(label: Text("RESUME")),
                  DataColumn(label: Text("OVERALL")),
                  DataColumn(label: Text("RISK TIER")),
                  DataColumn(label: Text("SIGNALS OBSERVED")),
                  DataColumn(label: Text("REVIEW STATUS")),
                  DataColumn(label: Text("ACTIONS")),
                ],
                rows: _rosterStudents.map((s) {
                  final isQuizAlert = s["quizAlert"] as bool? ?? false;
                  final isInterviewAlert = s["interviewAlert"] as bool? ?? false;
                  final isCertsAlert = s["certsAlert"] as bool? ?? false;
                  final isOverallAlert = s["overallAlert"] as bool? ?? false;

                  final tierType = s["tierType"] as String;
                  Color tierBg;
                  Color tierColor;
                  if (tierType == "critical") {
                    tierBg = const Color(0xFFFFE4E6);
                    tierColor = const Color(0xFFE11D48);
                  } else if (tierType == "moderate") {
                    tierBg = const Color(0xFFFEF3C7);
                    tierColor = const Color(0xFFD97706);
                  } else if (tierType == "watchlist") {
                    tierBg = const Color(0xFFE0F2FE);
                    tierColor = const Color(0xFF0284C7);
                  } else {
                    tierBg = const Color(0xFFDCFCE7);
                    tierColor = const Color(0xFF16A34A);
                  }

                  final statusType = s["statusType"] as String;
                  Color statusBg;
                  Color statusColor;
                  if (statusType == "pending") {
                    statusBg = const Color(0xFFFFE4E6);
                    statusColor = const Color(0xFFE11D48);
                  } else {
                    statusBg = const Color(0xFFCCFBF1);
                    statusColor = const Color(0xFF0D9488);
                  }

                  final signals = s["signals"] as List<String>;
                  final overall = s["overall"] as int;

                  return DataRow(
                    cells: [
                      // Student & Roll No
                      DataCell(
                        InkWell(
                          onTap: () => _showStudentDetailsModal(s),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                s["name"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                s["roll"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Department
                      DataCell(
                        Text(
                          s["dept"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // Quiz Avg
                      DataCell(
                        Text(
                          s["quiz"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: isQuizAlert
                                ? const Color(0xFFDC2626)
                                : const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Certs
                      DataCell(
                        Text(
                          s["certs"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: isCertsAlert
                                ? const Color(0xFFD97706)
                                : const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Interview
                      DataCell(
                        Text(
                          s["interview"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: isInterviewAlert
                                ? const Color(0xFFD97706)
                                : const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Resume
                      DataCell(
                        Text(
                          s["resume"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Overall
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isOverallAlert
                                ? const Color(0xFFFFE4E6)
                                : (overall >= 70
                                    ? const Color(0xFFCCFBF1)
                                    : const Color(0xFFE2E8F0)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "$overall",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isOverallAlert
                                  ? const Color(0xFFDC2626)
                                  : (overall >= 70
                                      ? const Color(0xFF0D9488)
                                      : const Color(0xFF131B4D)),
                            ),
                          ),
                        ),
                      ),
                      // Risk Tier
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: tierBg,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            s["tier"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: tierColor,
                            ),
                          ),
                        ),
                      ),
                      // Signals Observed
                      DataCell(
                        signals.isEmpty
                            ? const Text("—",
                                style: TextStyle(color: Color(0xFF94A3B8)))
                            : Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: signals.map((sig) {
                                  final isCrit = sig.contains("Zero") ||
                                      sig.contains("No Verified") ||
                                      sig.contains("Alert (0");
                                  final bg = isCrit
                                      ? const Color(0xFFFFE4E6)
                                      : const Color(0xFFFEF3C7);
                                  final fg = isCrit
                                      ? const Color(0xFFE11D48)
                                      : const Color(0xFFB45309);

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: bg,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      sig,
                                      style: GoogleFonts.poppins(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w600,
                                        color: fg,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                      // Review Status
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: statusColor.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                s["status"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down_rounded,
                                  size: 14, color: statusColor),
                            ],
                          ),
                        ),
                      ),
                      // Actions
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton(
                              onPressed: () => _showStudentDetailsModal(s),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                side: const BorderSide(
                                    color: Color(0xFFCBD5E1)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              child: Text(
                                "Details",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            ElevatedButton(
                              onPressed: () =>
                                  _showScheduleSupportPlanModal(student: s),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E2865),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              child: Text(
                                "+ Plan",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
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
  // MODALS
  // ===========================================================================

  // 1. STUDENT DETAILS MODAL (Image 4)
  void _showStudentDetailsModal(Map<String, dynamic> student) {
    final signals = student["signals"] as List<String>;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student["name"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                student["roll"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => Navigator.of(dialogCtx).pop(),
                          icon: const Icon(Icons.close_rounded,
                              size: 20, color: Color(0xFF64748B)),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    const SizedBox(height: 16),

                    // Metrics Strip (Cream Card)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFEFE8DD)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildDetailStat(
                            "Quiz Avg",
                            student["quiz"] as String,
                            const Color(0xFFDC2626),
                          ),
                          _buildDetailStat(
                            "Certs",
                            student["certs"] as String,
                            const Color(0xFFD97706),
                          ),
                          _buildDetailStat(
                            "Interview",
                            student["interview"] as String,
                            const Color(0xFFD97706),
                          ),
                          _buildDetailStat(
                            "Resume ATS",
                            student["resume"] as String,
                            const Color(0xFFD97706),
                          ),
                          _buildDetailStat(
                            "Readiness",
                            "${student["overall"]}/100",
                            const Color(0xFF1E2865),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Observed Deficit Signals Header
                    Text(
                      "OBSERVED DEFICIT SIGNALS (${signals.length})",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Signal Cards
                    ...signals.map((sig) {
                      final isCrit = sig.contains("Zero") ||
                          sig.contains("No Verified") ||
                          sig.contains("Alert (0");
                      final badgeText = isCrit ? "critical" : "moderate";
                      final badgeBg = isCrit
                          ? const Color(0xFFFFE4E6)
                          : const Color(0xFFFEF3C7);
                      final badgeFg = isCrit
                          ? const Color(0xFFDC2626)
                          : const Color(0xFFD97706);
                      final cardBorder = isCrit
                          ? const Color(0xFFFECDD3)
                          : const Color(0xFFFED7AA);

                      String desc = "";
                      String source = "";
                      if (sig.contains("Zero Quizzes")) {
                        desc = "Student has not attempted coursework quizzes or formative tests.";
                        source = "Source: Continuous Assessment";
                      } else if (sig.contains("No Verified")) {
                        desc = "Has not verified practical mastery through course certification tracks.";
                        source = "Source: Learning Outcomes Track";
                      } else if (sig.contains("Mock Technical")) {
                        desc = "Has not completed an AI mock technical or behavioral interview.";
                        source = "Source: Placement Lab";
                      } else if (sig.contains("Resume ATS")) {
                        desc = "Student resume has not been uploaded for automated ATS scoring.";
                        source = "Source: Career Studio";
                      } else if (sig.contains("Placement Readiness Alert")) {
                        desc = "Composite score is in 'Needs work' band; requires intervention before campus drives.";
                        source = "Source: Readiness Board";
                      } else if (sig.contains("Low Interview")) {
                        desc = "Technical interview evaluation score is below institutional readiness threshold.";
                        source = "Source: Placement Lab";
                      } else {
                        desc = "Performance indicator requires academic or career counseling intervention.";
                        source = "Source: Institutional Analytics";
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: cardBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    sig,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: badgeBg,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    badgeText,
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                      color: badgeFg,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              desc,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF64748B),
                                height: 1.35,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              source,
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 6),

                    // Algorithmic Recommendation Box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFC7D2FE)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Algorithmic Recommendation:",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E2865),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            student["recommendation"] as String? ??
                                "1-on-1 Academic Tutoring with far",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    const SizedBox(height: 16),

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.of(dialogCtx).pop(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text(
                            "Close",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(dialogCtx).pop();
                            _showScheduleSupportPlanModal(student: student);
                          },
                          icon: const Icon(Icons.add_rounded,
                              size: 15, color: Colors.white),
                          label: Text(
                            "Schedule Support Plan",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E2865),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
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
      },
    );
  }

  Widget _buildDetailStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 9.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }

  // 2. SCHEDULE SUPPORT PLAN MODAL (Images 3 & 5)
  void _showScheduleSupportPlanModal({Map<String, dynamic>? student}) {
    String selectedStudentName = student != null
        ? "${student["name"]} (${(student["roll"] as String).split(" · ")[0]} · ${student["dept"]}) - ${student["tier"]}"
        : "bala (27549861 · Computer Science & Engineering) - Critical";

    final studentOptions = _rosterStudents
        .map((s) =>
            "${s["name"]} (${(s["roll"] as String).split(" · ")[0]} · ${s["dept"]}) - ${s["tier"]}")
        .toList();

    String selectedStrategy = "1-on-1 Faculty Mentorship";
    String selectedFaculty = "far";
    final dateCtrl = TextEditingController(text: "12/05/2026");
    final notesCtrl = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final isSpecific = student != null;
            final modalTitle = isSpecific
                ? "Support Plan for ${student["name"]}"
                : "Schedule Student Support Plan";

            return Dialog(
              backgroundColor: Colors.white,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Modal Header
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.assignment_ind_outlined,
                                size: 20, color: Color(0xFF1E2865)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                modalTitle,
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(dialogCtx).pop(),
                              icon: const Icon(Icons.close_rounded,
                                  size: 20, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(height: 1, color: Color(0xFFE2E8F0)),
                        const SizedBox(height: 16),

                        // Target Student
                        Text(
                          "Target Student",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (isSpecific) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFF0F172A)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${student["name"]} (${(student["roll"] as String).split(" · ")[0]} · ${student["dept"]})",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Risk Tier: ${student["tier"]} · Overall: ${student["overall"]}/100",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFDC2626),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: studentOptions.contains(selectedStudentName)
                                    ? selectedStudentName
                                    : studentOptions.first,
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                    size: 18, color: Color(0xFF64748B)),
                                style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    color: const Color(0xFF0F172A)),
                                items: studentOptions
                                    .map((it) => DropdownMenuItem(
                                        value: it,
                                        child: Text(it,
                                            overflow: TextOverflow.ellipsis)))
                                    .toList(),
                                onChanged: (v) => setModalState(
                                    () => selectedStudentName = v!),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 14),

                        // Support Strategy
                        Text(
                          "Support Strategy",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedStrategy,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                  size: 18, color: Color(0xFF64748B)),
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: const Color(0xFF0F172A)),
                              items: const [
                                "1-on-1 Faculty Mentorship",
                                "Academic Remediation Tutoring",
                                "Placement & Mock Interview Prep",
                                "Coursework & Quiz Completion Sprint",
                                "Counsellor Wellness & Check-in",
                              ]
                                  .map((it) => DropdownMenuItem(
                                      value: it, child: Text(it)))
                                  .toList(),
                              onChanged: (v) => setModalState(
                                  () => selectedStrategy = v!),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Assigned Faculty / Advisor Lead
                        Text(
                          "Assigned Faculty / Advisor Lead",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedFaculty,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                  size: 18, color: Color(0xFF64748B)),
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: const Color(0xFF0F172A)),
                              items: const [
                                "far",
                                "Dr. Meena Raghavan",
                                "Department Faculty",
                                "Dr. Anand V.",
                                "Prof. Priya Sharma",
                              ]
                                  .map((it) => DropdownMenuItem(
                                      value: it, child: Text(it)))
                                  .toList(),
                              onChanged: (v) => setModalState(
                                  () => selectedFaculty = v!),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Target Review / Follow-up Date
                        Text(
                          "Target Review / Follow-up Date",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: dateCtrl,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: const Color(0xFF0F172A)),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now().add(const Duration(days: 14)),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(const Duration(days: 365)),
                                  );
                                  if (picked != null) {
                                    final month = picked.month.toString().padLeft(2, '0');
                                    final day = picked.day.toString().padLeft(2, '0');
                                    dateCtrl.text = "$month/$day/${picked.year}";
                                  }
                                },
                                child: const Icon(Icons.calendar_today_outlined,
                                    size: 16, color: Color(0xFF0F172A)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Case Notes & Specific Instructions
                        Text(
                          "Case Notes & Specific Instructions",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 90,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: TextField(
                            controller: notesCtrl,
                            maxLines: 4,
                            style: GoogleFonts.poppins(fontSize: 12),
                            decoration: const InputDecoration(
                              hintText:
                                  "Record specific topics, weakness patterns, or next meeting agenda...",
                              hintStyle: TextStyle(
                                  fontSize: 11, color: Color(0xFF94A3B8)),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(height: 1, color: Color(0xFFE2E8F0)),
                        const SizedBox(height: 16),

                        // Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.of(dialogCtx).pop(),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                side: const BorderSide(
                                    color: Color(0xFFCBD5E1)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                final sName = isSpecific
                                    ? student["name"] as String
                                    : selectedStudentName.split(" (")[0];

                                setState(() {
                                  _supportPlans.insert(0, {
                                    "student": sName,
                                    "strategy": selectedStrategy,
                                    "faculty": selectedFaculty,
                                    "targetDate": dateCtrl.text,
                                    "notes": notesCtrl.text,
                                    "created": "Today",
                                  });
                                });

                                Navigator.of(dialogCtx).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Support plan for '$sName' logged successfully!",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: const Color(0xFF10B981),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.check_rounded,
                                  size: 16, color: Colors.white),
                              label: Text(
                                "Confirm Support Plan",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E2865),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
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
          },
        );
      },
    );
  }

  // ===========================================================================
  // TAB 1: Cohort Risk Analytics & Trends (Image 3)
  // ===========================================================================
  Widget _buildTab1Analytics() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 850;

        final topCards = [
          _buildAnalyticsCard(
            title: "Risk Distribution by Department",
            child: _buildRiskDistributionChart(),
          ),
          _buildAnalyticsCard(
            title: "Top Signal Deficit Drivers",
            child: _buildDeficitDriversList(),
          ),
        ];

        return Column(
          children: [
            if (isWide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: topCards[0]),
                  const SizedBox(width: 16),
                  Expanded(child: topCards[1]),
                ],
              )
            else ...[
              topCards[0],
              const SizedBox(height: 16),
              topCards[1],
            ],
            const SizedBox(height: 16),
            _buildAnalyticsCard(
              title: "Cohort Trend: Flagged vs. Resolved (Last 6 Months)",
              child: _buildTrendChart(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnalyticsCard({required String title, required Widget child}) {
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
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildRiskDistributionChart() {
    final depts = [
      {"dept": "CSE", "critical": 5, "moderate": 1, "watchlist": 1},
      {"dept": "IT", "critical": 1, "moderate": 0, "watchlist": 0},
      {"dept": "ECE", "critical": 0, "moderate": 0, "watchlist": 0},
      {"dept": "AI&DS", "critical": 0, "moderate": 0, "watchlist": 0},
    ];

    return Column(
      children: depts.map((d) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  d["dept"] as String,
                  style: GoogleFonts.poppins(
                      fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    height: 12,
                    child: Row(
                      children: [
                        if ((d["critical"] as int) > 0)
                          Expanded(
                            flex: d["critical"] as int,
                            child: Container(color: const Color(0xFFE11D48)),
                          ),
                        if ((d["moderate"] as int) > 0)
                          Expanded(
                            flex: d["moderate"] as int,
                            child: Container(color: const Color(0xFFD97706)),
                          ),
                        if ((d["watchlist"] as int) > 0)
                          Expanded(
                            flex: d["watchlist"] as int,
                            child: Container(color: const Color(0xFF0284C7)),
                          ),
                        Expanded(
                          flex: 10 -
                              ((d["critical"] as int) +
                                  (d["moderate"] as int) +
                                  (d["watchlist"] as int)),
                          child: Container(color: const Color(0xFFF1F5F9)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "${(d["critical"] as int) + (d["moderate"] as int) + (d["watchlist"] as int)} at-risk",
                style: GoogleFonts.poppins(
                    fontSize: 10, color: const Color(0xFF64748B)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDeficitDriversList() {
    final drivers = [
      {"name": "Zero Quizzes Attempted", "count": 5, "color": const Color(0xFFE11D48)},
      {"name": "No Verified Certifications", "count": 5, "color": const Color(0xFFE11D48)},
      {"name": "Placement Readiness Alert (0/100)", "count": 5, "color": const Color(0xFFE11D48)},
      {"name": "Mock Technical Interview Pending", "count": 6, "color": const Color(0xFFD97706)},
      {"name": "Resume ATS Benchmark Missing", "count": 6, "color": const Color(0xFFD97706)},
    ];

    return Column(
      children: drivers.map((dr) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  dr["name"] as String,
                  style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF334155)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: (dr["color"] as Color).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "${dr["count"]} students",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: dr["color"] as Color,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTrendChart() {
    return SizedBox(
      height: 120,
      child: Center(
        child: Text(
          "6-Month Cohort Trend Analysis (Interactive Chart Placeholder)",
          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
        ),
      ),
    );
  }

  // ===========================================================================
  // TAB 2: Support Plans & Case Log (Image 4)
  // ===========================================================================
  Widget _buildTab2SupportPlans() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 650;
            final headerTexts = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Support Action Plans & Mentorship Log",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Active interventions scheduled by academic advisors, department heads, and counsellors.",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            );

            final newButton = ElevatedButton.icon(
              onPressed: () => _showScheduleSupportPlanModal(),
              icon: const Icon(Icons.add_rounded, size: 16, color: Colors.white),
              label: Text(
                "Schedule Support Action",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            );

            if (isSmall) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerTexts,
                  const SizedBox(height: 10),
                  newButton,
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: headerTexts),
                const SizedBox(width: 12),
                newButton,
              ],
            );
          },
        ),
        const SizedBox(height: 16),

        if (_supportPlans.isEmpty) ...[
          // Empty state card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: const Icon(
                    Icons.assignment_outlined,
                    size: 24,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "No Support Plans Logged Yet",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Text(
                    "Click 'Schedule Support Action' to log 1-on-1 mentorship, remedial sessions, or counselling reviews.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          // List of support plan cards
          ..._supportPlans.map((sp) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.assignment_ind_outlined,
                        size: 20, color: Color(0xFF4F46E5)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              sp["student"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0F2FE),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                sp["strategy"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0284C7),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Lead: ${sp["faculty"]} · Review Date: ${sp["targetDate"]}${sp["notes"] != "" ? " · Notes: ${sp["notes"]}" : ""}",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "In Progress",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFD97706),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }
}

// =============================================================================
// GRID PAINTER
// =============================================================================

class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    const double step = 28;
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
