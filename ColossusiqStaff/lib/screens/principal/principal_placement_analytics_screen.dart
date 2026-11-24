import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalPlacementAnalyticsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalPlacementAnalyticsScreen({super.key, this.onBack});

  @override
  State<PrincipalPlacementAnalyticsScreen> createState() =>
      _PrincipalPlacementAnalyticsScreenState();
}

class _PrincipalPlacementAnalyticsScreenState
    extends State<PrincipalPlacementAnalyticsScreen> {
  int _activeTab = 0;
  bool _showRelatedWorkflows = true;
  String _selectedScope = "All Departments (Institutional)";
  String _selectedDriveTier = "All Tiers";
  String _selectedDirectoryStatus = "All Statuses";
  final TextEditingController _candidateSearchCtrl = TextEditingController();

  // Institutional Placement Targets
  double _targetPlacementPct = 92.0;
  String _targetAvgPackage = "10.5";
  String _targetMockInterview = "95";
  String _targetRecruitingPartners = "60";

  final TextEditingController _deptSearchController = TextEditingController();

  final List<String> _departmentsScope = [
    "All Departments (Institutional)",
    "Computer Science & Engineering",
    "Information Technology",
    "Artificial Intelligence & Data Science",
    "Biomedical Engineering",
    "Electrical & Electronics Engineering",
    "Mechanical Engineering",
    "Electronics & Communication",
  ];

  final List<Map<String, dynamic>> _deptLeagueData = [
    {
      "name": "Computer Science & Engineering",
      "code": "CSE",
      "totalEligible": "146 / 138",
      "placed": 128,
      "pct": "92.8%",
      "pctVal": 0.928,
      "avgCtc": "₹12.4 LPA",
      "highestCtc": "₹44 LPA",
      "readiness": "89/100",
      "readinessColor": Color(0xFF0D9488),
      "partner": "Google Apex Engineering",
    },
    {
      "name": "Artificial Intelligence & Data Science",
      "code": "AIDS",
      "totalEligible": "68 / 65",
      "placed": 61,
      "pct": "93.8%",
      "pctVal": 0.938,
      "avgCtc": "₹11.8 LPA",
      "highestCtc": "₹36.5 LPA",
      "readiness": "91/100",
      "readinessColor": Color(0xFF0D9488),
      "partner": "Microsoft Cloud & AI",
    },
    {
      "name": "Information Technology",
      "code": "IT",
      "totalEligible": "113 / 108",
      "placed": 98,
      "pct": "90.7%",
      "pctVal": 0.907,
      "avgCtc": "₹10.2 LPA",
      "highestCtc": "₹28 LPA",
      "readiness": "88/100",
      "readinessColor": Color(0xFF0284C7),
      "partner": "Amazon AWS Autumn",
    },
    {
      "name": "Biomedical Engineering",
      "code": "BME",
      "totalEligible": "54 / 50",
      "placed": 43,
      "pct": "86%",
      "pctVal": 0.86,
      "avgCtc": "₹8.6 LPA",
      "highestCtc": "₹18.5 LPA",
      "readiness": "86/100",
      "readinessColor": Color(0xFF0284C7),
      "partner": "MediTech Diagnostics",
    },
    {
      "name": "Electrical & Electronics Engineering",
      "code": "EEE",
      "totalEligible": "72 / 68",
      "placed": 52,
      "pct": "76.5%",
      "pctVal": 0.765,
      "avgCtc": "₹7.8 LPA",
      "highestCtc": "₹16 LPA",
      "readiness": "78/100",
      "readinessColor": Color(0xFFD97706),
      "partner": "Larsen & Toubro Core",
    },
    {
      "name": "Mechanical Engineering",
      "code": "MECH",
      "totalEligible": "64 / 53",
      "placed": 30,
      "pct": "56.6%",
      "pctVal": 0.566,
      "avgCtc": "₹6.4 LPA",
      "highestCtc": "₹12 LPA",
      "readiness": "71/100",
      "readinessColor": Color(0xFFD97706),
      "partner": "Tata Motors Automotive",
    },
    {
      "name": "Electronics & Communication",
      "code": "E&C",
      "totalEligible": "60 / 55",
      "placed": 48,
      "pct": "87.3%",
      "pctVal": 0.873,
      "avgCtc": "₹8.5 LPA",
      "highestCtc": "₹18 LPA",
      "readiness": "82/100",
      "readinessColor": Color(0xFF0284C7),
      "partner": "Tata Consultancy Services (TCS)",
    },
    {
      "name": "Electrical & Electronics",
      "code": "E&E",
      "totalEligible": "60 / 55",
      "placed": 48,
      "pct": "87.3%",
      "pctVal": 0.873,
      "avgCtc": "₹8.5 LPA",
      "highestCtc": "₹18 LPA",
      "readiness": "82/100",
      "readinessColor": Color(0xFF0284C7),
      "partner": "Tata Consultancy Services (TCS)",
    },
    {
      "name": "Civil Engineering",
      "code": "CE",
      "totalEligible": "60 / 55",
      "placed": 48,
      "pct": "87.3%",
      "pctVal": 0.873,
      "avgCtc": "₹8.5 LPA",
      "highestCtc": "₹18 LPA",
      "readiness": "82/100",
      "readinessColor": Color(0xFF0284C7),
      "partner": "Tata Consultancy Services (TCS)",
    },
    {
      "name": "Science & Humanities",
      "code": "S&H",
      "totalEligible": "60 / 55",
      "placed": 48,
      "pct": "87.3%",
      "pctVal": 0.873,
      "avgCtc": "₹8.5 LPA",
      "highestCtc": "₹18 LPA",
      "readiness": "82/100",
      "readinessColor": Color(0xFF0284C7),
      "partner": "Tata Consultancy Services (TCS)",
    },
  ];

  @override
  void dispose() {
    _deptSearchController.dispose();
    _candidateSearchCtrl.dispose();
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
                // 1. Hero Blueprint Banner (Image 2)
                _buildHeroBanner(),
                const SizedBox(height: 16),

                // 2. Header & Action Row (Image 2)
                _buildHeaderActionRow(),
                const SizedBox(height: 14),

                // 3. Related Portals & Workflows (Toggleable, Image 2)
                if (_showRelatedWorkflows) ...[
                  _buildRelatedWorkflowsCard(),
                  const SizedBox(height: 16),
                ],

                // 4. Department Scope Filter (Image 2)
                _buildScopeFilter(),
                const SizedBox(height: 14),

                // 5. College Placement Goal Card (Image 2)
                _buildCollegePlacementGoalCard(),
                const SizedBox(height: 14),

                // 6. 6 Quick Metric KPI Cards (Image 2)
                _buildQuickKpiCards(constraints.maxWidth),
                const SizedBox(height: 20),

                // 7. SubTabs Navigation (Image 4 & 5)
                _buildSubTabs(),
                const SizedBox(height: 18),

                // 8. Tab Content
                if (_activeTab == 0) _buildTab0ExecutiveOverview(),
                if (_activeTab == 1) _buildTab1DepartmentLeague(),
                if (_activeTab == 2) _buildTab2RecruiterDriveAnalytics(),
                if (_activeTab == 3) _buildTab3ReadinessSkillGaps(),
                if (_activeTab == 4) _buildTab4PlacedStudentDirectory(),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER (Image 2)
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
                  Icons.bar_chart_rounded,
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
                          "Placement Analytics",
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

                  // Badges: PLACEMENT, Phase 2
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

                  // Title & Subtitle
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
                            Icons.bar_chart_rounded,
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
                              "Placement Analytics",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Readiness, resume completion, mock-interview participation and offers.",
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
  // 2. HEADER & ACTION ROW (Image 2)
  // ===========================================================================
  Widget _buildHeaderActionRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 1050;

        final titleBlock = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Placement Analytics & Industry Outcomes",
              softWrap: true,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "AY 2026-27 (Graduating Cohort)",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4F46E5),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Institutional Leadership",
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Anna Institute of Technology Chennai · Placement conversion, package tiers, hiring funnels, and department benchmarks.",
              softWrap: true,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: const Color(0xFF64748B),
              ),
            ),
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
                  label: Text("Refresh",
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
                  label: Text("Export Report (CSV)",
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
                ElevatedButton.icon(
                  onPressed: () => _showSetTargetsModal(),
                  icon: const Icon(Icons.track_changes_rounded,
                      size: 15, color: Colors.white),
                  label: Text(
                    "Set Targets",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E2865),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () =>
                  setState(() => _showRelatedWorkflows = !_showRelatedWorkflows),
              icon: Icon(
                _showRelatedWorkflows
                    ? Icons.link_off_rounded
                    : Icons.link_rounded,
                size: 13,
                color: const Color(0xFF64748B),
              ),
              label: Text(
                _showRelatedWorkflows
                    ? "Hide Related Workflows"
                    : "Show Related Workflows",
                style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B)),
              ),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
            ),
          ],
        );

        if (isSmall) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleBlock,
              const SizedBox(height: 12),
              actionButtons,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: titleBlock),
            const SizedBox(width: 14),
            actionButtons,
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 3. RELATED WORKFLOWS CARD (Image 2)
  // ===========================================================================
  Widget _buildRelatedWorkflowsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 6,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2865),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.explore_rounded,
                        size: 13, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Related Portals & Action Workflows Across Roles",
                    softWrap: true,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Text(
                "Deep linked to student preparation, drives, and recruiter shortlists",
                softWrap: true,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 4 Action Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 950;
              final cardW = isWide
                  ? (constraints.maxWidth - (3 * 10)) / 4
                  : (constraints.maxWidth >= 550
                      ? (constraints.maxWidth - 10) / 2
                      : constraints.maxWidth);

              final workflows = [
                {
                  "icon": Icons.track_changes_rounded,
                  "iconColor": Color(0xFF0D9488),
                  "title": "Department Skills ↗",
                  "desc": "Launch targeted bridge courses to fix System Design & DSA gaps.",
                },
                {
                  "icon": Icons.people_outline_rounded,
                  "iconColor": Color(0xFF4F46E5),
                  "title": "Placement Readiness Board ↗",
                  "desc": "Filter students by verified readiness and shortlist for upcoming drives.",
                },
                {
                  "icon": Icons.search_rounded,
                  "iconColor": Color(0xFFD97706),
                  "title": "Recruiter Talent Search ↗",
                  "desc": "View how external recruiters discover and shortlist candidate profiles.",
                },
                {
                  "icon": Icons.calendar_today_outlined,
                  "iconColor": Color(0xFF0284C7),
                  "title": "Placement Drives ↗",
                  "desc": "Schedule campus drives, criteria rules, and registration windows.",
                },
              ];

              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: workflows.map((w) {
                  return Container(
                    width: cardW,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(w["icon"] as IconData,
                                size: 16, color: w["iconColor"] as Color),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                w["title"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          w["desc"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: const Color(0xFF64748B),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 12),

          // Additional Linked Pages
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              Text(
                "Additional Linked Pages: ",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
              _buildLinkedPageItem("Curriculum Studio (Electives)"),
              const Text("·", style: TextStyle(color: Color(0xFF94A3B8))),
              _buildLinkedPageItem("Early Warning Alerts"),
              const Text("·", style: TextStyle(color: Color(0xFF94A3B8))),
              _buildLinkedPageItem("Institutional BI"),
              const Text("·", style: TextStyle(color: Color(0xFF94A3B8))),
              _buildLinkedPageItem("AICTE Compliance"),
              const Text("·", style: TextStyle(color: Color(0xFF94A3B8))),
              _buildLinkedPageItem("Recruiter Panels"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedPageItem(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 10.5,
        color: const Color(0xFF475569),
        decoration: TextDecoration.underline,
      ),
    );
  }

  // ===========================================================================
  // 4. SCOPE FILTER (Image 2)
  // ===========================================================================
  Widget _buildScopeFilter() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 550;
        if (isSmall) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DEPARTMENT SCOPE: ",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 38,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedScope,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        size: 16, color: Color(0xFF64748B)),
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: const Color(0xFF0F172A)),
                    items: _departmentsScope
                        .map((it) => DropdownMenuItem(
                            value: it,
                            child: Text(it, overflow: TextOverflow.ellipsis)))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedScope = v!),
                  ),
                ),
              ),
            ],
          );
        }

        return Row(
          children: [
            Text(
              "DEPARTMENT SCOPE: ",
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedScope,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      size: 16, color: Color(0xFF64748B)),
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: const Color(0xFF0F172A)),
                  items: _departmentsScope
                      .map((it) => DropdownMenuItem(value: it, child: Text(it)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedScope = v!),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 5. COLLEGE PLACEMENT GOAL CARD (Image 2)
  // ===========================================================================
  Widget _buildCollegePlacementGoalCard() {
    return Container(
      width: double.infinity,
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
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 800;

              final goalTitle = Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "COLLEGE PLACEMENT GOAL",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "6.0% to Target (${_targetPlacementPct.toInt()}%)",
                      style: GoogleFonts.poppins(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFD97706),
                      ),
                    ),
                  ),
                ],
              );

              final metaRow = Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildTargetMetaCol("Placement Target", "${_targetPlacementPct.toInt()}%"),
                  _buildTargetMetaCol("Avg CTC Target", "₹$_targetAvgPackage LPA"),
                  _buildTargetMetaCol("Mock Interview Goal", "$_targetMockInterview%"),
                ],
              );

              if (isSmall) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    goalTitle,
                    const SizedBox(height: 12),
                    metaRow,
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  goalTitle,
                  metaRow,
                ],
              );
            },
          ),
          const SizedBox(height: 12),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "86%",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                TextSpan(
                  text: " of eligible students placed (604 of 702)",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 10,
              child: LinearProgressIndicator(
                value: 0.86,
                backgroundColor: const Color(0xFFFAF7F2),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF1E2865)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetMetaCol(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 9.5,
            color: const Color(0xFF94A3B8),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 6. 6 QUICK METRIC KPI CARDS (Image 2)
  // ===========================================================================
  Widget _buildQuickKpiCards(double maxWidth) {
    double cardWidth;
    if (maxWidth >= 1200) {
      cardWidth = (maxWidth - (5 * 10)) / 6;
    } else if (maxWidth >= 850) {
      cardWidth = (maxWidth - (2 * 10)) / 3;
    } else if (maxWidth >= 540) {
      cardWidth = (maxWidth - 10) / 2;
    } else {
      cardWidth = maxWidth;
    }

    final kpis = [
      {
        "title": "Total Offers",
        "value": "538",
        "sub": "+81 multi-offers",
        "subColor": Color(0xFF0D9488),
      },
      {
        "title": "Highest CTC",
        "value": "₹44 LPA",
        "sub": "Google Apex Eng.",
        "subColor": Color(0xFF64748B),
      },
      {
        "title": "Average CTC",
        "value": "₹9.8 LPA",
        "sub": "Median: ₹8.2 LPA",
        "subColor": Color(0xFF64748B),
      },
      {
        "title": "Super Dream (>15 LPA)",
        "value": "76",
        "sub": "14.1% of all offers",
        "subColor": Color(0xFF64748B),
      },
      {
        "title": "Dream (10-15 LPA)",
        "value": "152",
        "sub": "28.2% of all offers",
        "subColor": Color(0xFF64748B),
      },
      {
        "title": "Seeking Placement",
        "value": "7",
        "sub": "Review students ↗",
        "subColor": Color(0xFFE11D48),
        "isValRed": true,
      },
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: kpis.map((k) {
        final isRed = k["isValRed"] as bool? ?? false;
        return Container(
          width: cardWidth,
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
                k["title"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                k["value"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: isRed
                      ? const Color(0xFFDC2626)
                      : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                k["sub"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                  color: k["subColor"] as Color,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ===========================================================================
  // 7. SUBTABS (Image 4 & 5)
  // ===========================================================================
  Widget _buildSubTabs() {
    final tabs = [
      "Executive Overview",
      "Department League (10)",
      "Recruiter & Drive Analytics (7)",
      "Readiness & Skill Gaps (5)",
      "Placed Student Directory (16)",
    ];

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final isSelected = _activeTab == index;
            return Padding(
              padding: const EdgeInsets.only(right: 28),
              child: InkWell(
                onTap: () => setState(() => _activeTab = index),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
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
                  child: Text(
                    tabs[index],
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF1E2865)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ===========================================================================
  // TAB 0: Executive Overview (Image 4)
  // ===========================================================================
  Widget _buildTab0ExecutiveOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Salary CTC Tier Distribution Card
        Container(
          width: double.infinity,
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
                builder: (context, constraints) {
                  final isSmall = constraints.maxWidth < 650;
                  final titleCol = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Salary CTC Tier Distribution",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Breakdown of released offers across compensation tiers",
                        softWrap: true,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  );

                  final totalOffers = Text(
                    "Total: 538 Offers",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  );

                  if (isSmall) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleCol,
                        const SizedBox(height: 6),
                        totalOffers,
                      ],
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: titleCol),
                      const SizedBox(width: 8),
                      totalOffers,
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),

              // Segmented Stacked Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 12,
                  child: Row(
                    children: [
                      Expanded(flex: 14, child: Container(color: const Color(0xFF0D9488))),
                      Expanded(flex: 28, child: Container(color: const Color(0xFF1E2865))),
                      Expanded(flex: 38, child: Container(color: const Color(0xFFD97706))),
                      Expanded(flex: 20, child: Container(color: const Color(0xFFCBD5E1))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 4 Tier Columns
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 750;
                  final isMedium = constraints.maxWidth >= 450;
                  final colW = isWide
                      ? (constraints.maxWidth - (3 * 10)) / 4
                      : (isMedium
                          ? (constraints.maxWidth - 10) / 2
                          : constraints.maxWidth);

                  final tiers = [
                    {
                      "label": "Super Dream (> ₹15 LPA)",
                      "dotColor": Color(0xFF0D9488),
                      "count": "76",
                      "pct": "14.1%",
                    },
                    {
                      "label": "Dream (₹10 – ₹15 LPA)",
                      "dotColor": Color(0xFF1E2865),
                      "count": "152",
                      "pct": "28.3%",
                    },
                    {
                      "label": "Core Engineering (₹6 – ₹10 LPA)",
                      "dotColor": Color(0xFFD97706),
                      "count": "204",
                      "pct": "37.9%",
                    },
                    {
                      "label": "Regular & IT Services (₹3.5 – ₹6 LPA)",
                      "dotColor": Color(0xFFCBD5E1),
                      "count": "106",
                      "pct": "19.7%",
                    },
                  ];

                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: tiers.map((t) {
                      return SizedBox(
                        width: colW,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: t["dotColor"] as Color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    t["label"] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      color: const Color(0xFF475569),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  t["count"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  t["pct"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 2. Row of 2 Cards: Funnel & Marquee Drives
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildRecruitmentFunnelCard()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildMarqueeDrivesCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildRecruitmentFunnelCard(),
                const SizedBox(height: 16),
                _buildMarqueeDrivesCard(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecruitmentFunnelCard() {
    final stages = [
      {"num": "1", "name": "Registered for Drives", "stat": "702 (100%)", "val": 1.0},
      {"num": "2", "name": "Online Assessment Shortlisted", "stat": "576 (82%)", "val": 0.82},
      {"num": "3", "name": "Technical Panel Cleared", "stat": "421 (60%)", "val": 0.60},
      {"num": "4", "name": "HR & Leadership Round", "stat": "351 (50%)", "val": 0.50},
      {"num": "5", "name": "Final Offer Released", "stat": "604 (86%)", "val": 0.86},
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
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Text(
                "Manage Drives ↗",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E2865),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            "Student progression from registration through final offer",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          ...stages.map((st) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              st["num"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            st["name"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        st["stat"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: st["val"] as double,
                      backgroundColor: const Color(0xFFFAF7F2),
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF131B4D)),
                      minHeight: 6,
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

  Widget _buildMarqueeDrivesCard() {
    final drives = [
      {
        "name": "Tata Consultancy Services (TCS)",
        "pill": "Core",
        "pillColor": Color(0xFFEEF2FF),
        "pillFg": Color(0xFF4F46E5),
        "sub": "Digital Innovator & Prime Engineer · IT Consulting",
        "package": "₹9.5 LPA",
        "offers": "28 offers",
      },
      {
        "name": "Zoho Corporation",
        "pill": "Core",
        "pillColor": Color(0xFFEEF2FF),
        "pillFg": Color(0xFF4F46E5),
        "sub": "Software Engineer - Technology / Enterprise",
        "package": "₹9 LPA",
        "offers": "18 offers",
      },
      {
        "name": "Amazon AWS",
        "pill": "Super Dream",
        "pillColor": Color(0xFFCCFBF1),
        "pillFg": Color(0xFF0D9488),
        "sub": "Associate Cloud Support Engineer · Cloud & Infrastructure",
        "package": "₹18 LPA",
        "offers": "6 offers",
      },
      {
        "name": "Google India",
        "pill": "Super Dream",
        "pillColor": Color(0xFFCCFBF1),
        "pillFg": Color(0xFF0D9488),
        "sub": "Software Development Engineer (SDE-1) · Technology / Enterprise",
        "package": "₹32.5 LPA",
        "offers": "6 offers",
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
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Text(
                "Recruiter Pool ↗",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E2865),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            "Recruiting partners with highest compensation and offer releases",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          ...drives.map((d) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF9F5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFEFE8DD)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              d["name"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                              decoration: BoxDecoration(
                                color: d["pillColor"] as Color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                d["pill"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: d["pillFg"] as Color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          d["sub"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
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
                        d["package"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        d["offers"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0D9488),
                        ),
                      ),
                    ],
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
  // TAB 1: Department League (Image 5)
  // ===========================================================================
  Widget _buildTab1DepartmentLeague() {
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
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmall = constraints.maxWidth < 750;

                final titleBlock = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Department Placement Matrix",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Comparative placement metrics, average packages, and top recruiters across departments",
                      softWrap: true,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );

                final searchAndAction = Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      height: 34,
                      width: isSmall ? constraints.maxWidth : 170,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: TextField(
                        controller: _deptSearchController,
                        style: GoogleFonts.poppins(fontSize: 11),
                        decoration: const InputDecoration(
                          hintText: "Search departments...",
                          hintStyle: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    Text(
                      "Bridge Courses ↗",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E2865),
                      ),
                    ),
                  ],
                );

                if (isSmall) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleBlock,
                      const SizedBox(height: 12),
                      searchAndAction,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: titleBlock),
                    const SizedBox(width: 12),
                    searchAndAction,
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1050),
              child: DataTable(
                columnSpacing: 16,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 64,
                headingRowColor: WidgetStateProperty.all(const Color(0xFFF7F4EE)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                columns: const [
                  DataColumn(label: Text("Department")),
                  DataColumn(label: Text("Total / Eligible")),
                  DataColumn(label: Text("Placed")),
                  DataColumn(label: Text("Placement %")),
                  DataColumn(label: Text("Avg CTC")),
                  DataColumn(label: Text("Highest CTC")),
                  DataColumn(label: Text("Readiness")),
                  DataColumn(label: Text("Top Hiring Partner")),
                  DataColumn(label: Text("Quick Action")),
                ],
                rows: _deptLeagueData.map((d) {
                  return DataRow(
                    cells: [
                      // Department
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              d["name"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              d["code"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Total / Eligible
                      DataCell(
                        Text(
                          d["totalEligible"] as String,
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF475569)),
                        ),
                      ),
                      // Placed
                      DataCell(
                        Text(
                          "${d["placed"]}",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Placement %
                      DataCell(
                        Row(
                          children: [
                            Text(
                              d["pct"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 38,
                              child: LinearProgressIndicator(
                                value: d["pctVal"] as double,
                                backgroundColor: const Color(0xFFF1F5F9),
                                valueColor: const AlwaysStoppedAnimation(Color(0xFF131B4D)),
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Avg CTC
                      DataCell(
                        Text(
                          d["avgCtc"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Highest CTC
                      DataCell(
                        Text(
                          d["highestCtc"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0D9488),
                          ),
                        ),
                      ),
                      // Readiness Pill
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: (d["readinessColor"] as Color).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            d["readiness"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: d["readinessColor"] as Color,
                            ),
                          ),
                        ),
                      ),
                      // Top Hiring Partner
                      DataCell(
                        Text(
                          d["partner"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // Quick Action
                      DataCell(
                        Text(
                          "View Students ↗",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E2865),
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
  // TAB 2: Recruiter & Drive Analytics (Image 1)
  // ===========================================================================
  Widget _buildTab2RecruiterDriveAnalytics() {
    final drivesData = [
      {
        "company": "Tata Consultancy Services\n(TCS)",
        "role": "Digital Innovator & Prime\nEngineer",
        "tier": "Core",
        "sector": "IT Consulting",
        "ctc": "₹9.5\nLPA",
        "registered": "160",
        "shortlisted": "58",
        "offers": "28",
        "conversion": "17.5%",
        "status": "Completed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
      {
        "company": "Zoho Corporation",
        "role": "Software Engineer",
        "tier": "Core",
        "sector": "Technology / Enterprise",
        "ctc": "₹9 LPA",
        "registered": "110",
        "shortlisted": "32",
        "offers": "18",
        "conversion": "16.4%",
        "status": "Completed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
      {
        "company": "Amazon AWS",
        "role": "Associate Cloud Support\nEngineer",
        "tier": "Super Dream",
        "sector": "Cloud &\nInfrastructure",
        "ctc": "₹18 LPA",
        "registered": "54",
        "shortlisted": "16",
        "offers": "6",
        "conversion": "11.1%",
        "status": "Active",
        "statusBg": const Color(0xFFEEF2FF),
        "statusFg": const Color(0xFF4F46E5),
      },
      {
        "company": "Google India",
        "role": "Software Development Engineer\n(SDE-1)",
        "tier": "Super Dream",
        "sector": "Technology /\nEnterprise",
        "ctc": "₹32.5\nLPA",
        "registered": "48",
        "shortlisted": "14",
        "offers": "6",
        "conversion": "12.5%",
        "status": "Active",
        "statusBg": const Color(0xFFEEF2FF),
        "statusFg": const Color(0xFF4F46E5),
      },
      {
        "company": "Microsoft Corporation",
        "role": "Cloud Solution & DevOps\nEngineer",
        "tier": "Super Dream",
        "sector": "Cloud &\nInfrastructure",
        "ctc": "₹26 LPA",
        "registered": "65",
        "shortlisted": "20",
        "offers": "8",
        "conversion": "12.3%",
        "status": "Active",
        "statusBg": const Color(0xFFEEF2FF),
        "statusFg": const Color(0xFF4F46E5),
      },
      {
        "company": "L&T Technology Services",
        "role": "Embedded Systems & IoT\nEngineer",
        "tier": "Core",
        "sector": "Technology / Enterprise",
        "ctc": "₹8 LPA",
        "registered": "195",
        "shortlisted": "36",
        "offers": "14",
        "conversion": "7.2%",
        "status": "Upcoming",
        "statusBg": const Color(0xFFE0F2FE),
        "statusFg": const Color(0xFF0284C7),
      },
      {
        "company": "Google Apex Engineering",
        "role": "Software Development Engineer\n(SDE-1)",
        "tier": "Super Dream",
        "sector": "Technology / Cloud",
        "ctc": "₹44 LPA",
        "registered": "168",
        "shortlisted": "24",
        "offers": "8",
        "conversion": "4.8%",
        "status": "Completed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
    ];

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
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmall = constraints.maxWidth < 750;

                final titleBlock = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Campus Recruitment Drives",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Drive attendance, shortlisting ratio, and final offers",
                      softWrap: true,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );

                final tierAndAction = Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedDriveTier,
                          style: GoogleFonts.poppins(
                              fontSize: 11.5, color: const Color(0xFF0F172A)),
                          items: const [
                            "All Tiers",
                            "Super Dream",
                            "Dream",
                            "Core",
                          ].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                          onChanged: (v) => setState(() => _selectedDriveTier = v!),
                        ),
                      ),
                    ),
                    Text(
                      "Placement Drives Hub ↗",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E2865),
                      ),
                    ),
                  ],
                );

                if (isSmall) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleBlock,
                      const SizedBox(height: 12),
                      tierAndAction,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: titleBlock),
                    const SizedBox(width: 12),
                    tierAndAction,
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1050),
              child: DataTable(
                columnSpacing: 16,
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
                  DataColumn(label: Text("Company")),
                  DataColumn(label: Text("Role")),
                  DataColumn(label: Text("Tier & Sector")),
                  DataColumn(label: Text("CTC")),
                  DataColumn(label: Text("Registered")),
                  DataColumn(label: Text("Shortlisted")),
                  DataColumn(label: Text("Offers")),
                  DataColumn(label: Text("Conversion")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Linked Actions")),
                ],
                rows: drivesData.map((d) {
                  final isSuper = d["tier"] == "Super Dream";
                  final tierBg = isSuper
                      ? const Color(0xFFCCFBF1)
                      : const Color(0xFFFEF3C7);
                  final tierFg = isSuper
                      ? const Color(0xFF0D9488)
                      : const Color(0xFFD97706);

                  return DataRow(
                    cells: [
                      // Company
                      DataCell(
                        Text(
                          d["company"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Role
                      DataCell(
                        Text(
                          d["role"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // Tier & Sector
                      DataCell(
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: tierBg,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                d["tier"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w600,
                                  color: tierFg,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                d["sector"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // CTC
                      DataCell(
                        Text(
                          d["ctc"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Registered
                      DataCell(
                        Text(
                          d["registered"] as String,
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: const Color(0xFF475569)),
                        ),
                      ),
                      // Shortlisted
                      DataCell(
                        Text(
                          d["shortlisted"] as String,
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: const Color(0xFF475569)),
                        ),
                      ),
                      // Offers
                      DataCell(
                        Text(
                          d["offers"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0D9488),
                          ),
                        ),
                      ),
                      // Conversion
                      DataCell(
                        Text(
                          d["conversion"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      // Status
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: d["statusBg"] as Color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            d["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: d["statusFg"] as Color,
                            ),
                          ),
                        ),
                      ),
                      // Linked Actions
                      DataCell(
                        Text(
                          "Shortlist\nStudents ↗",
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E2865),
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
  // TAB 3: Readiness & Skill Gaps (Image 2)
  // ===========================================================================
  Widget _buildTab3ReadinessSkillGaps() {
    final skillGaps = [
      {
        "title": "System Design & Distributed Scalability",
        "badge": "Critical (25%)",
        "badgeBg": const Color(0xFFFFE4E6),
        "badgeFg": const Color(0xFFE11D48),
        "progressVal": 0.25,
        "proficient": "Proficient: 103 students",
        "gaps": "Critical Gaps: 12 students",
        "intervention":
            "Conduct weekend intensive system design workshops covering microservices caching and Kafka event streams.",
      },
      {
        "title": "Data Structures & Algorithmic Complexity",
        "badge": "Attention (10%)",
        "badgeBg": const Color(0xFFFEF3C7),
        "badgeFg": const Color(0xFFD97706),
        "progressVal": 0.10,
        "proficient": "Proficient: 150 students",
        "gaps": "Critical Gaps: 10 students",
        "intervention":
            "Active weekly leetcode-style timed contests on ColossusIQ Mock Tests arena.",
      },
      {
        "title": "Technical Mock Interview Communication",
        "badge": "Attention (2%)",
        "badgeBg": const Color(0xFFFEF3C7),
        "badgeFg": const Color(0xFFD97706),
        "progressVal": 0.02,
        "proficient": "Proficient: 120 students",
        "gaps": "Critical Gaps: 15 students",
        "intervention":
            "Mandate 2 AI viva/mock interview practice sessions per student before upcoming Core drives.",
      },
      {
        "title": "Resume ATS Compliance & Proof Points",
        "badge": "Healthy (10%)",
        "badgeBg": const Color(0xFFCCFBF1),
        "badgeFg": const Color(0xFF0D9488),
        "progressVal": 0.10,
        "proficient": "Proficient: 203 students",
        "gaps": "Critical Gaps: 8 students",
        "intervention":
            "10% students have passed resume ATS verification benchmark (70+ score).",
      },
      {
        "title": "Domain & Core Engineering Fundamentals",
        "badge": "Healthy (84%)",
        "badgeBg": const Color(0xFFCCFBF1),
        "badgeFg": const Color(0xFF0D9488),
        "progressVal": 0.84,
        "proficient": "Proficient: 183 students",
        "gaps": "Critical Gaps: 25 students",
        "intervention":
            "Reinforce foundational domain engineering concepts through continuous assessment tests.",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Subtitle line
        LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 750;
            final descText = Text(
              "Identified critical gaps across departments. Click \"Launch Bridge Course\" to push interventions directly into Department Skills.",
              softWrap: true,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: const Color(0xFF64748B),
              ),
            );

            final linkText = Text(
              "Open Department Skills Desk ↗",
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E2865),
              ),
            );

            if (isSmall) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  descText,
                  const SizedBox(height: 6),
                  linkText,
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: descText),
                const SizedBox(width: 12),
                linkText,
              ],
            );
          },
        ),
        const SizedBox(height: 14),

        // 2-Column Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 800;
            final cardWidth = isWide
                ? (constraints.maxWidth - 14) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: 14,
              runSpacing: 14,
              children: skillGaps.map((sg) {
                return Container(
                  width: cardWidth,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              sg["title"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: sg["badgeBg"] as Color,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              sg["badge"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: sg["badgeFg"] as Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: SizedBox(
                          height: 6,
                          child: LinearProgressIndicator(
                            value: sg["progressVal"] as double,
                            backgroundColor: const Color(0xFFFAF7F2),
                            valueColor: const AlwaysStoppedAnimation(
                                Color(0xFF131B4D)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Counts
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sg["proficient"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          Text(
                            sg["gaps"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Intervention Box
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF9F5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFEFE8DD)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recommended Intervention:",
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              sg["intervention"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                color: const Color(0xFF475569),
                                height: 1.35,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "⊕ Launch Bridge Course ↗",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E2865),
                                  ),
                                ),
                                Text(
                                  "Check Early Warning ↗",
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
                    ],
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
  // TAB 4: Placed Student Directory (Image 3)
  // ===========================================================================
  Widget _buildTab4PlacedStudentDirectory() {
    final candidateData = [
      {
        "name": "bala",
        "roll": "27549861",
        "dept": "Computer Science & Engineering",
        "cgpa": "6.8",
        "readiness": "0%",
        "company": "—",
        "role": "In Pipeline",
        "ctc": "—",
        "status": "Seeking Placement",
        "statusBg": const Color(0xFFE0F2FE),
        "statusFg": const Color(0xFF0284C7),
      },
      {
        "name": "Kirshna",
        "roll": "21CS4788",
        "dept": "Computer Science & Engineering",
        "cgpa": "6.8",
        "readiness": "0%",
        "company": "—",
        "role": "In Pipeline",
        "ctc": "—",
        "status": "Seeking Placement",
        "statusBg": const Color(0xFFE0F2FE),
        "statusFg": const Color(0xFF0284C7),
      },
      {
        "name": "Anand Kumar",
        "roll": "110124001",
        "dept": "Computer Science & Engineering",
        "cgpa": "9.03",
        "readiness": "69%",
        "company": "—",
        "role": "In Pipeline",
        "ctc": "—",
        "status": "In Process",
        "statusBg": const Color(0xFFFEF3C7),
        "statusFg": const Color(0xFFD97706),
      },
      {
        "name": "Divya Ramesh",
        "roll": "110124002",
        "dept": "Computer Science & Engineering",
        "cgpa": "9.9",
        "readiness": "40%",
        "company": "—",
        "role": "In Pipeline",
        "ctc": "—",
        "status": "Seeking Placement",
        "statusBg": const Color(0xFFE0F2FE),
        "statusFg": const Color(0xFF0284C7),
      },
      {
        "name": "Karthik Raja",
        "roll": "110124003",
        "dept": "Information Technology",
        "cgpa": "6.8",
        "readiness": "0%",
        "company": "—",
        "role": "In Pipeline",
        "ctc": "—",
        "status": "Seeking Placement",
        "statusBg": const Color(0xFFE0F2FE),
        "statusFg": const Color(0xFF0284C7),
      },
      {
        "name": "Suganya",
        "roll": "52CS1478",
        "dept": "Computer Science & Engineering",
        "cgpa": "6.8",
        "readiness": "0%",
        "company": "—",
        "role": "In Pipeline",
        "ctc": "—",
        "status": "Seeking Placement",
        "statusBg": const Color(0xFFE0F2FE),
        "statusFg": const Color(0xFF0284C7),
      },
      {
        "name": "Suthanisri",
        "roll": "41CS8528",
        "dept": "Computer Science & Engineering",
        "cgpa": "6.8",
        "readiness": "0%",
        "company": "—",
        "role": "In Pipeline",
        "ctc": "—",
        "status": "Seeking Placement",
        "statusBg": const Color(0xFFE0F2FE),
        "statusFg": const Color(0xFF0284C7),
      },
      {
        "name": "Divya Raman",
        "roll": "22BM112",
        "dept": "Biomedical Engineering",
        "cgpa": "9.24",
        "readiness": "94%",
        "isReadinessTeal": true,
        "company": "MediTech Diagnostics &\nRobotics",
        "role": "Biomedical Systems Engineer",
        "ctc": "₹18.5 LPA",
        "isCtcTeal": true,
        "status": "Placed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
      {
        "name": "Karthik Iyer",
        "roll": "22CS184",
        "dept": "Computer Science &\nEngineering",
        "cgpa": "8.86",
        "readiness": "91%",
        "isReadinessTeal": true,
        "company": "Google Apex Engineering",
        "role": "Software Development Engineer\n(SDE-1)",
        "ctc": "₹44 LPA",
        "isCtcTeal": true,
        "status": "Placed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
      {
        "name": "R. Priyadarshini",
        "roll": "21IT089",
        "dept": "Information Technology",
        "cgpa": "9.42",
        "readiness": "96%",
        "isReadinessTeal": true,
        "company": "Amazon AWS Autumn",
        "role": "Cloud Solutions Architect",
        "ctc": "₹28 LPA",
        "isCtcTeal": true,
        "status": "Placed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
      {
        "name": "Siddharth V.",
        "roll": "21CS045",
        "dept": "Computer Science & Engineering",
        "cgpa": "9.1",
        "readiness": "92%",
        "isReadinessTeal": true,
        "company": "Google India",
        "role": "Software Development Engineer (SDE-1)",
        "ctc": "₹32.5 LPA",
        "isCtcTeal": true,
        "status": "Placed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
      {
        "name": "Ananya Sharma",
        "roll": "21IT012",
        "dept": "Information Technology",
        "cgpa": "8.95",
        "readiness": "89%",
        "isReadinessTeal": true,
        "company": "Microsoft Corporation",
        "role": "Cloud Solution & DevOps Engineer",
        "ctc": "₹26 LPA",
        "isCtcTeal": true,
        "status": "Placed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
      {
        "name": "Rahul Nair",
        "roll": "22CS210",
        "dept": "Computer Science & Engineering",
        "cgpa": "8.75",
        "readiness": "88%",
        "isReadinessTeal": true,
        "company": "Amazon AWS",
        "role": "Associate Cloud Support Engineer",
        "ctc": "₹18 LPA",
        "isCtcTeal": true,
        "status": "Placed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
      {
        "name": "Meera Sundaram",
        "roll": "21EC088",
        "dept": "Electronics & Communication",
        "cgpa": "8.6",
        "readiness": "85%",
        "isReadinessTeal": true,
        "company": "L&T Technology Services",
        "role": "Embedded Systems & IoT Engineer",
        "ctc": "₹8 LPA",
        "isCtcTeal": true,
        "status": "Placed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
      {
        "name": "Gautam K.",
        "roll": "21CS115",
        "dept": "Computer Science & Engineering",
        "cgpa": "8.4",
        "readiness": "84%",
        "isReadinessTeal": true,
        "company": "Tata Consultancy Services (TCS)",
        "role": "Digital Innovator & Prime Engineer",
        "ctc": "₹9.5 LPA",
        "isCtcTeal": true,
        "status": "Placed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
      {
        "name": "Pooja Venkat",
        "roll": "21IT077",
        "dept": "Information Technology",
        "cgpa": "8.5",
        "readiness": "86%",
        "isReadinessTeal": true,
        "company": "Zoho Corporation",
        "role": "Software Engineer",
        "ctc": "₹9 LPA",
        "isCtcTeal": true,
        "status": "Placed",
        "statusBg": const Color(0xFFCCFBF1),
        "statusFg": const Color(0xFF0D9488),
      },
    ];

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
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmall = constraints.maxWidth < 850;

                final titleBlock = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Placed & Interviewing Candidate Ledger",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Live record of student placement offers, packages, and recruiter verification",
                      softWrap: true,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                );

                final filtersAndAction = Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedDirectoryStatus,
                          style: GoogleFonts.poppins(
                              fontSize: 11.5, color: const Color(0xFF0F172A)),
                          items: const [
                            "All Statuses",
                            "Placed",
                            "In Process",
                            "Seeking Placement",
                          ].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                          onChanged: (v) =>
                              setState(() => _selectedDirectoryStatus = v!),
                        ),
                      ),
                    ),
                    Container(
                      height: 34,
                      width: isSmall ? constraints.maxWidth : 180,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: TextField(
                        controller: _candidateSearchCtrl,
                        style: GoogleFonts.poppins(fontSize: 11),
                        decoration: const InputDecoration(
                          hintText: "Search candidates, companies...",
                          hintStyle: TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    Text(
                      "Placement Board ↗",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E2865),
                      ),
                    ),
                  ],
                );

                if (isSmall) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleBlock,
                      const SizedBox(height: 12),
                      filtersAndAction,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: titleBlock),
                    const SizedBox(width: 12),
                    filtersAndAction,
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1050),
              child: DataTable(
                columnSpacing: 16,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 64,
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFF7F4EE)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                columns: const [
                  DataColumn(label: Text("Student")),
                  DataColumn(label: Text("Department")),
                  DataColumn(label: Text("CGPA")),
                  DataColumn(label: Text("Readiness")),
                  DataColumn(label: Text("Hired Company")),
                  DataColumn(label: Text("Role Designation")),
                  DataColumn(label: Text("Package (CTC)")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Student Workflows")),
                ],
                rows: candidateData.map((c) {
                  final isReadinessTeal = c["isReadinessTeal"] as bool? ?? false;
                  final isCtcTeal = c["isCtcTeal"] as bool? ?? false;

                  return DataRow(
                    cells: [
                      // Student
                      DataCell(
                        InkWell(
                          onTap: () => _showStudentProfileModal(c),
                          borderRadius: BorderRadius.circular(4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  c["name"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1E2865),
                                    decoration: TextDecoration.underline,
                                    decorationColor: const Color(0xFF94A3B8),
                                  ),
                                ),
                                Text(
                                  c["roll"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 9.5,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Department
                      DataCell(
                        Text(
                          c["dept"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // CGPA
                      DataCell(
                        Text(
                          c["cgpa"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Readiness
                      DataCell(
                        isReadinessTeal
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFCCFBF1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  c["readiness"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0D9488),
                                  ),
                                ),
                              )
                            : Text(
                                c["readiness"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                      ),
                      // Hired Company
                      DataCell(
                        Text(
                          c["company"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: c["company"] != "—"
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Role Designation
                      DataCell(
                        Text(
                          c["role"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      // Package (CTC)
                      DataCell(
                        Text(
                          c["ctc"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight:
                                isCtcTeal ? FontWeight.w800 : FontWeight.normal,
                            color: isCtcTeal
                                ? const Color(0xFF0D9488)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      // Status
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: c["statusBg"] as Color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            c["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: c["statusFg"] as Color,
                            ),
                          ),
                        ),
                      ),
                      // Student Workflows
                      DataCell(
                        InkWell(
                          onTap: () => _showStudentProfileModal(c),
                          child: Text(
                            "Readiness Board ↗",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E2865),
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
  // MODAL: Student Readiness Profile (Matching Reference Images 1 & 3)
  // ===========================================================================
  void _showStudentProfileModal(Map<String, dynamic> student) {
    final name = (student["name"] as String?) ?? "bala";
    final roll = (student["roll"] as String?) ?? "27549861";
    final dept = (student["dept"] as String?) ?? "Computer Science & Engineering";
    final displayRoll = "$roll · ${dept.replaceAll('\n', ' ')} · 2023–2027 (Final Year)";

    final rawReadiness = student["readiness"] ?? "0%";
    final readinessInt = int.tryParse(rawReadiness.toString().replaceAll("%", "").trim()) ?? 0;
    final status = (student["status"] as String?) ?? (readinessInt >= 70 ? "Placement ready" : readinessInt >= 50 ? "Almost ready" : "Needs work");

    final strengths = (student["skills"] as List<String>?) ??
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
                                name,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                displayRoll,
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
                                  color: status == "Placement ready"
                                      ? const Color(0xFFCCFBF1)
                                      : status == "Almost ready"
                                          ? const Color(0xFFFEF3C7)
                                          : const Color(0xFFFFE4E6),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  status,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: status == "Placement ready"
                                        ? const Color(0xFF0D9488)
                                        : status == "Almost ready"
                                            ? const Color(0xFFD97706)
                                            : const Color(0xFFE11D48),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "$readinessInt / 100",
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
                    if (strengths.isNotEmpty) ...[
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
                        children: strengths.map((sk) {
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

  // ===========================================================================
  // MODAL: Set Institutional Placement Targets (Image 3)
  // ===========================================================================
  void _showSetTargetsModal() {
    double tempPct = _targetPlacementPct;
    final avgPkgCtrl = TextEditingController(text: _targetAvgPackage);
    final mockCtrl = TextEditingController(text: _targetMockInterview);
    final partnersCtrl = TextEditingController(text: _targetRecruitingPartners);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Modal Header
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Set Institutional Placement Targets",
                                softWrap: true,
                                style: GoogleFonts.poppins(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
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
                        const SizedBox(height: 16),

                        // Target Placement Percentage Slider
                        Text(
                          "Target Placement Percentage (%)",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: const Color(0xFF0066FF),
                                  inactiveTrackColor: const Color(0xFFE2E8F0),
                                  thumbColor: const Color(0xFF0066FF),
                                  trackHeight: 4,
                                ),
                                child: Slider(
                                  value: tempPct,
                                  min: 50,
                                  max: 100,
                                  onChanged: (v) => setModalState(() => tempPct = v),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${tempPct.toInt()}%",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Target Average Package
                        _buildTargetModalField("Target Average Package (₹ LPA)", avgPkgCtrl),
                        const SizedBox(height: 14),

                        // Mock Interview Completion Target
                        _buildTargetModalField("Mock Interview Completion Target (%)", mockCtrl),
                        const SizedBox(height: 14),

                        // Target Recruiting Partners Count
                        _buildTargetModalField("Target Recruiting Partners Count", partnersCtrl),
                        const SizedBox(height: 20),
                        const Divider(height: 1, color: Color(0xFFE2E8F0)),
                        const SizedBox(height: 16),

                        // Actions
                        Wrap(
                          alignment: WrapAlignment.end,
                          spacing: 10,
                          runSpacing: 8,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.of(dialogCtx).pop(),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _targetPlacementPct = tempPct;
                                  _targetAvgPackage = avgPkgCtrl.text;
                                  _targetMockInterview = mockCtrl.text;
                                  _targetRecruitingPartners = partnersCtrl.text;
                                });
                                Navigator.of(dialogCtx).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Institutional targets updated successfully!", style: GoogleFonts.poppins()),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: const Color(0xFF10B981),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E2865),
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                "Save Targets",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
      },
    );
  }

  Widget _buildTargetModalField(String label, TextEditingController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            controller: ctrl,
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
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
