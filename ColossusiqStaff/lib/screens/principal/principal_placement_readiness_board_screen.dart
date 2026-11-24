import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalPlacementReadinessBoardScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalPlacementReadinessBoardScreen({super.key, this.onBack});

  @override
  State<PrincipalPlacementReadinessBoardScreen> createState() =>
      _PrincipalPlacementReadinessBoardScreenState();
}

class _PrincipalPlacementReadinessBoardScreenState
    extends State<PrincipalPlacementReadinessBoardScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedDept = "All";
  String _selectedTier = "All";
  String _selectedDrive = "Any drive";

  final List<Map<String, dynamic>> _students = [
    {
      "name": "Anand Kumar",
      "maskedRoll": "*****4001 · Computer Science & Engineering",
      "fullRoll": "110124001 · Computer Science & Engineering · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "72%",
      "certs": "7",
      "aptitude": "67",
      "interview": "17",
      "resume": "72",
      "total": 69,
      "status": "Almost ready",
      "statusType": "almost",
      "gap": "Score 50+ in a mock interview",
      "skills": ["Core Java", "Algorithms", "Database Systems"],
      "gaps": ["Mock Technical Interview"],
      "aiPlan": "Complete 2 timed mock interviews with feedback to bridge the gap to 70+ cutoff.",
    },
    {
      "name": "Divya Ramesh",
      "maskedRoll": "*****4002 · Computer Science & Engineering",
      "fullRoll": "110124002 · Computer Science & Engineering · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "100%",
      "certs": "1",
      "aptitude": "0",
      "interview": "0",
      "resume": "0",
      "total": 40,
      "status": "Needs work",
      "statusType": "needs",
      "gap": "Earn 1 more certificate(s)",
      "skills": ["Java Foundations", "OOP"],
      "gaps": ["Verified Certificates", "Aptitude Assessment", "Technical Interview"],
      "aiPlan": "Complete AWS Cloud or Machine Learning proctored certification and take mock interview.",
    },
    {
      "name": "bala",
      "maskedRoll": "*****9861 · Computer Science & Engineering",
      "fullRoll": "27549861 · Computer Science & Engineering · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "0%",
      "certs": "0",
      "aptitude": "0",
      "interview": "0",
      "resume": "0",
      "total": 0,
      "status": "Needs work",
      "statusType": "needs",
      "gap": "Raise your quiz average to 60%",
      "skills": ["Machine Learning", "Advanced Java", "Object-Oriented Programming with Java"],
      "gaps": ["Raise your quiz average to 60%", "Earn 2 more certificate(s)", "Score 50+ in a mock interview"],
      "aiPlan": "Recommended to enroll in the next upcoming bridge workshop for 'Raise your quiz average to 60%' to clear recruiter cutoff.",
    },
    {
      "name": "Kirshna",
      "maskedRoll": "*****4788 · Computer Science & Engineering",
      "fullRoll": "21CS4788 · Computer Science & Engineering · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "0%",
      "certs": "0",
      "aptitude": "0",
      "interview": "0",
      "resume": "0",
      "total": 0,
      "status": "Needs work",
      "statusType": "needs",
      "gap": "Raise your quiz average to 60%",
      "skills": ["Python Basics", "Web Tech"],
      "gaps": ["Quiz Average", "Certificates", "Interview"],
      "aiPlan": "Enroll in remedial lecture and mock interview sprint.",
    },
    {
      "name": "Karthik Raja",
      "maskedRoll": "*****4003 · Information Technology",
      "fullRoll": "110124003 · Information Technology · 2023–2027 (Final Year)",
      "dept": "Information Technology",
      "quiz": "0%",
      "certs": "0",
      "aptitude": "0",
      "interview": "0",
      "resume": "0",
      "total": 0,
      "status": "Needs work",
      "statusType": "needs",
      "gap": "Raise your quiz average to 60%",
      "skills": ["Cloud Architecture"],
      "gaps": ["Quiz Average", "Certificates", "Resume ATS"],
      "aiPlan": "Schedule academic counseling check-in.",
    },
    {
      "name": "Suganya",
      "maskedRoll": "*****1478 · Computer Science & Engineering",
      "fullRoll": "52CS1478 · Computer Science & Engineering · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "0%",
      "certs": "0",
      "aptitude": "0",
      "interview": "0",
      "resume": "0",
      "total": 0,
      "status": "Needs work",
      "statusType": "needs",
      "gap": "Raise your quiz average to 60%",
      "skills": ["SQL", "Data Structures"],
      "gaps": ["Quiz Average", "Certificates"],
      "aiPlan": "Enroll in normalization mastery session.",
    },
    {
      "name": "Praveen Kumar",
      "maskedRoll": "*****4005 · Computer Science & Engineering",
      "fullRoll": "110124005 · Computer Science & Engineering · 2023–2027 (Final Year)",
      "dept": "Computer Science & Engineering",
      "quiz": "0%",
      "certs": "0",
      "aptitude": "0",
      "interview": "0",
      "resume": "0",
      "total": 0,
      "status": "Needs work",
      "statusType": "needs",
      "gap": "Raise your quiz average to 60%",
      "skills": ["Computer Networks"],
      "gaps": ["Quiz Average", "Certificates", "Interview"],
      "aiPlan": "Attend bridge course for placement clearance.",
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
      color: const Color(0xFFFAF9F5),
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
                // 1. Hero Blueprint Banner (Image 1)
                _buildHeroBanner(),
                const SizedBox(height: 14),

                // Live status row
                _buildLiveStatusRow(),
                const SizedBox(height: 14),

                // 2. 5 Metric KPI Cards (Image 1)
                _buildKpiCards(constraints.maxWidth),
                const SizedBox(height: 16),

                // 3. Formula Info Box (Image 1)
                _buildFormulaBox(),
                const SizedBox(height: 16),

                // 4. Readiness Board Table Card (Image 1)
                _buildReadinessBoardCard(),
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
      width: double.infinity,
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
                opacity: 0.08,
                child: const Icon(
                  Icons.track_changes_rounded,
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
                          "Placement",
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
                          "Placement Readiness Board",
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

                  // Badges: PLACEMENT, MVP
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
                          "PLACEMENT",
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
                          color: const Color(0xFF0D9488),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "MVP",
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
                            Icons.track_changes_rounded,
                            color: Color(0xFFFBBF24),
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
                              "Placement Readiness Board",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Every student's readiness total, gaps and status — filter, shortlist and export for drives.",
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

  Widget _buildLiveStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Live · updated 12:25:31 pm",
          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.sync_rounded, size: 14, color: Color(0xFF475569)),
          label: Text(
            "Refresh",
            style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF475569)),
          ),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 2. 5 METRIC KPI CARDS (Image 1)
  // ===========================================================================
  Widget _buildKpiCards(double maxWidth) {
    double cardWidth;
    if (maxWidth >= 1100) {
      cardWidth = (maxWidth - (4 * 10)) / 5;
    } else if (maxWidth >= 750) {
      cardWidth = (maxWidth - (2 * 10)) / 3;
    } else if (maxWidth >= 500) {
      cardWidth = (maxWidth - 10) / 2;
    } else {
      cardWidth = maxWidth;
    }

    final cards = [
      _buildSingleKpi("Students tracked", Icons.people_outline_rounded, "7"),
      _buildSingleKpi("Placement ready", Icons.check_circle_outline_rounded, "0"),
      _buildSingleKpi("Almost ready", Icons.hourglass_top_rounded, "1"),
      _buildSingleKpi("Needs work", Icons.warning_amber_rounded, "6"),
      _buildSingleKpi("Average total", Icons.show_chart_rounded, "16"),
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

  Widget _buildSingleKpi(String title, IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: const Color(0xFF64748B)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. FORMULA BOX (Image 1)
  // ===========================================================================
  Widget _buildFormulaBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEFE8DD)),
      ),
      child: Text(
        "Placement ready = total ≥ 70, quiz average ≥ 60%, ≥ 2 certificates and mock interview ≥ 50. Total = quiz 35% + certificates 20% + aptitude 15% + interview 15% + resume 15%.",
        style: GoogleFonts.poppins(
          fontSize: 11,
          color: const Color(0xFF78350F),
          height: 1.4,
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. READINESS BOARD CARD & TABLE (Image 1)
  // ===========================================================================
  Widget _buildReadinessBoardCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
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
                        "Readiness board",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Roll numbers masked · export only what a drive needs",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_rounded,
                      size: 14, color: Color(0xFF475569)),
                  label: Text(
                    "Export shortlist (CSV)",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),

          // Filters Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 650;
                if (isNarrow) {
                  return Column(
                    children: [
                      _buildSearchField(),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: _buildFilterDropdown("Dept", _selectedDept, ["All", "CSE", "IT", "AI&DS"], (v) => setState(() => _selectedDept = v!))),
                          const SizedBox(width: 8),
                          Expanded(child: _buildFilterDropdown("Tier", _selectedTier, ["All", "Almost ready", "Needs work"], (v) => setState(() => _selectedTier = v!))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildFilterDropdown("Drive", _selectedDrive, ["Any drive", "TCS", "Zoho", "Amazon AWS"], (v) => setState(() => _selectedDrive = v!)),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(flex: 3, child: _buildSearchField()),
                    const SizedBox(width: 10),
                    Expanded(flex: 2, child: _buildFilterDropdown("Dept", _selectedDept, ["All", "CSE", "IT", "AI&DS"], (v) => setState(() => _selectedDept = v!))),
                    const SizedBox(width: 10),
                    Expanded(flex: 2, child: _buildFilterDropdown("Tier", _selectedTier, ["All", "Almost ready", "Needs work"], (v) => setState(() => _selectedTier = v!))),
                    const SizedBox(width: 10),
                    Expanded(flex: 3, child: _buildFilterDropdown("Drive", _selectedDrive, ["Any drive", "TCS", "Zoho", "Amazon AWS"], (v) => setState(() => _selectedDrive = v!))),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 950),
              child: DataTable(
                columnSpacing: 18,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 68,
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFF7F4EE)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                columns: const [
                  DataColumn(label: Text("STUDENT")),
                  DataColumn(label: Text("QUIZ AVG")),
                  DataColumn(label: Text("CERTS")),
                  DataColumn(label: Text("APTITUDE")),
                  DataColumn(label: Text("INTERVIEW")),
                  DataColumn(label: Text("RESUME")),
                  DataColumn(label: Text("TOTAL ↓")),
                  DataColumn(label: Text("STATUS")),
                ],
                rows: _students.map((s) {
                  final total = s["total"] as int;
                  final statusType = s["statusType"] as String;
                  final isAlmost = statusType == "almost";

                  final statusBg = isAlmost ? const Color(0xFFFEF3C7) : const Color(0xFFFFE4E6);
                  final statusFg = isAlmost ? const Color(0xFFD97706) : const Color(0xFFE11D48);

                  return DataRow(
                    cells: [
                      // Student & Masked Roll
                      DataCell(
                        InkWell(
                          onTap: () => _showStudentProfileModal(s),
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
                                s["maskedRoll"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Quiz Avg
                      DataCell(
                        Text(
                          s["quiz"] as String,
                          style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      // Certs
                      DataCell(
                        Text(
                          s["certs"] as String,
                          style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      // Aptitude
                      DataCell(
                        Text(
                          s["aptitude"] as String,
                          style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      // Interview
                      DataCell(
                        Text(
                          s["interview"] as String,
                          style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      // Resume
                      DataCell(
                        Text(
                          s["resume"] as String,
                          style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      // Total & progress bar
                      DataCell(
                        Row(
                          children: [
                            Text(
                              "$total",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 32,
                              child: LinearProgressIndicator(
                                value: total / 100,
                                backgroundColor: const Color(0xFFF1F5F9),
                                valueColor: AlwaysStoppedAnimation(
                                  total >= 60
                                      ? const Color(0xFF131B4D)
                                      : (total >= 40 ? const Color(0xFFB45309) : const Color(0xFFCBD5E1)),
                                ),
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status & gap hint
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusBg,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                s["status"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: statusFg,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              s["gap"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                color: const Color(0xFF94A3B8),
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

  Widget _buildSearchField() {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.poppins(fontSize: 12),
        decoration: const InputDecoration(
          hintText: "Search student",
          hintStyle: TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF0F172A)),
          items: items.map((it) => DropdownMenuItem(value: it, child: Text(it))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ===========================================================================
  // STUDENT PROFILE MODAL (Matching Reference Image)
  // ===========================================================================
  void _showStudentProfileModal(Map<String, dynamic> student) {
    final skills = (student["skills"] as List<String>?) ??
        const [
          "Machine Learning",
          "Advanced Java",
          "Object-Oriented Programming with Java",
        ];
    final gaps = (student["gaps"] as List<String>?) ??
        const [
          "Raise your quiz average to 60%",
          "Earn 2 more certificate(s)",
          "Score 50+ in a mock interview",
        ];
    final aiPlan = (student["aiPlan"] as String?) ??
        "Recommended to enroll in the next upcoming bridge workshop for \"Raise your quiz average to 60%\" to clear recruiter cutoff.";

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                                student["fullRoll"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(dialogCtx).pop(),
                          icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    const SizedBox(height: 18),

                    // Readiness Score Card (Cream)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF7F2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFEFE8DD)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Placement Readiness Total",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFE4E6),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  student["status"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFE11D48),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${student["total"]} / 100",
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Demonstrated Strengths
                    if (skills.isNotEmpty) ...[
                      Text(
                        "DEMONSTRATED STRENGTHS & TOP SKILLS",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: skills.map((sk) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6F7F5),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFB2EBF2)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.check_rounded, size: 14, color: Color(0xFF0D9488)),
                                const SizedBox(width: 5),
                                Text(
                                  sk,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF0D9488),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Remediation Gap Areas
                    if (gaps.isNotEmpty) ...[
                      Text(
                        "REMEDIATION GAP AREAS",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: gaps.map((g) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF2F2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFFECACA)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.warning_amber_rounded, size: 14, color: Color(0xFFDC2626)),
                                const SizedBox(width: 5),
                                Text(
                                  g,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFDC2626),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // AI Mentor Action Plan Box
                    if (aiPlan.isNotEmpty) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF475569),
                              height: 1.45,
                            ),
                            children: [
                              const TextSpan(
                                text: "AI Mentor Action Plan: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              TextSpan(text: aiPlan),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],

                    // Close Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.of(dialogCtx).pop(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            "Close Profile",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
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
      },
    );
  }
}

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
