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
              crossAxisAlignment: CrossAxisAlignment.start,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
  // 3. FILTER & ACTION TOOLBAR (Image 1)
  // ===========================================================================
  Widget _buildFilterToolbar() {
    return Container(
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
          final isSmall = constraints.maxWidth < 900;

          final filterInputs = Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildDropdownPill(_selectedDept, _departments,
                  (v) => setState(() => _selectedDept = v!)),
              _buildDropdownPill(_selectedLevel, _levels,
                  (v) => setState(() => _selectedLevel = v!)),
              _buildDropdownPill(_selectedStatus, _statuses,
                  (v) => setState(() => _selectedStatus = v!)),
              // Search input
              Container(
                height: 38,
                width: 220,
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
                    hintStyle:
                        TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
                    prefixIcon: Icon(Icons.search_rounded,
                        size: 16, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                ),
              ),
            ],
          );

          final actionButtons = Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sync_rounded,
                    size: 14, color: Color(0xFF475569)),
                label: Text("Refresh",
                    style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF475569))),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download_rounded,
                    size: 14, color: Color(0xFF475569)),
                label: Text("Audit CSV",
                    style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF475569))),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          );

          if (isSmall) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                filterInputs,
                const SizedBox(height: 12),
                actionButtons,
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: filterInputs),
              const SizedBox(width: 12),
              actionButtons,
            ],
          );
        },
      ),
    );
  }

  Widget _buildDropdownPill(
      String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 16, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
              fontSize: 11.5, color: const Color(0xFF0F172A)),
          items: items
              .map((it) => DropdownMenuItem(value: it, child: Text(it)))
              .toList(),
          onChanged: onChanged,
        ),
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
        badge: "0 critical",
        badgeBg: const Color(0xFFFEF3C7),
        badgeColor: const Color(0xFFD97706),
        value: "10",
        subtext: "Students with academic, certification..",
      ),
      _buildSingleKpi(
        title: "Critical Risk Flags",
        badge: "Urgent review",
        badgeBg: const Color(0xFFCCFBF1),
        badgeColor: const Color(0xFF0D9488),
        value: "0",
        subtext: "Requires faculty counsellor or tutor in..",
      ),
      _buildSingleKpi(
        title: "Active Support Plans",
        badge: "0 total logged",
        badgeBg: const Color(0xFFE0F2FE),
        badgeColor: const Color(0xFF0284C7),
        value: "0",
        subtext: "Interventions currently assigned and ..",
      ),
      _buildSingleKpi(
        title: "Resolved / On Track",
        badge: "29% cohort",
        badgeBg: const Color(0xFFCCFBF1),
        badgeColor: const Color(0xFF0D9488),
        value: "4",
        subtext: "Students cleared of risk flags or met r..",
      ),
      _buildSingleKpi(
        title: "Cohort Avg Readiness",
        badge: "Satisfactory",
        badgeBg: const Color(0xFFCCFBF1),
        badgeColor: const Color(0xFF0D9488),
        value: "65 / 100",
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
          // Title + Badge (Responsive Wrap so title never breaks letters vertically)
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

          // Value
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 3),

          // Subtext
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
      {"label": "At-Risk Students Roster", "count": "14", "icon": Icons.people_outline_rounded},
      {"label": "Cohort Risk Analytics & Trends", "count": null, "icon": Icons.insert_chart_outlined_rounded},
      {"label": "Support Plans & Case Log", "count": "0", "icon": Icons.assignment_outlined},
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
    final rosterStudents = [
      {
        "name": "Kavya Menon",
        "roll": "110121006 · 2023–2027 (Final Year)",
        "dept": "Computer Science & Engineering",
        "quiz": "48%",
        "quizAlert": true,
        "certs": "1",
        "interview": "75",
        "resume": "89",
        "overall": 55,
        "tier": "Watchlist",
        "tierType": "watchlist",
        "signals": ["Low Quiz Average (48%)"],
        "status": "Pending review",
        "statusType": "pending",
      },
      {
        "name": "Sanjay Pillai",
        "roll": "110121007 · 2023–2027 (Final Year)",
        "dept": "Information Technology",
        "quiz": "80%",
        "quizAlert": false,
        "certs": "3",
        "interview": "85",
        "resume": "93",
        "overall": 81,
        "tier": "Low Risk",
        "tierType": "low",
        "signals": <String>[],
        "status": "Resolved",
        "statusType": "resolved",
      },
      {
        "name": "Nandini Krishnan",
        "roll": "110121014 · 2023–2027 (Final Year)",
        "dept": "Artificial Intelligence & Data Science",
        "quiz": "60%",
        "quizAlert": false,
        "certs": "4",
        "interview": "76",
        "resume": "86",
        "overall": 75,
        "tier": "Low Risk",
        "tierType": "low",
        "signals": <String>[],
        "status": "Resolved",
        "statusType": "resolved",
      },
      {
        "name": "Joseph Patel",
        "roll": "110121021 · 2023–2027 (Final Year)",
        "dept": "Electronics & Communication",
        "quiz": "47%",
        "quizAlert": true,
        "certs": "4",
        "interview": "37",
        "interviewAlert": true,
        "resume": "54",
        "overall": 61,
        "tier": "Watchlist",
        "tierType": "watchlist",
        "signals": [
          "Low Quiz Average (47%)",
          "Low Interview Score (37/100)"
        ],
        "status": "Pending review",
        "statusType": "pending",
      },
      {
        "name": "Deepika Das",
        "roll": "110121028 · 2023–2027 (Final Year)",
        "dept": "Electrical & Electronics",
        "quiz": "68%",
        "quizAlert": false,
        "certs": "4",
        "interview": "69",
        "resume": "75",
        "overall": 77,
        "tier": "Low Risk",
        "tierType": "low",
        "signals": <String>[],
        "status": "Resolved",
        "statusType": "resolved",
      },
      {
        "name": "Gokul Rao",
        "roll": "110121035 · 2023–2027 (Final Year)",
        "dept": "Mechanical Engineering",
        "quiz": "65%",
        "quizAlert": false,
        "certs": "1",
        "interview": "52",
        "resume": "95",
        "overall": 64,
        "tier": "Watchlist",
        "tierType": "watchlist",
        "signals": <String>[],
        "status": "Pending review",
        "statusType": "pending",
      },
      {
        "name": "Keerthana Joseph",
        "roll": "110121042 · 2023–2027 (Final Year)",
        "dept": "Civil Engineering",
        "quiz": "66%",
        "quizAlert": false,
        "certs": "1",
        "interview": "49",
        "interviewAlert": true,
        "resume": "52",
        "overall": 53,
        "overallAlert": true,
        "tier": "Moderate",
        "tierType": "moderate",
        "signals": [
          "Low Interview Score (49/100)",
          "Placement Readiness Alert (53/100)"
        ],
        "status": "Pending review",
        "statusType": "pending",
      },
      {
        "name": "Karthik Khan",
        "roll": "110121049 · 2023–2027 (Final Year)",
        "dept": "Science & Humanities",
        "quiz": "77%",
        "quizAlert": false,
        "certs": "0",
        "certsAlert": true,
        "interview": "47",
        "interviewAlert": true,
        "resume": "76",
        "overall": 52,
        "overallAlert": true,
        "tier": "Moderate",
        "tierType": "moderate",
        "signals": [
          "No Verified Certifications",
          "Low Interview Score (47/100)",
          "Placement Readiness Alert (52/100)"
        ],
        "status": "Pending review",
        "statusType": "pending",
      },
      {
        "name": "Sneha Srinivasan",
        "roll": "110121056 · 2023–2027 (Final Year)",
        "dept": "Computer Science & Engineering",
        "quiz": "88%",
        "quizAlert": false,
        "certs": "4",
        "interview": "49",
        "interviewAlert": true,
        "resume": "65",
        "overall": 78,
        "tier": "Watchlist",
        "tierType": "watchlist",
        "signals": ["Low Interview Score (49/100)"],
        "status": "Pending review",
        "statusType": "pending",
      },
      {
        "name": "Arjun Varma",
        "roll": "110121063 · 2023–2027 (Final Year)",
        "dept": "Information Technology",
        "quiz": "59%",
        "quizAlert": false,
        "certs": "3",
        "interview": "85",
        "resume": "67",
        "overall": 70,
        "tier": "Low Risk",
        "tierType": "low",
        "signals": <String>[],
        "status": "Resolved",
        "statusType": "resolved",
      },
      {
        "name": "Kavya Gupta",
        "roll": "110121070 · 2023–2027 (Final Year)",
        "dept": "Artificial Intelligence & Data Science",
        "quiz": "59%",
        "quizAlert": false,
        "certs": "0",
        "certsAlert": true,
        "interview": "55",
        "resume": "57",
        "overall": 44,
        "overallAlert": true,
        "tier": "Moderate",
        "tierType": "moderate",
        "signals": [
          "No Verified Certifications",
          "Placement Readiness Alert (44/100)"
        ],
        "status": "Pending review",
        "statusType": "pending",
      },
      {
        "name": "Sanjay Balaji",
        "roll": "110121077 · 2023–2027 (Final Year)",
        "dept": "Electronics & Communication",
        "quiz": "72%",
        "quizAlert": false,
        "certs": "1",
        "interview": "62",
        "resume": "88",
        "overall": 64,
        "tier": "Watchlist",
        "tierType": "watchlist",
        "signals": <String>[],
        "status": "Pending review",
        "statusType": "pending",
      },
    ];

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
                  "Showing 14 student(s)",
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
                dataRowMaxHeight: 68,
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
                rows: rosterStudents.map((s) {
                  final isQuizAlert = s["quizAlert"] as bool? ?? false;
                  final isInterviewAlert = s["interviewAlert"] as bool? ?? false;
                  final isCertsAlert = s["certsAlert"] as bool? ?? false;
                  final isOverallAlert = s["overallAlert"] as bool? ?? false;

                  final tierType = s["tierType"] as String;
                  Color tierBg;
                  Color tierColor;
                  if (tierType == "moderate") {
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
                        Column(
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
                                children: signals
                                    .map(
                                      (sig) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFEF3C7),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          sig,
                                          style: GoogleFonts.poppins(
                                            fontSize: 9.5,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFB45309),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
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
                              onPressed: () {},
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
                              onPressed: () {},
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
  // TAB 1: Cohort Risk Analytics & Trends (Image 3)
  // ===========================================================================
  Widget _buildTab1Analytics() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 850;

        final topCards = [
          _buildAnalyticsCard(
            title: "Student Risk & Watchlist Tier Distribution",
            chart: _buildBarChart4([
              {"label": "Critical", "val": 0},
              {"label": "Moderate", "val": 3},
              {"label": "Watchlist", "val": 7},
              {"label": "Low Risk", "val": 4},
            ], maxVal: 8, barColor: const Color(0xFF131B4D)),
          ),
          _buildAnalyticsCard(
            title: "Observed Deficit Signals Across Cohort",
            chart: _buildBarChart4([
              {"label": "Low Quiz Avg (<50%)", "val": 4},
              {"label": "No Certs (0)", "val": 2},
              {"label": "Interview Gap (<50)", "val": 5},
              {"label": "Readiness Alert (<55)", "val": 3},
            ], maxVal: 8, barColor: const Color(0xFF131B4D)),
          ),
        ];

        final bottomCards = [
          _buildAnalyticsCard(
            title: "Flagged Cases by Department",
            chart: Column(
              children: [
                _buildDepartmentBarChart(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: Color(0xFF131B4D), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 4),
                    Text("critical",
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: const Color(0xFF475569))),
                    const SizedBox(width: 14),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: Color(0xFFD4AF37), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 4),
                    Text("moderate",
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: const Color(0xFF475569))),
                  ],
                ),
              ],
            ),
          ),
          _buildInstitutionalGuidanceCard(),
        ];

        if (isWide) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: topCards[0]),
                  const SizedBox(width: 16),
                  Expanded(child: topCards[1]),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: bottomCards[0]),
                  const SizedBox(width: 16),
                  Expanded(child: bottomCards[1]),
                ],
              ),
            ],
          );
        }

        return Column(
          children: [
            topCards[0],
            const SizedBox(height: 16),
            topCards[1],
            const SizedBox(height: 16),
            bottomCards[0],
            const SizedBox(height: 16),
            bottomCards[1],
          ],
        );
      },
    );
  }

  Widget _buildAnalyticsCard({required String title, required Widget chart}) {
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
          chart,
        ],
      ),
    );
  }

  Widget _buildBarChart4(List<Map<String, dynamic>> items,
      {required double maxVal, required Color barColor}) {
    const double chartH = 120.0;
    return SizedBox(
      height: 155,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Y-axis
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("8",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("6",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("4",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("2",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("0",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
            ],
          ),
          const SizedBox(width: 12),

          // Bars
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.map((it) {
                final val = (it["val"] as num).toDouble();
                final barH = val == 0 ? 3.0 : (val / maxVal) * chartH;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 20,
                      height: barH,
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(3)),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 65,
                      child: Text(
                        it["label"] as String,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 8.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentBarChart() {
    const double maxH = 120.0;
    final depts = [
      {"label": "Information Te..", "val": 0.0},
      {"label": "Electronics & ..", "val": 1.0},
      {"label": "Mechanical Eng..", "val": 0.0},
      {"label": "Science & Huma..", "val": 1.0},
    ];

    return SizedBox(
      height: 155,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Y-axis
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("1",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("0.75",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("0.5",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("0.25",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("0",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
            ],
          ),
          const SizedBox(width: 12),

          // Bars
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: depts.map((d) {
                final val = d["val"] as double;
                final h = val == 0 ? 3.0 : (val / 1.0) * maxH;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 16,
                      height: h,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD4AF37), // Moderate Gold
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(3)),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 65,
                      child: Text(
                        d["label"] as String,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 8.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstitutionalGuidanceCard() {
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
            "Institutional Observations & Guidance",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          // Guidance 1
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7).withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFFD97706), width: 1.2),
                      ),
                      child: Center(
                        child: Text(
                          "1",
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFD97706)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "2 Flagged Students Have Zero Practical Certifications",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF78350F),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "Verified course certifications are a strong predictor of campus placement. Fast-track these students into departmental skill booster tracks.",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF92400E),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Data evidence: 2 out of 14 assessed students lack verified credentials.",
                  style: GoogleFonts.poppins(
                    fontSize: 9.5,
                    color: const Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Guidance 2
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF64748B), width: 1.2),
                      ),
                      child: Center(
                        child: Text(
                          "1",
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Establish Proactive Support Plans",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "No active mentorship cases have been scheduled yet. Use 'Create Support Plan' on flagged student records to assign faculty mentors.",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Data evidence: 0 support plans currently in progress.",
                  style: GoogleFonts.poppins(
                    fontSize: 9.5,
                    color: const Color(0xFF94A3B8),
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
              onPressed: () {},
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
