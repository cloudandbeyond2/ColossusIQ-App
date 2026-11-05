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

  final List<String> _departments = [
    "All",
    "Computer Science & Engineering",
    "Information Technology",
    "Artificial Intelligence & Data Science",
    "Electronics & Communication",
    "Electrical & Electronics",
    "Mechanical Engineering",
    "Civil Engineering",
  ];

  final List<String> _tiers = [
    "All",
    "Placement ready",
    "Almost ready",
    "Needs work",
  ];

  final List<String> _drives = [
    "Any drive",
    "Tier 1 IT Services",
    "Product / Core Engineering",
    "FinTech & BFSI",
    "Consulting & Analytics",
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
                // 1. HERO BLUEPRINT BANNER (Image 5)
                _buildHeroBanner(),
                const SizedBox(height: 14),

                // Live status row
                _buildLiveStatusRow(),
                const SizedBox(height: 14),

                // 2. 5 METRIC KPI CARDS (Image 5) - Fully Responsive Grid
                _buildKpiCards(),
                const SizedBox(height: 16),

                // 3. FORMULA EXPLANATION BANNER (Image 5)
                _buildFormulaBanner(),
                const SizedBox(height: 18),

                // 4. READINESS BOARD TABLE (Image 5)
                _buildReadinessBoardTable(),
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
                opacity: 0.08,
                child: const Icon(
                  Icons.adjust_rounded,
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
                          color: const Color(0xFF0D9488), // Teal Green
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
                            color: Color(0xFFFBBF24), // Gold Target
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

  // Live status row
  Widget _buildLiveStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Live · updated 01:09:15 pm",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(width: 10),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.sync_rounded, size: 14, color: Color(0xFF475569)),
          label: Text("Refresh",
              style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF475569))),
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
  // 2. 5 METRIC KPI CARDS (Image 5) - Fully Responsive Grid
  // ===========================================================================
  Widget _buildKpiCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final int count = width >= 1150
            ? 5
            : (width >= 400 ? 3 : 2);
        final double spacing = width < 500 ? 8.0 : 10.0;
        final double cardWidth = (width - ((count - 1) * spacing)) / count;
        final double cardHeight = width < 500 ? 80.0 : 86.0;
        final double ratio = cardWidth / cardHeight;

        return GridView.count(
          crossAxisCount: count,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: ratio,
          children: [
            _buildMetricCard(
              title: "Students tracked",
              value: "14",
              icon: Icons.people_outline_rounded,
              isCompact: cardWidth < 145,
            ),
            _buildMetricCard(
              title: "Placement ready",
              value: "3",
              icon: Icons.check_circle_outline_rounded,
              isCompact: cardWidth < 145,
            ),
            _buildMetricCard(
              title: "Almost ready",
              value: "8",
              icon: Icons.hourglass_empty_rounded,
              isCompact: cardWidth < 145,
            ),
            _buildMetricCard(
              title: "Needs work",
              value: "3",
              icon: Icons.warning_amber_rounded,
              isCompact: cardWidth < 145,
            ),
            _buildMetricCard(
              title: "Average total",
              value: "65",
              icon: Icons.bar_chart_rounded,
              isCompact: cardWidth < 145,
            ),
          ],
        );
      },
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    bool isCompact = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 10 : 14,
        vertical: isCompact ? 10 : 12,
      ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: isCompact ? 13 : 15, color: const Color(0xFF64748B)),
              SizedBox(width: isCompact ? 5 : 7),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: isCompact ? 11 : 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: isCompact ? 20 : 23,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. FORMULA EXPLANATION BANNER (Image 5)
  // ===========================================================================
  Widget _buildFormulaBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF475569),
            height: 1.4,
          ),
          children: const [
            TextSpan(
              text: "Placement ready ",
              style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
            ),
            TextSpan(
              text: "= total ≥ 70, quiz average ≥ 60%, ≥ 2 certificates and mock interview ≥ 50. Total = quiz 35% + certificates 20% + aptitude 15% + interview 15% + resume 15%.",
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. READINESS BOARD TABLE (Image 5)
  // ===========================================================================
  Widget _buildReadinessBoardTable() {
    final students = [
      {
        "name": "Sanjay Pillai",
        "roll": "••••1007 · Information Technology",
        "quiz": "80%",
        "certs": "3",
        "aptitude": "78",
        "interview": "85",
        "resume": "93",
        "total": 81,
        "status": "Placement ready",
        "statusType": "ready",
        "hint": null,
      },
      {
        "name": "Sneha Srinivasan",
        "roll": "••••1056 · Computer Science & Engineering",
        "quiz": "88%",
        "certs": "4",
        "aptitude": "67",
        "interview": "49",
        "resume": "65",
        "total": 78,
        "status": "Almost ready",
        "statusType": "almost",
        "hint": "Score 50+ in a mock interview",
      },
      {
        "name": "Deepika Das",
        "roll": "••••1028 · Electrical & Electronics",
        "quiz": "68%",
        "certs": "4",
        "aptitude": "78",
        "interview": "69",
        "resume": "75",
        "total": 77,
        "status": "Placement ready",
        "statusType": "ready",
        "hint": null,
      },
      {
        "name": "Nandini Krishnan",
        "roll": "••••1014 · Artificial Intelligence & Data Science",
        "quiz": "60%",
        "certs": "4",
        "aptitude": "62",
        "interview": "76",
        "resume": "86",
        "total": 75,
        "status": "Placement ready",
        "statusType": "ready",
        "hint": null,
      },
      {
        "name": "Arjun Varma",
        "roll": "••••1063 · Information Technology",
        "quiz": "59%",
        "certs": "3",
        "aptitude": "71",
        "interview": "85",
        "resume": "67",
        "total": 70,
        "status": "Placement ready",
        "statusType": "ready",
        "hint": null,
      },
      {
        "name": "Sanjay Balaji",
        "roll": "••••1077 · Electronics & Communication",
        "quiz": "72%",
        "certs": "1",
        "aptitude": "65",
        "interview": "62",
        "resume": "88",
        "total": 64,
        "status": "Almost ready",
        "statusType": "almost",
        "hint": "Earn 1 more certificate",
      },
      {
        "name": "Gokul Rao",
        "roll": "••••1035 · Mechanical Engineering",
        "quiz": "65%",
        "certs": "1",
        "aptitude": "58",
        "interview": "52",
        "resume": "95",
        "total": 64,
        "status": "Almost ready",
        "statusType": "almost",
        "hint": "Earn 1 more certificate",
      },
      {
        "name": "Joseph Patel",
        "roll": "••••1021 · Electronics & Communication",
        "quiz": "47%",
        "certs": "4",
        "aptitude": "62",
        "interview": "37",
        "resume": "54",
        "total": 61,
        "status": "Almost ready",
        "statusType": "almost",
        "hint": "Score 50+ in a mock interview",
      },
      {
        "name": "Kavya Menon",
        "roll": "••••1006 · Computer Science & Engineering",
        "quiz": "48%",
        "certs": "1",
        "aptitude": "50",
        "interview": "75",
        "resume": "89",
        "total": 55,
        "status": "Almost ready",
        "statusType": "almost",
        "hint": "Raise quiz avg to 60%",
      },
      {
        "name": "Keerthana Joseph",
        "roll": "••••1042 · Civil Engineering",
        "quiz": "66%",
        "certs": "1",
        "aptitude": "42",
        "interview": "49",
        "resume": "52",
        "total": 53,
        "status": "Needs work",
        "statusType": "needs_work",
        "hint": "Multiple criteria deficit",
      },
      {
        "name": "Karthik Khan",
        "roll": "••••1049 · Science & Humanities",
        "quiz": "77%",
        "certs": "0",
        "aptitude": "45",
        "interview": "47",
        "resume": "76",
        "total": 52,
        "status": "Needs work",
        "statusType": "needs_work",
        "hint": "Earn 2 certificates",
      },
      {
        "name": "Kavya Gupta",
        "roll": "••••1070 · Artificial Intelligence & Data Science",
        "quiz": "59%",
        "certs": "0",
        "aptitude": "40",
        "interview": "55",
        "resume": "57",
        "total": 44,
        "status": "Needs work",
        "statusType": "needs_work",
        "hint": "Earn 2 certificates",
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
          // Header with Export button
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
                      size: 15, color: Color(0xFF334155)),
                  label: Text(
                    "Export shortlist (CSV)",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // Filters row
          Padding(
            padding: const EdgeInsets.all(14),
            child: Wrap(
              spacing: 12,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
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
                      hintText: "Search student",
                      hintStyle:
                          TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                _buildDropdownFilter(_selectedDept, _departments,
                    (v) => setState(() => _selectedDept = v!)),
                _buildDropdownFilter(_selectedTier, _tiers,
                    (v) => setState(() => _selectedTier = v!)),
                _buildDropdownFilter(_selectedDrive, _drives,
                    (v) => setState(() => _selectedDrive = v!)),
              ],
            ),
          ),

          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1000),
              child: DataTable(
                columnSpacing: 18,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 58,
                dataRowMaxHeight: 66,
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
                rows: students.map((s) {
                  final total = s["total"] as int;
                  final statusType = s["statusType"] as String;
                  Color statusBg;
                  Color statusColor;

                  if (statusType == "ready") {
                    statusBg = const Color(0xFFCCFBF1);
                    statusColor = const Color(0xFF0D9488);
                  } else if (statusType == "almost") {
                    statusBg = const Color(0xFFFEF3C7);
                    statusColor = const Color(0xFFD97706);
                  } else {
                    statusBg = const Color(0xFFFFE4E6);
                    statusColor = const Color(0xFFE11D48);
                  }

                  return DataRow(
                    cells: [
                      // Student
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              s["name"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
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
                      // Quiz
                      DataCell(
                        Text(
                          s["quiz"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Certs
                      DataCell(
                        Text(
                          s["certs"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Aptitude
                      DataCell(
                        Text(
                          s["aptitude"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Interview
                      DataCell(
                        Text(
                          s["interview"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Resume
                      DataCell(
                        Text(
                          s["resume"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Total
                      DataCell(
                        Row(
                          children: [
                            Text(
                              "$total",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 36,
                              child: LinearProgressIndicator(
                                value: total / 100,
                                backgroundColor: const Color(0xFFF1F5F9),
                                valueColor: AlwaysStoppedAnimation(
                                  total >= 70
                                      ? const Color(0xFF0D9488)
                                      : const Color(0xFF131B4D),
                                ),
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: statusBg,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                s["status"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ),
                            if (s["hint"] != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                s["hint"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 9.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
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

  Widget _buildDropdownFilter(
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
