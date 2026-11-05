import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalAicteComplianceScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalAicteComplianceScreen({super.key, this.onBack});

  @override
  State<PrincipalAicteComplianceScreen> createState() =>
      _PrincipalAicteComplianceScreenState();
}

class _PrincipalAicteComplianceScreenState
    extends State<PrincipalAicteComplianceScreen> {
  int _selectedTab = 0; // 0: Norms, 1: Dept Breakdown, 2: Statutory Committees, 3: Action Plan
  String _deptSearchQuery = "";
  String _selectedDeptFilter = "All Sanctioned Departments";
  String _actionStatusFilter = "All Statuses";

  void _showLogActionDialog() {
    final titleCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add_task_rounded,
                  color: Color(0xFF283685), size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              "Log Compliance Action",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assign remediation tasks to resolve cadre ratio, laboratory curricula, or statutory committee deficits.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleCtrl,
              style: GoogleFonts.poppins(fontSize: 12.5),
              decoration: InputDecoration(
                labelText: "Action Title",
                hintText: "e.g. Designate Professor post for IT Department",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: "High",
                        items: const [
                          DropdownMenuItem(value: "High", child: Text("High Priority")),
                          DropdownMenuItem(value: "Medium", child: Text("Medium Priority")),
                          DropdownMenuItem(value: "Low", child: Text("Low Priority")),
                        ],
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: "Faculty Cadre",
                        items: const [
                          DropdownMenuItem(value: "Faculty Cadre", child: Text("Cadre Ratio")),
                          DropdownMenuItem(value: "Statutory", child: Text("Committees")),
                          DropdownMenuItem(value: "Labs", child: Text("Labs/Curriculum")),
                        ],
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Compliance action item logged successfully."),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF131B4D),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Log Action", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showRecordCommitteeDialog(String committeeName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Record $committeeName",
          style: GoogleFonts.poppins(
            fontSize: 15.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter appointed committee lead, constituted members, and upload minutes of meeting (MoM) to sync with AICTE public disclosures.",
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 14),
            TextField(
              style: GoogleFonts.poppins(fontSize: 12.5),
              decoration: InputDecoration(
                labelText: "Chairperson / Lead Name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              style: GoogleFonts.poppins(fontSize: 12.5),
              decoration: InputDecoration(
                labelText: "Constituted Members (comma separated)",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$committeeName updated and recorded."),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF131B4D),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Save & Record", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
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
                // 1. TOP BLUEPRINT HERO BANNER
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. INSTITUTIONAL REGULATORY & APPROVAL TRACKING CARD
                _buildInstitutionOverviewCard(),
                const SizedBox(height: 20),

                // 3. 4 METRIC KPI STAT CARDS
                _buildKpiCards(constraints.maxWidth),
                const SizedBox(height: 22),

                // 4. NAVIGATION SUB-TABS
                _buildSubTabs(),
                const SizedBox(height: 20),

                // 5. ACTIVE SUB-TAB CONTENT
                switch (_selectedTab) {
                  1 => _buildDepartmentBreakdownTab(constraints.maxWidth),
                  2 => _buildStatutoryCommitteesTab(constraints.maxWidth),
                  3 => _buildComplianceActionPlanTab(),
                  _ => _buildNormsScorecardTab(constraints.maxWidth),
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
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.verified_user_rounded,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
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
                          "AICTE Compliance",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Header Row with Icon & Badges
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E285F),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.verified_user_rounded,
                            color: Color(0xFFF59E0B),
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "INSTITUTION",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Phase 3",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "AICTE Compliance",
                              style: GoogleFonts.poppins(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Approval conditions, faculty-student ratio, labs and mandatory disclosures.",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFCBD5E1),
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
  // 2. INSTITUTIONAL REGULATORY & APPROVAL TRACKING CARD
  // ===========================================================================
  Widget _buildInstitutionOverviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          final isDesktop = constraints.maxWidth >= 900;

          final leftInfo = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "AICTE REGULATORY & APPROVAL TRACKING",
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "PID: 1-1101-AICTE-TN (reference)",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Enter AICTE ID",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "AY 2026–2027",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Deficient (41%)",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFDC2626),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Anna Institute of Technology",
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Institutional approval conditions, faculty-to-student cadre norms, laboratory curricula, and mandatory public disclosures.",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
            ],
          );

          final rightActions = Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Syncing metrics with AICTE Portal..."),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1E293B),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  "Sync Metrics",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Exporting AICTE regulatory dossier (CSV)..."),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.download_rounded, size: 14),
                label: Text(
                  "Export Report (CSV)",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1E293B),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _showLogActionDialog,
                icon: const Icon(Icons.add_rounded, size: 16),
                label: Text(
                  "Log Action",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF131B4D),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          );

          if (isDesktop) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: leftInfo),
                const SizedBox(width: 16),
                rightActions,
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leftInfo,
              const SizedBox(height: 16),
              rightActions,
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 3. 4 METRIC KPI STAT CARDS
  // ===========================================================================
  Widget _buildKpiCards(double maxWidth) {
    final kpis = [
      {
        "title": "AICTE Compliance Index",
        "value": "41%",
        "subtitle": "Review needed",
        "dotColor": const Color(0xFFEF4444), // Red
      },
      {
        "title": "Faculty-Student Ratio",
        "value": "1 : 4.7",
        "subtitle": "Norm: 1:20 (within limit)",
        "dotColor": const Color(0xFF10B981), // Green
      },
      {
        "title": "Teaching Faculty",
        "value": "3",
        "subtitle": "0 Prof · 2 Assoc · 1 Asst",
        "dotColor": null,
      },
      {
        "title": "Statutory Committees",
        "value": "0 / 6 Constituted",
        "subtitle": "6 not yet recorded",
        "dotColor": const Color(0xFFF59E0B), // Orange
      },
    ];

    if (maxWidth >= 1000) {
      return Row(
        children: kpis.map((k) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: _buildSingleKpiCard(k),
            ),
          );
        }).toList(),
      );
    } else if (maxWidth >= 600) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildSingleKpiCard(kpis[0])),
              const SizedBox(width: 12),
              Expanded(child: _buildSingleKpiCard(kpis[1])),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildSingleKpiCard(kpis[2])),
              const SizedBox(width: 12),
              Expanded(child: _buildSingleKpiCard(kpis[3])),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: kpis.map((k) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildSingleKpiCard(k),
          );
        }).toList(),
      );
    }
  }

  Widget _buildSingleKpiCard(Map<String, dynamic> k) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  k["title"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (k["dotColor"] != null)
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: k["dotColor"] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            k["value"] as String,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            k["subtitle"] as String,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. NAVIGATION SUB-TABS
  // ===========================================================================
  Widget _buildSubTabs() {
    final tabs = [
      {"icon": Icons.shield_outlined, "title": "Norms Scorecard & Analysis"},
      {"icon": Icons.apps_outlined, "title": "Department Breakdown (8)"},
      {"icon": Icons.group_outlined, "title": "Statutory Committees & Disclosures"},
      {"title": "Compliance Action Plan (0)"},
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
                    if (t["icon"] != null) ...[
                      Icon(
                        t["icon"] as IconData,
                        size: 16,
                        color: isSelected
                            ? const Color(0xFF1E1B4B)
                            : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 8),
                    ],
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
  // 5A. TAB 0: NORMS SCORECARD & ANALYSIS (Images 1 & 2)
  // ===========================================================================
  Widget _buildNormsScorecardTab(double maxWidth) {
    final isDesktop = maxWidth >= 900;

    // Charts Row
    final chartsRow = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildNormsComplianceScoreCard()),
              const SizedBox(width: 18),
              Expanded(child: _buildDepartmentFacultyStudentsCard()),
            ],
          )
        : Column(
            children: [
              _buildNormsComplianceScoreCard(),
              const SizedBox(height: 18),
              _buildDepartmentFacultyStudentsCard(),
            ],
          );

    // Strengths & Observations Row (Image 2)
    final strengthsAndObsRow = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: _buildInstitutionalStrengthsCard()),
              const SizedBox(width: 18),
              Expanded(flex: 6, child: _buildActionableObservationsCard()),
            ],
          )
        : Column(
            children: [
              _buildInstitutionalStrengthsCard(),
              const SizedBox(height: 18),
              _buildActionableObservationsCard(),
            ],
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        chartsRow,
        const SizedBox(height: 20),
        strengthsAndObsRow,
        const SizedBox(height: 20),
        _buildRegulatoryStandardsEvaluationCard(),
      ],
    );
  }

  Widget _buildNormsComplianceScoreCard() {
    return Container(
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
            "AICTE Norms Compliance Score (%)",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            width: double.infinity,
            child: CustomPaint(
              painter: _AicteNormsBarChartPainter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentFacultyStudentsCard() {
    return Container(
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
            "Department Faculty vs Students Allocation",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            width: double.infinity,
            child: CustomPaint(
              painter: _AicteFacultyAllocationChartPainter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstitutionalStrengthsCard() {
    return Container(
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
            children: [
              const Icon(Icons.check_rounded, color: Color(0xFF0D9488), size: 18),
              const SizedBox(width: 8),
              Text(
                "Institutional Strengths",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(top: 6, right: 10),
                decoration: const BoxDecoration(
                  color: Color(0xFF0D9488),
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  "Faculty-student ratio is 1 : 4.7 (14 students, 3 teaching faculty), within the 1:20 norm.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF334155),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionableObservationsCard() {
    final observations = [
      "No Professor-level faculty are recorded; designate or recruit senior faculty.",
      "6 statutory committees have not been recorded: Anti-Ragging Committee, Internal Complaints Committee, Student Grievance Redressal Committee, SC / ST Committee, Internal Quality Assurance Cell, Industry-Institute Interaction Cell.",
      "No practical course in 8 departments.",
      "Information Technology has 2 students and no assigned faculty.",
      "Artificial Intelligence & Data Science has 2 students and no assigned faculty.",
      "Electrical & Electronics has 2 students and no assigned faculty.",
      "Mechanical Engineering has 2 students and no assigned faculty.",
      "Civil Engineering has 1 students and no assigned faculty.",
      "Public disclosure incomplete: AICTE permanent id.",
    ];

    return Container(
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
            "Actionable Observations & Routine Audit",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          ...observations.map((obs) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6, right: 10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD97706), // Amber bullet
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      obs,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF334155),
                        height: 1.45,
                      ),
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

  Widget _buildRegulatoryStandardsEvaluationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AICTE Regulatory Standards Evaluation",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 18),

          // Standard 1: FSR
          _buildStandardEvaluationRow(
            title: "Faculty-Student Ratio (FSR)",
            badge: "Compliant",
            badgeColor: const Color(0xFFCCFBF1),
            badgeTextColor: const Color(0xFF0F766E),
            category: "(Faculty & Academics)",
            normReq: "Norm Requirement: Min 1:20 for UG Technical Courses (AICTE APH 2026–2027)",
            actualRecord: "Actual Institutional Record: 1 : 4.7 (14 enrolled students : 3 teaching faculty)",
            note: "Within the regulatory limit.",
            progressVal: 1.0,
            progressColor: const Color(0xFF0D9488),
            percentText: "100%",
          ),
          const Divider(height: 32, color: Color(0xFFF1F5F9)),

          // Standard 2: Cadre Ratio
          _buildStandardEvaluationRow(
            title: "Faculty Cadre Ratio",
            badge: "Deficient",
            badgeColor: const Color(0xFFFEE2E2),
            badgeTextColor: const Color(0xFFDC2626),
            category: "(Faculty & Academics)",
            normReq: "Norm Requirement: 1 : 2 : 6 (Professor : Assoc. Professor : Asst. Professor)",
            actualRecord: "Actual Institutional Record: 0 Prof : 2 Assoc : 1 Asst Prof",
            note: "Add Professor and Associate Professor posts, or correct the designations in Staff Management.",
            progressVal: 0.56,
            progressColor: const Color(0xFF991B1B),
            percentText: "56%",
          ),
          const Divider(height: 32, color: Color(0xFFF1F5F9)),

          // Standard 3: Statutory Committees
          _buildStandardEvaluationRow(
            title: "Statutory Committees & Grievance Bodies",
            badge: "Deficient",
            badgeColor: const Color(0xFFFEE2E2),
            badgeTextColor: const Color(0xFFDC2626),
            category: "(Governance & Statutory)",
            normReq: "Norm Requirement: Mandatory constitution of Anti-Ragging, ICC, SGRC, SC/ST, IQAC and IIIC",
            actualRecord: "Actual Institutional Record: 0 of 6 constituted · 0 recorded on this page",
            note: "Record 6 committees in the Statutory Committees tab.",
            progressVal: 0.0,
            progressColor: const Color(0xFF991B1B),
            percentText: "0%",
          ),
        ],
      ),
    );
  }

  Widget _buildStandardEvaluationRow({
    required String title,
    required String badge,
    required Color badgeColor,
    required Color badgeTextColor,
    required String category,
    required String normReq,
    required String actualRecord,
    required String note,
    required double progressVal,
    required Color progressColor,
    required String percentText,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 650;

        final details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge,
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: badgeTextColor,
                    ),
                  ),
                ),
                Text(
                  category,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              normReq,
              style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF475569)),
            ),
            Text(
              actualRecord,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
            Text(
              note,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        );

        final bar = SizedBox(
          width: isNarrow ? double.infinity : 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                percentText,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: progressVal,
                  minHeight: 6,
                  backgroundColor: const Color(0xFFF1F5F9),
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ),
            ],
          ),
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              details,
              const SizedBox(height: 12),
              bar,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: details),
            const SizedBox(width: 20),
            bar,
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 5B. TAB 1: DEPARTMENT BREAKDOWN (8) (Image 3)
  // ===========================================================================
  Widget _buildDepartmentBreakdownTab(double maxWidth) {
    final depts = [
      {
        "name": "Computer Science & Engineering",
        "status": "Compliant",
        "statusColor": const Color(0xFFCCFBF1),
        "textColor": const Color(0xFF0F766E),
        "students": 2,
        "faculty": 1,
        "ratio": "1 : 2",
        "isShortage": false,
        "cadre": "0 Prof · 1 Assoc · 0 Asst",
        "courses": "3 Courses (0 Labs)",
      },
      {
        "name": "Information Technology",
        "status": "Action Required",
        "statusColor": const Color(0xFFFFFBEB),
        "textColor": const Color(0xFFB45309),
        "students": 2,
        "faculty": 0,
        "ratio": "Faculty Shortage",
        "isShortage": true,
        "cadre": "0 Prof · 0 Assoc · 0 Asst",
        "courses": "0 Courses (0 Labs)",
      },
      {
        "name": "Artificial Intelligence & Data Science",
        "status": "Action Required",
        "statusColor": const Color(0xFFFFFBEB),
        "textColor": const Color(0xFFB45309),
        "students": 2,
        "faculty": 0,
        "ratio": "Faculty Shortage",
        "isShortage": true,
        "cadre": "0 Prof · 0 Assoc · 0 Asst",
        "courses": "1 Courses (0 Labs)",
      },
      {
        "name": "Electronics & Communication",
        "status": "Compliant",
        "statusColor": const Color(0xFFCCFBF1),
        "textColor": const Color(0xFF0F766E),
        "students": 2,
        "faculty": 1,
        "ratio": "1 : 2",
        "isShortage": false,
        "cadre": "0 Prof · 1 Assoc · 0 Asst",
        "courses": "1 Courses (0 Labs)",
      },
      {
        "name": "Electrical & Electronics",
        "status": "Action Required",
        "statusColor": const Color(0xFFFFFBEB),
        "textColor": const Color(0xFFB45309),
        "students": 2,
        "faculty": 0,
        "ratio": "Faculty Shortage",
        "isShortage": true,
        "cadre": "0 Prof · 0 Assoc · 0 Asst",
        "courses": "0 Courses (0 Labs)",
      },
      {
        "name": "Mechanical Engineering",
        "status": "Action Required",
        "statusColor": const Color(0xFFFFFBEB),
        "textColor": const Color(0xFFB45309),
        "students": 2,
        "faculty": 0,
        "ratio": "Faculty Shortage",
        "isShortage": true,
        "cadre": "0 Prof · 0 Assoc · 0 Asst",
        "courses": "1 Courses (0 Labs)",
      },
      {
        "name": "Civil Engineering",
        "status": "Action Required",
        "statusColor": const Color(0xFFFFFBEB),
        "textColor": const Color(0xFFB45309),
        "students": 1,
        "faculty": 0,
        "ratio": "Faculty Shortage",
        "isShortage": true,
        "cadre": "0 Prof · 0 Assoc · 0 Asst",
        "courses": "0 Courses (0 Labs)",
      },
      {
        "name": "Science & Humanities",
        "status": "Compliant",
        "statusColor": const Color(0xFFCCFBF1),
        "textColor": const Color(0xFF0F766E),
        "students": 1,
        "faculty": 1,
        "ratio": "1 : 1",
        "isShortage": false,
        "cadre": "0 Prof · 0 Assoc · 1 Asst",
        "courses": "0 Courses (0 Labs)",
      },
    ];

    final filtered = depts.where((d) {
      if (_deptSearchQuery.isEmpty) return true;
      return (d["name"] as String)
          .toLowerCase()
          .contains(_deptSearchQuery.toLowerCase());
    }).toList();

    return Column(
      children: [
        // Search & Filter Row
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  onChanged: (val) => setState(() => _deptSearchQuery = val),
                  style: GoogleFonts.poppins(
                      fontSize: 12.5, color: const Color(0xFF1E293B)),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded,
                        size: 18, color: Color(0xFF94A3B8)),
                    hintText: "Search departments...",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 12, color: const Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedDeptFilter,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      size: 16, color: Color(0xFF64748B)),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "All Sanctioned Departments",
                      child: Text("Department: All Sanctioned Departments"),
                    ),
                    DropdownMenuItem(
                      value: "Action Required",
                      child: Text("Department: Action Required"),
                    ),
                    DropdownMenuItem(
                      value: "Compliant",
                      child: Text("Department: Compliant"),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedDeptFilter = val);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Grid of Department Cards
        LayoutBuilder(
          builder: (context, box) {
            final colCount = box.maxWidth >= 1100
                ? 3
                : box.maxWidth >= 720
                    ? 2
                    : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: colCount == 1
                    ? 1.35
                    : colCount == 2
                        ? 1.15
                        : 1.05,
              ),
              itemCount: filtered.length,
              itemBuilder: (ctx, idx) {
                final d = filtered[idx];
                final isShortage = d["isShortage"] as bool;

                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
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
                      // Header: Title & Pill
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              d["name"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: d["statusColor"] as Color,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              d["status"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: d["textColor"] as Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Metric Row 1: Enrolled & Teaching Faculty
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Enrolled Students",
                                  style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      color: const Color(0xFF64748B)),
                                ),
                                Text(
                                  "${d["students"]}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Teaching Faculty",
                                  style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      color: const Color(0xFF64748B)),
                                ),
                                Text(
                                  "${d["faculty"]}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16, color: Color(0xFFF1F5F9)),

                      // Dept FSR Ratio
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dept. FSR (Ratio)",
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B))),
                          Text(
                            d["ratio"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: isShortage
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16, color: Color(0xFFF1F5F9)),

                      // Cadre Distribution
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cadre Distribution",
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B))),
                          Flexible(
                            child: Text(
                              d["cadre"] as String,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF334155)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16, color: Color(0xFFF1F5F9)),

                      // Courses & Laboratories
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Courses & Laboratories",
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B))),
                          Flexible(
                            child: Text(
                              d["courses"] as String,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF334155)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // 5C. TAB 2: STATUTORY COMMITTEES & DISCLOSURES (Image 4)
  // ===========================================================================
  Widget _buildStatutoryCommitteesTab(double maxWidth) {
    final committees = [
      {
        "name": "Anti-Ragging Committee & Squad",
        "code": "COM-01",
        "desc": "AICTE Regulations 2009 (Clause 6a) – Ragging prevention, squad monitoring, and student affidavits",
      },
      {
        "name": "Internal Complaints Committee (ICC) / POSH",
        "code": "COM-02",
        "desc": "POSH Act 2013 & AICTE Regulations 2016 – Gender sensitization, woman safety, and grievance redressal",
      },
      {
        "name": "Student Grievance Redressal Committee (SGRC)",
        "code": "COM-03",
        "desc": "AICTE Regulations 2019 – Ombudsman oversight, student grievance portal, and appellate mechanism",
      },
      {
        "name": "SC / ST Committee & Equal Opportunity Cell",
        "code": "COM-04",
        "desc": "Scheduled Castes & Scheduled Tribes Prevention of Atrocities Act & AICTE guidelines",
      },
      {
        "name": "Internal Quality Assurance Cell (IQAC)",
        "code": "COM-05",
        "desc": "Continuous quality monitoring, academic audits, NIRF/NBA alignment, and student feedback",
      },
      {
        "name": "Industry-Institute Interaction Cell (IIIC) & Placement",
        "code": "COM-06",
        "desc": "AICTE Internship Policy, industry MoUs, campus placement drives, and skill development",
      },
    ];

    return Column(
      children: [
        // Banner: AICTE Mandatory Public Disclosure Portal
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(Icons.language_rounded, color: Color(0xFF0F172A), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "AICTE Mandatory Public Disclosure Portal",
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCCFBF1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "Profile 90% complete",
                            style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Publicly accessible regulatory disclosures containing approved programmes, faculty profiles, grievance mechanism, and fee structure.",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Grid of 6 Committee Cards
        LayoutBuilder(
          builder: (context, box) {
            final colCount = box.maxWidth >= 1100
                ? 3
                : box.maxWidth >= 720
                    ? 2
                    : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: colCount == 1
                    ? 1.15
                    : colCount == 2
                        ? 0.98
                        : 0.92,
              ),
              itemCount: committees.length,
              itemBuilder: (ctx, idx) {
                final c = committees[idx];

                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Title & Pill
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c["name"]!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  c["code"]!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Not Recorded",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Text(
                        c["desc"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF475569),
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Divider(height: 16, color: Color(0xFFF1F5F9)),

                      // Key value details
                      _buildCommitteeMetaRow("Chairperson / Lead", "Not assigned"),
                      const SizedBox(height: 5),
                      _buildCommitteeMetaRow("Constituted Members", "–"),
                      const SizedBox(height: 5),
                      _buildCommitteeMetaRow("Last Review Meeting", "None recorded"),
                      const SizedBox(height: 5),
                      _buildCommitteeMetaRow("Meeting Minutes (MoM)", "Not Recorded"),
                      const Spacer(),
                      const SizedBox(height: 10),

                      // Action Button
                      OutlinedButton.icon(
                        onPressed: () => _showRecordCommitteeDialog(c["name"]!),
                        icon: const Icon(Icons.edit_outlined, size: 14),
                        label: Text(
                          "Record committee",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF1E293B),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          minimumSize: const Size(double.infinity, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCommitteeMetaRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          textAlign: TextAlign.right,
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5D. TAB 3: COMPLIANCE ACTION PLAN (0) (Image 5)
  // ===========================================================================
  Widget _buildComplianceActionPlanTab() {
    return Column(
      children: [
        // Controls Row
        LayoutBuilder(
          builder: (context, box) {
            final isCompact = box.maxWidth < 680;

            final filterWidget = Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Filter by Status:",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _actionStatusFilter,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 16),
                      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1E293B)),
                      items: const [
                        DropdownMenuItem(value: "All Statuses", child: Text("All Statuses")),
                        DropdownMenuItem(value: "Open", child: Text("Open")),
                        DropdownMenuItem(value: "In Progress", child: Text("In Progress")),
                        DropdownMenuItem(value: "Resolved", child: Text("Resolved")),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _actionStatusFilter = val);
                      },
                    ),
                  ),
                ),
              ],
            );

            final summaryAndActionWidget = Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: isCompact ? WrapAlignment.start : WrapAlignment.end,
              children: [
                Text(
                  "0 open · 0 in progress · 0 resolved",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showLogActionDialog,
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: Text(
                    "Log Action Item",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF131B4D),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            );

            if (isCompact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  filterWidget,
                  const SizedBox(height: 12),
                  summaryAndActionWidget,
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                filterWidget,
                summaryAndActionWidget,
              ],
            );
          },
        ),
        const SizedBox(height: 18),

        // Empty state container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Center(
            child: Text(
              "No compliance actions recorded yet. Click 'Log Action Item' above to assign regulatory tasks, committee follow-ups, or audit remediations.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// AICTE NORMS COMPLIANCE SCORE BAR CHART PAINTER (Navy bars)
// =============================================================================
class _AicteNormsBarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    const leftPad = 32.0;
    const bottomPad = 26.0;
    final chartW = w - leftPad - 10;
    final chartH = h - bottomPad - 10;

    // Y Axis grid lines (0, 25, 50, 75, 100)
    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;
    final textStyle = GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF94A3B8));

    final steps = [0, 25, 50, 75, 100];
    for (int i = 0; i < steps.length; i++) {
      final y = chartH - (i / (steps.length - 1)) * chartH + 10;
      canvas.drawLine(Offset(leftPad, y), Offset(w - 10, y), gridPaint);
      final tp = TextPainter(
        text: TextSpan(text: "${steps[i]}", style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    // 4 Norm Categories
    final categories = [
      {"name": "FSR", "val": 100.0},
      {"name": "Cadre", "val": 56.0},
      {"name": "Committees", "val": 0.0},
      {"name": "Public Discl.", "val": 90.0},
    ];

    final colWidth = chartW / categories.length;
    final barW = (colWidth * 0.4).clamp(16.0, 36.0);

    for (int i = 0; i < categories.length; i++) {
      final c = categories[i];
      final val = c["val"] as double;
      final x = leftPad + i * colWidth + (colWidth - barW) / 2;

      if (val > 0) {
        final barH = (val / 100.0) * chartH;
        final barY = chartH - barH + 10;
        final rrect = RRect.fromRectAndCorners(
          Rect.fromLTWH(x, barY, barW, barH),
          topLeft: const Radius.circular(4),
          topRight: const Radius.circular(4),
        );
        canvas.drawRRect(rrect, Paint()..color = const Color(0xFF1E293B));
      }

      final tp = TextPainter(
        text: TextSpan(
          text: c["name"] as String,
          style: GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF64748B)),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(leftPad + i * colWidth + (colWidth - tp.width) / 2, h - 18));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// AICTE FACULTY ALLOCATION BAR CHART PAINTER (Grouped Navy & Gold)
// =============================================================================
class _AicteFacultyAllocationChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    const leftPad = 26.0;
    const bottomPad = 26.0;
    final chartW = w - leftPad - 10;
    final chartH = h - bottomPad - 10;

    // Y Axis (0, 0.5, 1, 1.5, 2)
    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;
    final textStyle = GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF94A3B8));

    final steps = ["0", "0.5", "1", "1.5", "2"];
    for (int i = 0; i < steps.length; i++) {
      final y = chartH - (i / (steps.length - 1)) * chartH + 10;
      canvas.drawLine(Offset(leftPad, y), Offset(w - 10, y), gridPaint);
      final tp = TextPainter(
        text: TextSpan(text: steps[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    final depts = [
      {"name": "Computer Sci", "students": 2.0, "faculty": 1.0},
      {"name": "Information", "students": 2.0, "faculty": 0.0},
      {"name": "Artificial I", "students": 2.0, "faculty": 0.0},
      {"name": "Electronics", "students": 2.0, "faculty": 1.0},
      {"name": "Electrical &", "students": 2.0, "faculty": 0.0},
      {"name": "Mechanical E", "students": 2.0, "faculty": 0.0},
    ];

    final colWidth = chartW / depts.length;
    const barW = 12.0;

    for (int i = 0; i < depts.length; i++) {
      final d = depts[i];
      final studentsVal = d["students"] as double;
      final facultyVal = d["faculty"] as double;
      final groupCenterX = leftPad + i * colWidth + colWidth / 2;

      // Students Bar (Navy)
      if (studentsVal > 0) {
        final barH = (studentsVal / 2.0) * chartH;
        final rrect = RRect.fromRectAndCorners(
          Rect.fromLTWH(groupCenterX - barW - 1, chartH - barH + 10, barW, barH),
          topLeft: const Radius.circular(3),
          topRight: const Radius.circular(3),
        );
        canvas.drawRRect(rrect, Paint()..color = const Color(0xFF1E293B));
      }

      // Faculty Bar (Gold)
      if (facultyVal > 0) {
        final barH = (facultyVal / 2.0) * chartH;
        final rrect = RRect.fromRectAndCorners(
          Rect.fromLTWH(groupCenterX + 1, chartH - barH + 10, barW, barH),
          topLeft: const Radius.circular(3),
          topRight: const Radius.circular(3),
        );
        canvas.drawRRect(rrect, Paint()..color = const Color(0xFFD97706));
      }

      // X Label
      final tp = TextPainter(
        text: TextSpan(
          text: d["name"] as String,
          style: GoogleFonts.poppins(fontSize: 8.5, color: const Color(0xFF64748B)),
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
