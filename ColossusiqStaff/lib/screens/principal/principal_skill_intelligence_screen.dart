import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalSkillIntelligenceScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalSkillIntelligenceScreen({super.key, this.onBack});

  @override
  State<PrincipalSkillIntelligenceScreen> createState() =>
      _PrincipalSkillIntelligenceScreenState();
}

class _PrincipalSkillIntelligenceScreenState
    extends State<PrincipalSkillIntelligenceScreen> {
  int _activeTab = 0;
  final TextEditingController _searchController = TextEditingController();

  String _selectedDept = "All Departments";
  String _selectedBatch = "All Batches";
  String _selectedDomain = "All Domains";

  final List<String> _departments = [
    "All Departments",
    "Computer Science & Engineering",
    "Information Technology",
    "Artificial Intelligence & Data Science",
    "Electronics & Communication Engineering",
    "Mechanical Engineering",
  ];

  final List<String> _batches = [
    "All Batches",
    "2023 - 2027 (Final Year)",
    "2024 - 2028 (Third Year)",
    "2025 - 2029 (Second Year)",
  ];

  final List<String> _domains = [
    "All Domains",
    "Core Software & Systems",
    "Data Science & AI",
    "Cloud & Infrastructure",
    "Embedded & IoT",
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
                const SizedBox(height: 18),

                // 2. FILTER & ACTION TOOLBAR (Image 1)
                _buildFilterToolbar(),
                const SizedBox(height: 18),

                // 3. 5 METRIC KPI CARDS (Image 1)
                _buildKpiCards(constraints.maxWidth),
                const SizedBox(height: 20),

                // 4. SUBTABS
                _buildSubTabs(),
                const SizedBox(height: 18),

                // 5. TAB CONTENT
                if (_activeTab == 0) _buildTab0SkillGap(),
                if (_activeTab == 1) _buildTab1StudentInventory(),
                if (_activeTab == 2) _buildTab2RecruiterBenchmarks(),
                if (_activeTab == 3) _buildTab3BridgeCourses(),
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
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.hub_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs (Scrollable on small devices)
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
                          "Skill Intelligence",
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

                  // Badges: DEPARTMENT, Phase 2
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
                          "Phase 2",
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
                            Icons.hub_rounded,
                            color: Color(0xFFFBBF24), // Yellow Nodes/Hub
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Skill Intelligence",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Skill distribution and gaps across batches versus industry demand.",
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
  // 2. FILTER & ACTION TOOLBAR (Image 1)
  // ===========================================================================
  Widget _buildFilterToolbar() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Dropdowns (Left) + Action Buttons (Right)
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 850;

              final dropdowns = Wrap(
                spacing: 12,
                runSpacing: 10,
                children: [
                  _buildDropdownField("DEPARTMENT", _selectedDept, _departments,
                      (v) => setState(() => _selectedDept = v!)),
                  _buildDropdownField("COHORT / BATCH", _selectedBatch,
                      _batches, (v) => setState(() => _selectedBatch = v!)),
                  _buildDropdownField("DOMAIN / STREAM", _selectedDomain,
                      _domains, (v) => setState(() => _selectedDomain = v!)),
                ],
              );

              final actionButtons = Column(
                crossAxisAlignment:
                    isSmall ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.sync_rounded,
                            size: 14, color: Color(0xFF475569)),
                        label: Text("Sync Live Data",
                            style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF475569))),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download_rounded,
                            size: 14, color: Color(0xFF475569)),
                        label: Text("Export CSV",
                            style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF475569))),
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
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _activeTab = 3);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF1E2865), // Deep Navy / Indigo
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      "Schedule Bridge Course",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );

              if (isSmall) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dropdowns,
                    const SizedBox(height: 14),
                    actionButtons,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: dropdowns),
                  const SizedBox(width: 14),
                  actionButtons,
                ],
              );
            },
          ),
          const SizedBox(height: 14),

          // Search Field
          Text(
            "SEARCH",
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 38,
            constraints: const BoxConstraints(maxWidth: 420),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.poppins(fontSize: 12),
              decoration: const InputDecoration(
                hintText: "Search skill, role, student..",
                hintStyle:
                    TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Active filter scope chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  "Active filter scope: ",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
                _buildScopeChip(_selectedDept),
                const SizedBox(width: 6),
                _buildScopeChip(_selectedBatch),
                const SizedBox(width: 6),
                _buildScopeChip(_selectedDomain),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
        ),
      ],
    );
  }

  Widget _buildScopeChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF334155),
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. 5 METRIC KPI CARDS (Image 1)
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
        title: "Students Profiled",
        badge: "Across active departments",
        badgeBg: const Color(0xFFEEF2FF),
        badgeColor: const Color(0xFF4F46E5),
        value: "14",
        subtext: "Enrolled students evaluated in active..",
      ),
      _buildSingleKpi(
        title: "Placement Ready",
        badge: "3 of 14 qualified",
        badgeBg: const Color(0xFFFEF3C7),
        badgeColor: const Color(0xFFD97706),
        value: "21%",
        subtext: "Score >= 70 across quizzes, certs &..",
      ),
      _buildSingleKpi(
        title: "Identified Skill Deficits",
        badge: "Below target benchmark",
        badgeBg: const Color(0xFFFFE4E6),
        badgeColor: const Color(0xFFE11D48),
        value: "3",
        subtext: "Curricular areas with < 65% cohort..",
        borderColor: const Color(0xFFFDA4AF), // Red/Pink accent outline
      ),
      _buildSingleKpi(
        title: "Verified Certificates",
        badge: "Issued to date",
        badgeBg: const Color(0xFFFEF3C7),
        badgeColor: const Color(0xFFD97706),
        value: "0",
        subtext: "Passed proctored assessments in this..",
      ),
      _buildSingleKpi(
        title: "Avg Readiness Score",
        badge: "Placement bar: 70",
        badgeBg: const Color(0xFFE0F2FE),
        badgeColor: const Color(0xFF0284C7),
        value: "65 / 100",
        subtext: "Weighted average across cohort..",
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
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor ?? const Color(0xFFE2E8F0)),
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
  // 4. SUBTABS (Image 1)
  // ===========================================================================
  Widget _buildSubTabs() {
    final tabs = [
      {"label": "Skill Gap & Industry Demand", "icon": null},
      {"label": "Student Skill Inventory", "icon": Icons.people_outline_rounded},
      {"label": "Recruiter Benchmarks & Trends", "icon": Icons.track_changes_rounded},
      {"label": "Bridge Courses (0)", "icon": null},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _activeTab == index;
          final t = tabs[index];
          return Padding(
            padding: const EdgeInsets.only(right: 18),
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
                    if (t["icon"] != null) ...[
                      Icon(t["icon"] as IconData,
                          size: 15,
                          color: isSelected
                              ? const Color(0xFF1E2865)
                              : const Color(0xFF64748B)),
                      const SizedBox(width: 6),
                    ],
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
  // TAB 0: Skill Gap & Industry Demand (Images 1 & 2)
  // ===========================================================================
  Widget _buildTab0SkillGap() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Two Side-by-Side Charts
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: _buildBarChartCard()),
                  const SizedBox(width: 16),
                  Expanded(flex: 5, child: _buildCompetencyBreakdownCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildBarChartCard(),
                const SizedBox(height: 16),
                _buildCompetencyBreakdownCard(),
              ],
            );
          },
        ),
        const SizedBox(height: 20),

        // AI Curricular Intervention Recommendations
        _buildAiRecommendationsCard(),
        const SizedBox(height: 20),

        // Skill Intelligence Matrix Table
        _buildSkillMatrixTable(),
      ],
    );
  }

  Widget _buildBarChartCard() {
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
            "Syllabus Target Benchmark vs. Real Cohort Mastery",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 20),

          // Custom dual-bar chart
          SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("80",
                        style: GoogleFonts.poppins(
                            fontSize: 9, color: const Color(0xFF94A3B8))),
                    Text("60",
                        style: GoogleFonts.poppins(
                            fontSize: 9, color: const Color(0xFF94A3B8))),
                    Text("40",
                        style: GoogleFonts.poppins(
                            fontSize: 9, color: const Color(0xFF94A3B8))),
                    Text("20",
                        style: GoogleFonts.poppins(
                            fontSize: 9, color: const Color(0xFF94A3B8))),
                    Text("0",
                        style: GoogleFonts.poppins(
                            fontSize: 9, color: const Color(0xFF94A3B8))),
                  ],
                ),
                const SizedBox(width: 8),

                // Bars
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildDualBar("DBMS", 75, 68),
                        const SizedBox(width: 14),
                        _buildDualBar("Operating Systems", 75, 68),
                        const SizedBox(width: 14),
                        _buildDualBar("Computer Networks", 75, 68),
                        const SizedBox(width: 14),
                        _buildDualBar("Machine Learning", 75, 60),
                        const SizedBox(width: 14),
                        _buildDualBar("Theory of Machines", 75, 56),
                        const SizedBox(width: 14),
                        _buildDualBar("Cloud Computing", 75, 62),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                    color: Color(0xFF131B4D), shape: BoxShape.circle),
              ),
              const SizedBox(width: 5),
              Text("Syllabus Target",
                  style: GoogleFonts.poppins(
                      fontSize: 10.5, color: const Color(0xFF475569))),
              const SizedBox(width: 16),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                    color: Color(0xFFD4AF37), shape: BoxShape.circle),
              ),
              const SizedBox(width: 5),
              Text("Cohort Mastery",
                  style: GoogleFonts.poppins(
                      fontSize: 10.5, color: const Color(0xFF475569))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDualBar(String label, double target, double actual) {
    const double maxHeight = 110.0;
    final targetH = (target / 100) * maxHeight;
    final actualH = (actual / 100) * maxHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 18,
              height: targetH,
              decoration: const BoxDecoration(
                color: Color(0xFF131B4D),
                borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
              ),
            ),
            const SizedBox(width: 3),
            Container(
              width: 18,
              height: actualH,
              decoration: const BoxDecoration(
                color: Color(0xFFD4AF37),
                borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 60,
          child: Text(
            label,
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
  }

  Widget _buildCompetencyBreakdownCard() {
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
            "Category Competency Breakdown",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 150,
            child: Center(
              child: CustomPaint(
                size: const Size(220, 140),
                painter: _RadarPlaceholderPainter(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              "Theory + Lab",
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // AI Curricular Intervention Recommendations (Image 2)
  Widget _buildAiRecommendationsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 650;
              final headerTitle = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.auto_awesome_rounded,
                      size: 16, color: Color(0xFF4F46E5)),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "AI Curricular Intervention Recommendations",
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ],
              );

              final headerSubtitle = Text(
                "Live recommendations based on current deficit",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              );

              if (isSmall) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerTitle,
                    const SizedBox(height: 4),
                    headerSubtitle,
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: headerTitle),
                  headerSubtitle,
                ],
              );
            },
          ),
          const SizedBox(height: 14),

          // 3 Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 850;
              final width =
                  isWide ? (constraints.maxWidth - 24) / 3 : constraints.maxWidth;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildRecommendationCard(
                    width: width,
                    badge: "CRITICAL PRIORITY",
                    badgeColor: const Color(0xFFE11D48),
                    badgeBg: const Color(0xFFFFE4E6),
                    title: "Curricular Deficit in Machine Learning",
                    desc:
                        "Cohort readiness in Machine Learning (AL3451) is currently 60%, trailing the standard target of 75%. Remediate through structured lab assignments.",
                    footer: "Assessed across 2 enrolled students in Theory",
                  ),
                  _buildRecommendationCard(
                    width: width,
                    badge: "ACTIONABLE PLAN",
                    badgeColor: const Color(0xFF0284C7),
                    badgeBg: const Color(0xFFE0F2FE),
                    title: "No Course Certificates Issued Yet",
                    desc:
                        "Students have not yet passed final proctored assessments. Publishing quizzes in AI Quiz Builder will enable verifiable digital credentials.",
                    footer: "0 issued certificates in store",
                  ),
                  _buildRecommendationCard(
                    width: width,
                    badge: "ACTIONABLE PLAN",
                    badgeColor: const Color(0xFF0284C7),
                    badgeBg: const Color(0xFFE0F2FE),
                    title: "Placement Readiness Gateway Summary",
                    desc:
                        "21% of the cohort qualifies for placement drives (Overall score ≥ 70, Quiz avg ≥ 60%, Mock interview ≥ 50).",
                    footer:
                        "Aggregated from 14 active student records on the readiness board",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard({
    required double width,
    required String badge,
    required Color badgeColor,
    required Color badgeBg,
    required String title,
    required String desc,
    required String footer,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              badge,
              style: GoogleFonts.poppins(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: badgeColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            footer,
            style: GoogleFonts.poppins(
              fontSize: 9.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // Skill Intelligence Matrix (Image 2)
  Widget _buildSkillMatrixTable() {
    final matrixData = [
      {
        "course": "Database Management Systems (CS3492)",
        "dept":
            "Theory · Computer Science & Engineering Graduate, Core Technical Associate",
        "target": "75%",
        "targetVal": 0.75,
        "mastery": "68%",
        "masteryVal": 0.68,
        "gap": "-7%",
        "status": "Moderate",
        "evaluated": "2",
      },
      {
        "course": "Operating Systems (CS3451)",
        "dept":
            "Theory · Computer Science & Engineering Graduate, Core Technical Associate",
        "target": "75%",
        "targetVal": 0.75,
        "mastery": "68%",
        "masteryVal": 0.68,
        "gap": "-7%",
        "status": "Moderate",
        "evaluated": "2",
      },
      {
        "course": "Computer Networks (CS3591)",
        "dept":
            "Theory · Computer Science & Engineering Graduate, Core Technical Associate",
        "target": "75%",
        "targetVal": 0.75,
        "mastery": "68%",
        "masteryVal": 0.68,
        "gap": "-7%",
        "status": "Moderate",
        "evaluated": "2",
      },
      {
        "course": "Machine Learning (AL3451)",
        "dept":
            "Theory · AI & Data Science Graduate, Machine Learning Engineer",
        "target": "75%",
        "targetVal": 0.75,
        "mastery": "60%",
        "masteryVal": 0.60,
        "gap": "-15%",
        "status": "Critical",
        "evaluated": "2",
      },
      {
        "course": "Theory of Machines (ME3391)",
        "dept":
            "Theory · Mechanical Engineering Graduate, Core Design Specialist",
        "target": "75%",
        "targetVal": 0.75,
        "mastery": "56%",
        "masteryVal": 0.56,
        "gap": "-19%",
        "status": "Critical",
        "evaluated": "2",
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
                        "Skill Intelligence Matrix",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Comparing hiring demand score against evaluated cohort readiness score",
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
                  "Showing 6 skills",
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
              constraints: const BoxConstraints(minWidth: 950),
              child: DataTable(
                columnSpacing: 18,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 64,
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                columns: const [
                  DataColumn(label: Text("COURSE / CURRICULAR COMPETENCY")),
                  DataColumn(label: Text("SYLLABUS TARGET")),
                  DataColumn(label: Text("COHORT MASTERY")),
                  DataColumn(label: Text("DEFICIT / GAP")),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("STUDENTS EVALUATED")),
                  DataColumn(label: Text("ACTION")),
                ],
                rows: matrixData.map((row) {
                  final status = row["status"] as String;
                  final isCrit = status == "Critical";

                  return DataRow(
                    cells: [
                      // Course name + dept
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              row["course"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              row["dept"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Target
                      DataCell(
                        Row(
                          children: [
                            Text("${row["target"]}",
                                style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 36,
                              child: LinearProgressIndicator(
                                value: row["targetVal"] as double,
                                backgroundColor: const Color(0xFFF1F5F9),
                                valueColor: const AlwaysStoppedAnimation(
                                    Color(0xFF131B4D)),
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Mastery
                      DataCell(
                        Row(
                          children: [
                            Text("${row["mastery"]}",
                                style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 36,
                              child: LinearProgressIndicator(
                                value: row["masteryVal"] as double,
                                backgroundColor: const Color(0xFFF1F5F9),
                                valueColor: const AlwaysStoppedAnimation(
                                    Color(0xFF131B4D)),
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Gap
                      DataCell(
                        Text(
                          row["gap"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isCrit
                                ? const Color(0xFFE11D48)
                                : const Color(0xFF0D9488),
                          ),
                        ),
                      ),
                      // Status
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isCrit
                                ? const Color(0xFFFFE4E6)
                                : const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            status,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: isCrit
                                  ? const Color(0xFFE11D48)
                                  : const Color(0xFFD97706),
                            ),
                          ),
                        ),
                      ),
                      // Evaluated
                      DataCell(
                        Text(
                          row["evaluated"] as String,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: const Color(0xFF64748B)),
                        ),
                      ),
                      // Action
                      DataCell(
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          child: Text(
                            "Plan Bridge",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
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
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 1: Student Skill Inventory (Image 3)
  // ===========================================================================
  Widget _buildTab1StudentInventory() {
    final rosterData = [
      {
        "name": "Kavya Menon",
        "roll": "110121006",
        "dept": "Computer Science & Engineering",
        "readiness": 55,
        "skills": [
          "Database Management Systems",
          "Operating Systems",
          "Computer Networks"
        ],
        "gaps": [
          "Raise your quiz average to 60%",
          "Earn 1 more certificate(s)",
          "Reach a total of 70"
        ],
        "certs": "1",
      },
      {
        "name": "Sanjay Pillai",
        "roll": "110121007",
        "dept": "Information Technology",
        "readiness": 81,
        "skills": [
          "Analytical Problem Solving",
          "Technical Communication",
          "Core Subject Fundamentals"
        ],
        "gaps": ["All criteria met"],
        "certs": "3",
      },
      {
        "name": "Nandini Krishnan",
        "roll": "110121014",
        "dept": "Artificial Intelligence & Data Science",
        "readiness": 75,
        "skills": ["Machine Learning"],
        "gaps": ["All criteria met"],
        "certs": "4",
      },
      {
        "name": "Aravind Raj",
        "roll": "110121021",
        "dept": "Electronics & Communication",
        "readiness": 52,
        "skills": ["Embedded C", "Digital Electronics"],
        "gaps": [
          "Raise your quiz average to 60%",
          "Earn 2 more certificate(s)"
        ],
        "certs": "1",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progression Chart Card
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
              Text(
                "Cohort Progression & Placement Qualification Rate",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 140,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("80",
                            style: GoogleFonts.poppins(
                                fontSize: 9, color: const Color(0xFF94A3B8))),
                        Text("60",
                            style: GoogleFonts.poppins(
                                fontSize: 9, color: const Color(0xFF94A3B8))),
                        Text("40",
                            style: GoogleFonts.poppins(
                                fontSize: 9, color: const Color(0xFF94A3B8))),
                        Text("20",
                            style: GoogleFonts.poppins(
                                fontSize: 9, color: const Color(0xFF94A3B8))),
                        Text("0",
                            style: GoogleFonts.poppins(
                                fontSize: 9, color: const Color(0xFF94A3B8))),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 24,
                              height: (65 / 100) * 120,
                              decoration: const BoxDecoration(
                                color: Color(0xFF131B4D),
                                borderRadius:
                                    BorderRadius.vertical(top: Radius.circular(3)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 24,
                              height: (21 / 100) * 120,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD4AF37),
                                borderRadius:
                                    BorderRadius.vertical(top: Radius.circular(3)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  "Final Year",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
              const SizedBox(height: 8),
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
                  Text("Cohort Score",
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
                  Text("Qualifying %",
                      style: GoogleFonts.poppins(
                          fontSize: 10, color: const Color(0xFF475569))),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Roster Table Card
        Container(
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
                            "Student Skill Mastery Roster",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Verified skill profiles, assessments completed and placement readiness status",
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
                      "Showing 14 students",
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
                  constraints: const BoxConstraints(minWidth: 1050),
                  child: DataTable(
                    columnSpacing: 18,
                    horizontalMargin: 16,
                    headingRowHeight: 44,
                    dataRowMinHeight: 64,
                    dataRowMaxHeight: 72,
                    headingTextStyle: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                    columns: const [
                      DataColumn(label: Text("STUDENT NAME")),
                      DataColumn(label: Text("ROLL NO")),
                      DataColumn(label: Text("DEPARTMENT")),
                      DataColumn(label: Text("OVERALL READINESS")),
                      DataColumn(label: Text("TOP SKILLS")),
                      DataColumn(label: Text("GAPS TO CLOSE")),
                      DataColumn(label: Text("CERTS")),
                      DataColumn(label: Text("PROFILE")),
                    ],
                    rows: rosterData.map((s) {
                      final readiness = s["readiness"] as int;
                      final isHigh = readiness >= 70;
                      final skills = s["skills"] as List<String>;
                      final gaps = s["gaps"] as List<String>;

                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              s["name"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              s["roll"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              s["dept"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                Text(
                                  "$readiness",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                SizedBox(
                                  width: 44,
                                  child: LinearProgressIndicator(
                                    value: readiness / 100,
                                    backgroundColor: const Color(0xFFF1F5F9),
                                    valueColor: AlwaysStoppedAnimation(isHigh
                                        ? const Color(0xFF0D9488)
                                        : const Color(0xFF131B4D)),
                                    minHeight: 5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: skills
                                  .map(
                                    (sk) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFCCFBF1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        sk,
                                        style: GoogleFonts.poppins(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0D9488),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          DataCell(
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: gaps.map((g) {
                                final isMet = g == "All criteria met";
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isMet
                                        ? const Color(0xFFDCFCE7)
                                        : const Color(0xFFFFE4E6),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    g,
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                      color: isMet
                                          ? const Color(0xFF16A34A)
                                          : const Color(0xFFE11D48),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          DataCell(
                            Text(
                              s["certs"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          DataCell(
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              child: Text(
                                "Inspect",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
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
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // TAB 2: Recruiter Benchmarks & Trends (Image 4)
  // ===========================================================================
  Widget _buildTab2RecruiterBenchmarks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top 2 cards: Verified Certificates by Course & Institutional Readiness
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: _buildCertificatesByCourseCard()),
                  const SizedBox(width: 16),
                  Expanded(flex: 6, child: _buildReadinessCriteriaCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildCertificatesByCourseCard(),
                const SizedBox(height: 16),
                _buildReadinessCriteriaCard(),
              ],
            );
          },
        ),
        const SizedBox(height: 20),

        // Placement Gateway Thresholds & Cohort Compliance Table
        _buildPlacementThresholdsTable(),
      ],
    );
  }

  Widget _buildCertificatesByCourseCard() {
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
            "Verified Certificates by Course",
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F172A),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "No Certificates Issued Yet",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildReadinessCriteriaCard() {
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
            children: [
              const Icon(Icons.track_changes_rounded,
                  size: 16, color: Color(0xFF1E2865)),
              const SizedBox(width: 8),
              Text(
                "Institutional Readiness Criteria Breakdown",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            "Real evaluation metrics for Anna Institute of Technology measured against the standard placement threshold (Overall ≥ 70).",
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          // Tier 1
          _buildTierRow(
            title: "Placement Ready Cohort",
            sub: "Total ≥ 70, Quiz Avg ≥ 60%, Certs ≥ 2, Interview ≥ 50",
            count: "3",
            countLabel: "Students Qualified",
            bg: const Color(0xFFF0FDF4),
          ),
          const SizedBox(height: 8),

          // Tier 2
          _buildTierRow(
            title: "Almost Ready (Near Threshold)",
            sub: "Total score between 55 and 69",
            count: "8",
            countLabel: "In Active Remediation",
            bg: const Color(0xFFFFFBEB),
          ),
          const SizedBox(height: 8),

          // Tier 3
          _buildTierRow(
            title: "Needs Curricular Action",
            sub: "Total score < 55 or missing multiple assessments",
            count: "3",
            countLabel: "Intervention Needed",
            bg: const Color(0xFFFFF1F2),
          ),
          const SizedBox(height: 12),

          Text(
            "Placement formula: Quiz marks 35% + Certificates 20% + Aptitude 15% + Mock interview 15% + Resume 15%.",
            style: GoogleFonts.poppins(
              fontSize: 9.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierRow({
    required String title,
    required String sub,
    required String count,
    required String countLabel,
    required Color bg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                Text(
                  sub,
                  style: GoogleFonts.poppins(
                    fontSize: 9.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                count,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Text(
                countLabel,
                style: GoogleFonts.poppins(
                  fontSize: 8.5,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlacementThresholdsTable() {
    final thresholds = [
      {
        "dim": "Overall Placement Eligibility Gateway",
        "target": "Total Score ≥ 70 / 100",
        "standard": "70 score cutoff",
        "pop": "14 students",
        "compliance": "3 Qualified (21%)",
      },
      {
        "dim": "Academic & Quiz Mastery Standard",
        "target": "Quiz Average ≥ 60%",
        "standard": "60 score cutoff",
        "pop": "14 students",
        "compliance": "Cohort Avg: 63%",
      },
      {
        "dim": "Technical Mock Interview Clearance",
        "target": "Interview Score ≥ 50",
        "standard": "50 score cutoff",
        "pop": "14 students",
        "compliance": "Cohort Avg: 60%",
      },
      {
        "dim": "ATS Resume Standard",
        "target": "Resume ATS Score ≥ 70",
        "standard": "70 score cutoff",
        "pop": "14 students",
        "compliance": "Cohort Avg: 78%",
      },
      {
        "dim": "Aptitude & Logical Assessment",
        "target": "Aptitude Score ≥ 50",
        "standard": "50 score cutoff",
        "pop": "14 students",
        "compliance": "Cohort Avg: 67%",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Placement Gateway Thresholds & Cohort Compliance",
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Official criteria enforced across students for campus recruitment readiness",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 900),
              child: DataTable(
                columnSpacing: 18,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 48,
                dataRowMaxHeight: 56,
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                columns: const [
                  DataColumn(label: Text("EVALUATION GATE / DIMENSION")),
                  DataColumn(label: Text("TARGET REQUIREMENT")),
                  DataColumn(label: Text("MINIMUM SCORE STANDARD")),
                  DataColumn(label: Text("EVALUATED POPULATION")),
                  DataColumn(label: Text("COHORT COMPLIANCE")),
                ],
                rows: thresholds.map((t) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          t["dim"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          t["target"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          t["standard"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          t["pop"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCCFBF1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            t["compliance"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0D9488),
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
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 3: Bridge Courses (Image 5)
  // ===========================================================================
  Widget _buildTab3BridgeCourses() {
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
                  "Active Skill Remediation & Bridge Tracks",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Faculty-led sprints, bootcamps and micro-credentials closing measured deficits",
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
                "New Bridge Course",
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
                  Icons.school_outlined,
                  size: 24,
                  color: Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "No Bridge Courses Scheduled Yet",
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
                  "No active or upcoming curricular interventions have been scheduled yet for All Departments. Assign a teaching faculty member to lead a focused sprint to close identified deficits.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_rounded, size: 15, color: Colors.white),
                label: Text(
                  "Schedule First Bridge Course",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF283685),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
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
// GRID & RADAR PAINTERS
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

class _RadarPlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 6);
    const double radius = 52.0;

    // Web lines
    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final axisPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1;

    // 3 Concentric rings
    for (int r = 1; r <= 3; r++) {
      canvas.drawCircle(center, (radius / 3) * r, gridPaint);
    }

    // Axes
    const int sides = 3;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final labels = ["Theory", "Lab", "Theory + Lab"];

    for (int i = 0; i < sides; i++) {
      final x = center.dx + radius * 0.95 * (i == 0 ? 0 : (i == 1 ? 0.866 : -0.866));
      final y = center.dy + radius * 0.95 * (i == 0 ? -1 : 0.5);
      canvas.drawLine(Offset(center.dx, center.dy), Offset(x, y), axisPaint);

      // Draw label
      final labelX = center.dx + (radius + 14) * (i == 0 ? 0 : (i == 1 ? 0.866 : -0.866));
      final labelY = center.dy + (radius + 14) * (i == 0 ? -1 : 0.5);
      textPainter.text = TextSpan(
        text: labels[i],
        style: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF64748B),
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(labelX - textPainter.width / 2, labelY - textPainter.height / 2),
      );
    }

    // Shaded competency area
    final fillPaint = Paint()
      ..color = const Color(0xFF1E2865).withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFF1E2865)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    final p1 = Offset(center.dx, center.dy - radius * 0.78);
    final p2 = Offset(center.dx + radius * 0.55 * 0.866, center.dy + radius * 0.55 * 0.5);
    final p3 = Offset(center.dx - radius * 0.68 * 0.866, center.dy + radius * 0.68 * 0.5);

    path.moveTo(p1.dx, p1.dy);
    path.lineTo(p2.dx, p2.dy);
    path.lineTo(p3.dx, p3.dy);
    path.close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);

    // Points
    final dotPaint = Paint()..color = const Color(0xFF1E2865);
    canvas.drawCircle(p1, 3, dotPaint);
    canvas.drawCircle(p2, 3, dotPaint);
    canvas.drawCircle(p3, 3, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

