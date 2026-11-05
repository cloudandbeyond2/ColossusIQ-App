import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalAnalyticsBiScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalAnalyticsBiScreen({super.key, this.onBack});

  @override
  State<PrincipalAnalyticsBiScreen> createState() =>
      _PrincipalAnalyticsBiScreenState();
}

class _PrincipalAnalyticsBiScreenState
    extends State<PrincipalAnalyticsBiScreen> {
  int _selectedTab = 0; // 0: Executive Overview, 1: Admissions Funnel, 2: Curriculum, 3: Faculty, 4: Department League
  String _selectedDept = "All Departments (8)";
  String _selectedAy = "AY 2026–27";
  String _deptSearchQuery = "";

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
                // 1. TOP BLUEPRINT HERO BANNER
                _buildHeroBanner(),
                const SizedBox(height: 18),

                // 2. INSTITUTIONAL COMMAND HEADER CARD
                _buildCommandHeaderCard(constraints.maxWidth),
                const SizedBox(height: 20),

                // 3. NAVIGATION SUB-TABS
                _buildSubTabs(),
                const SizedBox(height: 20),

                // 4. ACTIVE TAB CONTENT
                switch (_selectedTab) {
                  1 => _buildAdmissionsFunnelTab(constraints.maxWidth),
                  2 => _buildCurriculumTab(constraints.maxWidth),
                  3 => _buildFacultyTab(constraints.maxWidth),
                  4 => _buildDepartmentLeagueTab(constraints.maxWidth),
                  _ => _buildExecutiveOverviewTab(constraints.maxWidth),
                },
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. TOP BLUEPRINT HERO BANNER
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
                opacity: 0.08,
                child: const Icon(
                  Icons.insights_rounded,
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
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
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
                          "Institution",
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
                          "Analytics & BI",
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

                  // Header Row with Icon, Badges, Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFF26336A).withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.insights_rounded,
                            size: 28,
                            color: Color(0xFFFBBF24), // Amber gold icon
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E293B)
                                        .withValues(alpha: 0.65),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    "INSTITUTION",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Phase 3",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Analytics & BI",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Academic, employability, engagement and faculty KPIs.",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
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
  // 2. INSTITUTIONAL COMMAND HEADER CARD
  // ===========================================================================
  Widget _buildCommandHeaderCard(double maxWidth) {
    final isDesktop = maxWidth >= 960;

    final healthBadge = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 64,
          height: 64,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(64, 64),
                painter: _HealthGaugePainter(score: 60),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "60",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                      height: 1.1,
                    ),
                  ),
                  Text(
                    "HEALTH",
                    style: GoogleFonts.poppins(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    final institutionDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "Anna Institute of Technology",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "1101",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "Engineering Stream",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ),
            Text(
              "📍 Chennai",
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          "Comprehensive Higher Education Business Intelligence · Principal Command View",
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 12,
          runSpacing: 4,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 11.5, color: const Color(0xFF475569)),
                children: const [
                  TextSpan(text: "Intake capacity: "),
                  TextSpan(
                      text: "6,600",
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const Text("•", style: TextStyle(color: Color(0xFFCBD5E1))),
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 11.5, color: const Color(0xFF475569)),
                children: const [
                  TextSpan(text: "Approved intake utilization: "),
                  TextSpan(
                      text: "49%",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFD97706))),
                ],
              ),
            ),
            const Text("•", style: TextStyle(color: Color(0xFFCBD5E1))),
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 11.5, color: const Color(0xFF475569)),
                children: const [
                  TextSpan(text: "Staff roster: "),
                  TextSpan(
                      text: "4",
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
      ],
    );

    final controls = Wrap(
      spacing: 10,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // All Departments dropdown
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedDept,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 16, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1E293B),
              ),
              items: const [
                DropdownMenuItem(
                    value: "All Departments (8)",
                    child: Text("All Departments (8)")),
                DropdownMenuItem(
                    value: "Computer Science", child: Text("Computer Science")),
                DropdownMenuItem(
                    value: "Information Tech", child: Text("Information Tech")),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _selectedDept = val);
              },
            ),
          ),
        ),

        // AY 2026-27 dropdown
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedAy,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 16, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1E293B),
              ),
              items: const [
                DropdownMenuItem(
                    value: "AY 2026–27", child: Text("AY 2026–27")),
                DropdownMenuItem(
                    value: "AY 2025–26", child: Text("AY 2025–26")),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _selectedAy = val);
              },
            ),
          ),
        ),

        // Refresh Button
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Refreshing Institutional BI Datasets..."),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.refresh_rounded, size: 18),
          tooltip: "Refresh",
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFFE2E8F0)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Export Report Button
        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Exporting comprehensive BI dossier (PDF/Excel)..."),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.download_rounded, size: 15),
          label: Text(
            "Export Report",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF283685),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: isDesktop
          ? Row(
              children: [
                healthBadge,
                const SizedBox(width: 18),
                Expanded(child: institutionDetails),
                const SizedBox(width: 16),
                controls,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    healthBadge,
                    const SizedBox(width: 14),
                    Expanded(child: institutionDetails),
                  ],
                ),
                const SizedBox(height: 16),
                controls,
              ],
            ),
    );
  }

  // ===========================================================================
  // 3. NAVIGATION SUB-TABS
  // ===========================================================================
  Widget _buildSubTabs() {
    final tabs = [
      {"icon": Icons.explore_outlined, "title": "Executive Overview"},
      {"icon": Icons.people_outline_rounded, "title": "Admissions Funnel", "badge": "8"},
      {"icon": Icons.menu_book_outlined, "title": "Curriculum & Academics", "badge": "6"},
      {"icon": Icons.badge_outlined, "title": "Faculty & Workforce", "badge": "3"},
      {"icon": Icons.domain_outlined, "title": "Department League", "badge": "8"},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final t = tabs[index];
          final isSelected = _selectedTab == index;

          return Padding(
            padding: const EdgeInsets.only(right: 18),
            child: InkWell(
              onTap: () {
                setState(() => _selectedTab = index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? const Color(0xFF1E1B4B)
                          : Colors.transparent,
                      width: 2.2,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      t["icon"] as IconData,
                      size: 16,
                      color: isSelected
                          ? const Color(0xFF1E1B4B)
                          : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t["title"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF1E1B4B)
                            : const Color(0xFF64748B),
                      ),
                    ),
                    if (t["badge"] != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFEEF2FF)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          t["badge"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? const Color(0xFF4338CA)
                                : const Color(0xFF64748B),
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
  // TAB 1: EXECUTIVE OVERVIEW (Images 1 & 2)
  // ===========================================================================
  Widget _buildExecutiveOverviewTab(double maxWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 4 KPI Metric Cards
        _buildOverviewKpis(maxWidth),
        const SizedBox(height: 20),

        // 2 Progress / Capacity Cards
        _buildCapacityAndWorkloadCards(maxWidth),
        const SizedBox(height: 20),

        // 2 Charts: Weekly Engagement & Curriculum Delivery Modes
        _buildOverviewCharts(maxWidth),
        const SizedBox(height: 20),

        // Automated Institutional Intelligence & Early Warnings Card
        _buildEarlyWarningsCard(),
      ],
    );
  }

  Widget _buildOverviewKpis(double maxWidth) {
    int crossAxisCount = 4;
    if (maxWidth < 650) {
      crossAxisCount = 1;
    } else if (maxWidth < 1050) {
      crossAxisCount = 2;
    }

    final cardWidth =
        (maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        // Card 1
        _buildOverviewKpiCard(
          width: cardWidth,
          title: "ENROLLED STUDENTS",
          primaryValue: "3,258",
          tagText: "49% of capacity (6,600)",
          subtitle: "Active learners across all departments",
        ),
        // Card 2
        _buildOverviewKpiCard(
          width: cardWidth,
          title: "TEACHING FACULTY",
          primaryValue: "3",
          tagText: "1086:1 student ratio",
          subtitle: "4 total staff members",
        ),
        // Card 3
        _buildOverviewKpiCard(
          width: cardWidth,
          title: "ACTIVE CURRICULUM",
          primaryValue: "5 courses",
          tagText: "All courses active",
          isTagBlue: true,
          subtitle: "6 total registered courses",
        ),
        // Card 4
        _buildOverviewKpiCard(
          width: cardWidth,
          title: "ADMISSIONS PIPELINE",
          primaryValue: "8",
          tagText: "13% enrolled (1)",
          subtitle: "1 currently shortlisted",
        ),
      ],
    );
  }

  Widget _buildOverviewKpiCard({
    required double width,
    required String title,
    required String primaryValue,
    required String tagText,
    bool isTagBlue = false,
    required String subtitle,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                primaryValue,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                decoration: BoxDecoration(
                  color: isTagBlue
                      ? const Color(0xFFEFF6FF)
                      : const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tagText,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: isTagBlue
                        ? const Color(0xFF2563EB)
                        : const Color(0xFFB45309),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCapacityAndWorkloadCards(double maxWidth) {
    final isDesktop = maxWidth >= 860;

    final card1 = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                  "Student Capacity & Intake Utilization",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "49% utilized",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFB45309),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Enrolled active learners vs total approved seats",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.49,
              minHeight: 8,
              backgroundColor: Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB45309)),
            ),
          ),
          const SizedBox(height: 16),

          // 3 Sub-boxes
          Row(
            children: [
              _buildMetricSubBox("Approved Seats", "6,600", const Color(0xFF0F172A)),
              const SizedBox(width: 10),
              _buildMetricSubBox("Currently Enrolled", "3,258", const Color(0xFF0D9488)),
              const SizedBox(width: 10),
              _buildMetricSubBox("Vacant / Buffer", "3,342", const Color(0xFF0F172A)),
            ],
          ),
        ],
      ),
    );

    final card2 = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                  "Faculty Workload & Staffing Ratio",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "1086:1 Ratio",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFB45309),
                  ),
                ),
              ),
            ],
          ),
          Text(
            "AICTE / UGC ideal standard: ≤ 20:1",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          // Status & Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Statutory Regulatory Compliance",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                "Review Needed ( > 20:1)",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFB45309),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.05,
              minHeight: 8,
              backgroundColor: Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB45309)),
            ),
          ),
          const SizedBox(height: 16),

          // 3 Sub-boxes
          Row(
            children: [
              _buildMetricSubBox("Teaching Faculty", "3", const Color(0xFF0D9488)),
              const SizedBox(width: 10),
              _buildMetricSubBox("Admin / Support", "1", const Color(0xFF0F172A)),
              const SizedBox(width: 10),
              _buildMetricSubBox("Total Staff", "4", const Color(0xFF0F172A)),
            ],
          ),
        ],
      ),
    );

    if (isDesktop) {
      return Row(
        children: [
          Expanded(child: card1),
          const SizedBox(width: 20),
          Expanded(child: card2),
        ],
      );
    }
    return Column(
      children: [
        card1,
        const SizedBox(height: 16),
        card2,
      ],
    );
  }

  Widget _buildMetricSubBox(String title, String val, Color valColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                color: const Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              val,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: valColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCharts(double maxWidth) {
    final isDesktop = maxWidth >= 860;

    final engagementChart = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly academic engagement",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: CustomPaint(
              painter: _WeeklyEngagementChartPainter(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendDot(const Color(0xFF1E293B), "Students"),
              const SizedBox(width: 16),
              _buildLegendDot(const Color(0xFFD97706), "Faculty"),
            ],
          ),
        ],
      ),
    );

    final deliveryModeChart = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Curriculum delivery modes",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: CustomPaint(
              painter: _CurriculumDonutChartPainter(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendDot(const Color(0xFF1E293B), "Theory"),
              const SizedBox(width: 16),
              _buildLegendDot(const Color(0xFFD97706), "Theory + Lab"),
            ],
          ),
        ],
      ),
    );

    if (isDesktop) {
      return Row(
        children: [
          Expanded(child: engagementChart),
          const SizedBox(width: 20),
          Expanded(child: deliveryModeChart),
        ],
      );
    }
    return Column(
      children: [
        engagementChart,
        const SizedBox(height: 16),
        deliveryModeChart,
      ],
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF475569),
          ),
        ),
      ],
    );
  }

  Widget _buildEarlyWarningsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Icon(Icons.auto_awesome_rounded,
                      size: 16, color: Color(0xFF4F46E5)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Automated Institutional Intelligence & Early Warnings",
                  style: GoogleFonts.poppins(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 900;

              final warning1 = _buildEarlyWarningItem(
                badgeLabel: "Attention",
                badgeBg: const Color(0xFFFFFBEB),
                badgeColor: const Color(0xFFB45309),
                title: "Enrollment capacity buffer",
                desc:
                    "Current intake is at 49% of capacity. There are 3,342 seats open for subsequent rounds.",
                sub: "Admissions register · 3258 students / 6600 seats",
              );

              final warning2 = _buildEarlyWarningItem(
                badgeLabel: "Attention",
                badgeBg: const Color(0xFFFFFBEB),
                badgeColor: const Color(0xFFB45309),
                title: "Faculty workload attention",
                desc:
                    "The student-to-faculty ratio is 1086:1. Additional faculty recruitment is recommended to maintain accreditation standards.",
                sub: "Staff roster & enrollment · 3 faculty",
              );

              final warning3 = _buildEarlyWarningItem(
                badgeLabel: "Healthy",
                badgeBg: const Color(0xFFDCFCE7),
                badgeColor: const Color(0xFF16A34A),
                title: "Curriculum catalog fully active",
                desc:
                    "All 6 course records are active and mapped to department curricula.",
                sub: "Course management · 5 active / 6 total",
              );

              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: warning1),
                    const SizedBox(width: 14),
                    Expanded(child: warning2),
                    const SizedBox(width: 14),
                    Expanded(child: warning3),
                  ],
                );
              }

              return Column(
                children: [
                  warning1,
                  const SizedBox(height: 12),
                  warning2,
                  const SizedBox(height: 12),
                  warning3,
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEarlyWarningItem({
    required String badgeLabel,
    required Color badgeBg,
    required Color badgeColor,
    required String title,
    required String desc,
    required String sub,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
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
              badgeLabel,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: badgeColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF475569),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 8),
          Text(
            sub,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 2: ADMISSIONS FUNNEL (Image 3)
  // ===========================================================================
  Widget _buildAdmissionsFunnelTab(double maxWidth) {
    int crossAxisCount = 4;
    if (maxWidth < 650) {
      crossAxisCount = 1;
    } else if (maxWidth < 1050) {
      crossAxisCount = 2;
    }

    final cardWidth =
        (maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 4 KPI Cards
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildFunnelKpi(cardWidth, "Total Pipeline", "8", "Received across all departments"),
            _buildFunnelKpi(cardWidth, "Shortlisted for Offer", "1", "Eligibility and criteria verified"),
            _buildFunnelKpi(cardWidth, "Enrolled Admissions", "1", "Fees paid & matriculated"),
            _buildFunnelKpi(cardWidth, "Conversion Rate", "13%", "Applications to final enrollment"),
          ],
        ),
        const SizedBox(height: 20),

        // 2 Visualizations: Admissions Stage Progression & Bar chart
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 860;

            final progressionCard = Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Admissions Stage Progression",
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildProgressionRow("1. Enquiry", "0 applicants (0%)", 0.0, const Color(0xFFCBD5E1)),
                  _buildProgressionRow("2. Applied", "0 applicants (0%)", 0.0, const Color(0xFFCBD5E1)),
                  _buildProgressionRow("3. Documents verified", "3 applicants (38%)", 0.38, const Color(0xFF1E293B)),
                  _buildProgressionRow("4. Shortlisted", "1 applicants (13%)", 0.13, const Color(0xFF1E293B)),
                  _buildProgressionRow("5. Fee paid", "0 applicants (0%)", 0.0, const Color(0xFFCBD5E1)),
                  _buildProgressionRow("6. Enrolled", "1 applicants (13%)", 0.13, const Color(0xFF0D9488)),
                ],
              ),
            );

            final conversionBarCard = Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Admissions conversion funnel",
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 230,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: _ConversionFunnelBarChartPainter(),
                    ),
                  ),
                ],
              ),
            );

            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: progressionCard),
                  const SizedBox(width: 20),
                  Expanded(child: conversionBarCard),
                ],
              );
            }
            return Column(
              children: [
                progressionCard,
                const SizedBox(height: 16),
                conversionBarCard,
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildFunnelKpi(double width, String title, String val, String sub) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B))),
          const SizedBox(height: 6),
          Text(val,
              style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A))),
          const SizedBox(height: 4),
          Text(sub,
              style: GoogleFonts.poppins(
                  fontSize: 11, color: const Color(0xFF94A3B8))),
        ],
      ),
    );
  }

  Widget _buildProgressionRow(String stage, String stat, double fraction, Color barColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(stage,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B))),
              Text(stat,
                  style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B))),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 6,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAB 3: CURRICULUM & ACADEMICS (Image 4)
  // ===========================================================================
  Widget _buildCurriculumTab(double maxWidth) {
    int crossAxisCount = 3;
    if (maxWidth < 650) {
      crossAxisCount = 1;
    } else if (maxWidth < 950) {
      crossAxisCount = 2;
    }

    final cardWidth =
        (maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 3 KPI Cards
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildFunnelKpi(cardWidth, "Total Registered Courses", "6", "Across 8 departments"),
            _buildFunnelKpi(cardWidth, "Active Curricula", "5", "83% active coverage"),
            _buildFunnelKpi(cardWidth, "Draft / In Preparation", "1", "Pending departmental sign-off"),
          ],
        ),
        const SizedBox(height: 20),

        // Delivery Mode Donut & Breakdown Cards
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 860;

            final donutCard = Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Curriculum delivery modes",
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: _CurriculumDonutChartPainter(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendDot(const Color(0xFF1E293B), "Theory"),
                      const SizedBox(width: 16),
                      _buildLegendDot(const Color(0xFFD97706), "Theory + Lab"),
                    ],
                  ),
                ],
              ),
            );

            final breakdownCard = Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pedagogical Delivery Breakdown",
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Theory",
                                  style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      color: const Color(0xFF64748B))),
                              const SizedBox(height: 4),
                              Text("5",
                                  style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A))),
                              const SizedBox(height: 2),
                              Text("83% of total courses",
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: const Color(0xFF94A3B8))),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Theory + Lab",
                                  style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      color: const Color(0xFF64748B))),
                              const SizedBox(height: 4),
                              Text("1",
                                  style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A))),
                              const SizedBox(height: 2),
                              Text("17% of total courses",
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: const Color(0xFF94A3B8))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );

            if (isDesktop) {
              return Row(
                children: [
                  Expanded(child: donutCard),
                  const SizedBox(width: 20),
                  Expanded(child: breakdownCard),
                ],
              );
            }
            return Column(
              children: [
                donutCard,
                const SizedBox(height: 16),
                breakdownCard,
              ],
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // TAB 4: FACULTY & WORKFORCE (Image 5)
  // ===========================================================================
  Widget _buildFacultyTab(double maxWidth) {
    int crossAxisCount = 3;
    if (maxWidth < 650) {
      crossAxisCount = 1;
    } else if (maxWidth < 950) {
      crossAxisCount = 2;
    }

    final cardWidth =
        (maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 3 KPI Cards
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildFunnelKpi(cardWidth, "Total Teaching Faculty", "3", "Permanent & contractual instructional staff"),
            _buildFunnelKpi(cardWidth, "Support & Administrative", "1", "Non-instructional & lab personnel"),
            _buildFunnelKpi(cardWidth, "Teaching Ratio", "1086:1", "Students per faculty member"),
          ],
        ),
        const SizedBox(height: 20),

        // Academic Hierarchy & Department Capacity
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 860;

            final hierarchyCard = Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Academic Hierarchy & Designations",
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Associate Professor",
                          style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E293B))),
                      Text("3 faculty (100%)",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0D9488))),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: const LinearProgressIndicator(
                      value: 1.0,
                      minHeight: 8,
                      backgroundColor: Color(0xFFF1F5F9),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF0D9488)),
                    ),
                  ),
                ],
              ),
            );

            final capacityCard = Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Department capacity & staffing",
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: _DepartmentStaffingBarChartPainter(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendDot(const Color(0xFF1E293B), "Courses"),
                      const SizedBox(width: 16),
                      _buildLegendDot(const Color(0xFFD97706), "Faculty"),
                    ],
                  ),
                ],
              ),
            );

            if (isDesktop) {
              return Row(
                children: [
                  Expanded(child: hierarchyCard),
                  const SizedBox(width: 20),
                  Expanded(child: capacityCard),
                ],
              );
            }
            return Column(
              children: [
                hierarchyCard,
                const SizedBox(height: 16),
                capacityCard,
              ],
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // TAB 5: DEPARTMENT LEAGUE (8)
  // ===========================================================================
  Widget _buildDepartmentLeagueTab(double maxWidth) {
    final allLeagueData = [
      {
        "dept": "Computer Science & Engineering",
        "students": 530,
        "courses": 3,
        "faculty": 1,
        "ratio": "530:1",
        "ratioType": "warning",
        "applications": 0,
      },
      {
        "dept": "Information Technology",
        "students": 442,
        "courses": 0,
        "faculty": 0,
        "ratio": "–",
        "ratioType": "empty",
        "applications": 0,
      },
      {
        "dept": "Artificial Intelligence & Data Science",
        "students": 253,
        "courses": 1,
        "faculty": 0,
        "ratio": "–",
        "ratioType": "empty",
        "applications": 0,
      },
      {
        "dept": "Electronics & Communication",
        "students": 335,
        "courses": 1,
        "faculty": 1,
        "ratio": "335:1",
        "ratioType": "warning",
        "applications": 0,
      },
      {
        "dept": "Electrical & Electronics",
        "students": 465,
        "courses": 0,
        "faculty": 0,
        "ratio": "–",
        "ratioType": "empty",
        "applications": 0,
      },
      {
        "dept": "Mechanical Engineering",
        "students": 360,
        "courses": 1,
        "faculty": 0,
        "ratio": "–",
        "ratioType": "empty",
        "applications": 0,
      },
      {
        "dept": "Civil Engineering",
        "students": 346,
        "courses": 0,
        "faculty": 0,
        "ratio": "–",
        "ratioType": "empty",
        "applications": 0,
      },
      {
        "dept": "Science & Humanities",
        "students": 527,
        "courses": 0,
        "faculty": 1,
        "ratio": "527:1",
        "ratioType": "warning",
        "applications": 0,
      },
    ];

    final filteredData = allLeagueData.where((d) {
      if (_deptSearchQuery.isEmpty) return true;
      return (d["dept"] as String)
          .toLowerCase()
          .contains(_deptSearchQuery.toLowerCase());
    }).toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Title + Subtitle on Left, Search Department on Right
          Padding(
            padding: const EdgeInsets.all(22),
            child: LayoutBuilder(
              builder: (context, box) {
                final isNarrow = box.maxWidth < 650;
                final headerText = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Departmental Performance League",
                      style: GoogleFonts.poppins(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Comparative operational metrics across academic departments",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );

                final searchBox = Container(
                  width: isNarrow ? double.infinity : 220,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextField(
                    onChanged: (val) {
                      setState(() => _deptSearchQuery = val);
                    },
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF1E293B),
                    ),
                    decoration: InputDecoration(
                      hintText: "Search department...",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                    ),
                  ),
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerText,
                      const SizedBox(height: 14),
                      searchBox,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: headerText),
                    const SizedBox(width: 16),
                    searchBox,
                  ],
                );
              },
            ),
          ),

          // Horizontal scrollable table matching Image 1
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: maxWidth < 900 ? 900 : maxWidth - 68,
              ),
              child: Column(
                children: [
                  // Table Header Row
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                    color: const Color(0xFFF6F5EE),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "DEPARTMENT",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF64748B),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "STUDENTS",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF64748B),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "COURSES",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF64748B),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "FACULTY",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF64748B),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "RATIO",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF64748B),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "APPLICATIONS",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF64748B),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Data rows
                  ...filteredData.map((d) {
                    final ratio = d["ratio"] as String;
                    final ratioType = d["ratioType"] as String;

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF1F5F9),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Department name
                          Expanded(
                            flex: 5,
                            child: Text(
                              d["dept"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          // Students (bold)
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "${d["students"]}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                          ),
                          // Courses
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "${d["courses"]}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ),
                          // Faculty
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "${d["faculty"]}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  color: (d["faculty"] as int) > 0
                                      ? const Color(0xFF0F172A)
                                      : const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ),
                          // Ratio Pill
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: ratioType == "warning"
                                      ? const Color(0xFFFFFBEB)
                                      : const Color(0xFFCCFBF1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: ratioType == "warning"
                                        ? const Color(0xFFFDE68A)
                                        : const Color(0xFF99F6E4),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  ratio,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: ratioType == "warning"
                                        ? const Color(0xFFB45309)
                                        : const Color(0xFF0F766E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Applications
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${d["applications"]}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// =============================================================================
// HEALTH CIRCLE GAUGE PAINTER
// =============================================================================
class _HealthGaugePainter extends CustomPainter {
  final int score;
  _HealthGaugePainter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    final bgPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    final progressPaint = Paint()
      ..color = const Color(0xFF991B1B) // Crimson arc
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final sweepAngle = (score / 100.0) * 2 * 3.14159;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// WEEKLY ENGAGEMENT LINE CHART PAINTER
// =============================================================================
class _WeeklyEngagementChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    const leftPad = 36.0;
    const bottomPad = 26.0;
    final chartW = w - leftPad - 10;
    final chartH = h - bottomPad - 10;

    // Draw horizontal grid lines (0, 750, 1500, 2250, 3000)
    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    final textStyle = GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8));

    final steps = [0, 750, 1500, 2250, 3000];
    for (int i = 0; i < steps.length; i++) {
      final y = chartH - (i / (steps.length - 1)) * chartH + 10;
      canvas.drawLine(Offset(leftPad, y), Offset(w - 10, y), gridPaint);

      final textSpan = TextSpan(text: "${steps[i]}", style: textStyle);
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    // X labels (W1 - W6)
    final weeks = ["W1", "W2", "W3", "W4", "W5", "W6"];
    for (int i = 0; i < weeks.length; i++) {
      final x = leftPad + (i / (weeks.length - 1)) * chartW;
      final textSpan = TextSpan(text: weeks[i], style: textStyle);
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, h - 18));
    }

    // Student line (ascending from ~2300 to 3000)
    final studentData = [2300.0, 2450.0, 2600.0, 2750.0, 2880.0, 3000.0];
    final studentPoints = <Offset>[];
    for (int i = 0; i < studentData.length; i++) {
      final x = leftPad + (i / (weeks.length - 1)) * chartW;
      final y = chartH - (studentData[i] / 3000.0) * chartH + 10;
      studentPoints.add(Offset(x, y));
    }

    // Fill under student curve
    final fillPath = Path()..moveTo(studentPoints.first.dx, chartH + 10);
    for (final pt in studentPoints) {
      fillPath.lineTo(pt.dx, pt.dy);
    }
    fillPath.lineTo(studentPoints.last.dx, chartH + 10);
    fillPath.close();

    final fillPaint = Paint()
      ..color = const Color(0xFF1E293B).withValues(alpha: 0.08);
    canvas.drawPath(fillPath, fillPaint);

    // Stroke student line
    final studentPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;

    final linePath = Path()..moveTo(studentPoints.first.dx, studentPoints.first.dy);
    for (int i = 1; i < studentPoints.length; i++) {
      linePath.lineTo(studentPoints[i].dx, studentPoints[i].dy);
    }
    canvas.drawPath(linePath, studentPaint);

    // Faculty line (flat near bottom ~100)
    final facultyPaint = Paint()
      ..color = const Color(0xFFD97706)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final facY = chartH - (100.0 / 3000.0) * chartH + 10;
    canvas.drawLine(Offset(leftPad, facY), Offset(w - 10, facY), facultyPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// CURRICULUM DONUT CHART PAINTER
// =============================================================================
class _CurriculumDonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.height / 2) - 10;

    final theoryPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24.0;

    final labPaint = Paint()
      ..color = const Color(0xFFD97706)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24.0;

    const totalAngle = 2 * 3.14159;
    const theoryAngle = 0.83 * totalAngle;
    const labAngle = 0.17 * totalAngle;

    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(rect, -3.14159 / 2, theoryAngle, false, theoryPaint);
    canvas.drawArc(rect, -3.14159 / 2 + theoryAngle, labAngle, false, labPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// CONVERSION FUNNEL BAR CHART PAINTER
// =============================================================================
class _ConversionFunnelBarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    const leftPad = 26.0;
    const bottomPad = 30.0;
    final chartW = w - leftPad - 10;
    final chartH = h - bottomPad - 10;

    // Horizontal grid lines (0, 0.75, 1.5, 2.25, 3)
    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;
    final textStyle = GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8));

    final steps = ["0", "0.75", "1.5", "2.25", "3"];
    for (int i = 0; i < steps.length; i++) {
      final y = chartH - (i / (steps.length - 1)) * chartH + 10;
      canvas.drawLine(Offset(leftPad, y), Offset(w - 10, y), gridPaint);
      final tp = TextPainter(text: TextSpan(text: steps[i], style: textStyle), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    // Categories
    final stages = [
      {"name": "Enquiry", "val": 0.0},
      {"name": "Applied", "val": 0.0},
      {"name": "Documents verified", "val": 3.0},
      {"name": "Shortlisted", "val": 1.0},
      {"name": "Fee paid", "val": 0.0},
      {"name": "Enrolled", "val": 1.0},
    ];

    final colWidth = chartW / stages.length;
    final barW = (colWidth * 0.45).clamp(16.0, 36.0);

    for (int i = 0; i < stages.length; i++) {
      final s = stages[i];
      final val = s["val"] as double;
      final x = leftPad + i * colWidth + (colWidth - barW) / 2;

      if (val > 0) {
        final barH = (val / 3.0) * chartH;
        final barY = chartH - barH + 10;
        final rrect = RRect.fromRectAndCorners(
          Rect.fromLTWH(x, barY, barW, barH),
          topLeft: const Radius.circular(4),
          topRight: const Radius.circular(4),
        );
        canvas.drawRRect(rrect, Paint()..color = const Color(0xFF1E293B));
      }

      // X Label
      final tp = TextPainter(
        text: TextSpan(
          text: s["name"] as String,
          style: GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF64748B)),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(leftPad + i * colWidth + (colWidth - tp.width) / 2, h - 20));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// DEPARTMENT STAFFING BAR CHART PAINTER
// =============================================================================
class _DepartmentStaffingBarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    const leftPad = 26.0;
    const bottomPad = 26.0;
    final chartW = w - leftPad - 10;
    final chartH = h - bottomPad - 10;

    // Y Axis (0, 0.75, 1.5, 2.25, 3)
    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;
    final textStyle = GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8));

    final steps = ["0", "0.75", "1.5", "2.25", "3"];
    for (int i = 0; i < steps.length; i++) {
      final y = chartH - (i / (steps.length - 1)) * chartH + 10;
      canvas.drawLine(Offset(leftPad, y), Offset(w - 10, y), gridPaint);
      final tp = TextPainter(text: TextSpan(text: steps[i], style: textStyle), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    final depts = [
      {"name": "Information Tech..", "courses": 3.0, "faculty": 1.0},
      {"name": "Electronics & Co..", "courses": 1.0, "faculty": 1.0},
      {"name": "Mechanical Engin..", "courses": 1.0, "faculty": 0.0},
    ];

    final colWidth = chartW / depts.length;
    const barW = 18.0;

    for (int i = 0; i < depts.length; i++) {
      final d = depts[i];
      final coursesVal = d["courses"] as double;
      final facultyVal = d["faculty"] as double;
      final groupCenterX = leftPad + i * colWidth + colWidth / 2;

      // Courses Bar (Navy)
      if (coursesVal > 0) {
        final barH = (coursesVal / 3.0) * chartH;
        final rrect = RRect.fromRectAndCorners(
          Rect.fromLTWH(groupCenterX - barW - 2, chartH - barH + 10, barW, barH),
          topLeft: const Radius.circular(3),
          topRight: const Radius.circular(3),
        );
        canvas.drawRRect(rrect, Paint()..color = const Color(0xFF1E293B));
      }

      // Faculty Bar (Gold)
      if (facultyVal > 0) {
        final barH = (facultyVal / 3.0) * chartH;
        final rrect = RRect.fromRectAndCorners(
          Rect.fromLTWH(groupCenterX + 2, chartH - barH + 10, barW, barH),
          topLeft: const Radius.circular(3),
          topRight: const Radius.circular(3),
        );
        canvas.drawRRect(rrect, Paint()..color = const Color(0xFFD97706));
      }

      // X Label
      final tp = TextPainter(
        text: TextSpan(
          text: d["name"] as String,
          style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B)),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(groupCenterX - tp.width / 2, h - 18));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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

    const spacing = 28.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
