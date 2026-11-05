import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalStudentAdmissionsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalStudentAdmissionsScreen({super.key, this.onBack});

  @override
  State<PrincipalStudentAdmissionsScreen> createState() =>
      _PrincipalStudentAdmissionsScreenState();
}

class _PrincipalStudentAdmissionsScreenState
    extends State<PrincipalStudentAdmissionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;

  final List<Map<String, dynamic>> _filterPills = [
    {"label": "All", "count": 8},
    {"label": "Enquiry", "count": 0},
    {"label": "Applied", "count": 0},
    {"label": "Documents verified", "count": 3},
    {"label": "Shortlisted", "count": 1},
    {"label": "Offer sent", "count": 1},
    {"label": "Fee paid", "count": 0},
    {"label": "Enrolled", "count": 1},
    {"label": "Rejected", "count": 2},
    {"label": "Withdrawn", "count": 0},
  ];

  final List<Map<String, dynamic>> _records = [
    {
      "id": "ADM-26-1008",
      "name": "Varun Subramanian",
      "mobile": "••••••0741",
      "hsc": "94",
      "program": "B.Tech Information...",
      "community": "ST",
      "status": "Rejected",
      "statusType": "rejected",
      "updated": "27 Sept 2026",
    },
    {
      "id": "ADM-26-1007",
      "name": "Shreya Mohan",
      "mobile": "••••••8680",
      "hsc": "74",
      "program": "B.Tech AI & Data...",
      "community": "ST",
      "status": "Offer sent",
      "statusType": "offer_sent",
      "updated": "26 Sept 2026",
    },
    {
      "id": "ADM-26-1006",
      "name": "Gokul Rao",
      "mobile": "••••••1943",
      "hsc": "79",
      "program": "B.E. Mechanical...",
      "community": "BC",
      "status": "Documents verified",
      "statusType": "verified",
      "updated": "25 Sept 2026",
    },
    {
      "id": "ADM-26-1005",
      "name": "Revathi Reddy",
      "mobile": "••••••5563",
      "hsc": "80",
      "program": "B.E. Computer..",
      "community": "SC",
      "status": "Shortlisted",
      "statusType": "shortlisted",
      "updated": "24 Sept 2026",
    },
    {
      "id": "ADM-26-1004",
      "name": "Imran Balaji",
      "mobile": "••••••7161",
      "hsc": "82",
      "program": "B.E. Computer..",
      "community": "EWS",
      "status": "Documents verified",
      "statusType": "verified",
      "updated": "23 Sept 2026",
    },
    {
      "id": "ADM-26-1003",
      "name": "Deepika Das",
      "mobile": "••••••1829",
      "hsc": "92",
      "program": "B.E. Computer..",
      "community": "OC",
      "status": "Enrolled",
      "statusType": "enrolled",
      "updated": "22 Sept 2026",
    },
    {
      "id": "ADM-26-1002",
      "name": "Manoj Sharma",
      "mobile": "••••••3593",
      "hsc": "91",
      "program": "B.E. Electronics &...",
      "community": "MBC",
      "status": "Rejected",
      "statusType": "rejected",
      "updated": "21 Sept 2026",
    },
    {
      "id": "ADM-26-1001",
      "name": "Ananya Gupta",
      "mobile": "••••••5353",
      "hsc": "68",
      "program": "B.E. Electrical &...",
      "community": "ST",
      "status": "Documents verified",
      "statusType": "verified",
      "updated": "20 Sept 2026",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HERO BLUEPRINT BANNER (Image 4)
                _buildHeroBanner(constraints.maxWidth),
                const SizedBox(height: 16),

                // 2. HORIZONTAL FILTER PILLS (Image 4)
                _buildFilterPills(),
                const SizedBox(height: 16),

                // 3. TABLE CARD WITH SEARCH (Image 4)
                _buildTableCard(),
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
  Widget _buildHeroBanner(double maxWidth) {
    final isCompact = maxWidth < 680;

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
                  Icons.person_outline_rounded,
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
                          "Admissions",
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
                          "Student Admissions",
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

                  // Badges: ADMISSIONS, MVP
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
                          "ADMISSIONS",
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

                  // Title + Action button
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
                            Icons.person_outline_rounded,
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
                              "Student Admissions",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Enquiry → application → document verification → shortlist → offer → fee → enrolment.",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFFCBD5E1),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isCompact) ...[
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add_rounded,
                              size: 16, color: Colors.black87),
                          label: Text(
                            "Add application",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFBBF24),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (isCompact) ...[
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_rounded,
                          size: 16, color: Colors.black87),
                      label: Text(
                        "Add application",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFBBF24),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. HORIZONTAL FILTER PILLS (Image 4)
  // ===========================================================================
  Widget _buildFilterPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(_filterPills.length, (index) {
          final isSelected = _selectedFilterIndex == index;
          final pill = _filterPills[index];

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => setState(() => _selectedFilterIndex = index),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E2865) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      pill["label"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color:
                            isSelected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${pill["count"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? const Color(0xFF93C5FD)
                            : const Color(0xFF94A3B8),
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
  // 3. TABLE CARD WITH SEARCH (Image 4)
  // ===========================================================================
  Widget _buildTableCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search row
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.poppins(fontSize: 12),
                      decoration: const InputDecoration(
                        hintText:
                            "Search by name, ID or 12th / hsc percentage...",
                        hintStyle: TextStyle(
                            fontSize: 11.5, color: Color(0xFF94A3B8)),
                        prefixIcon: Icon(Icons.search_rounded,
                            size: 16, color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  "8 records",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // DataTable
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1050),
              child: DataTable(
                columnSpacing: 18,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 52,
                dataRowMaxHeight: 58,
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                columns: const [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("FULL NAME")),
                  DataColumn(label: Text("MOBILE NUMBER")),
                  DataColumn(label: Text("12TH / HSC PERCENTAGE")),
                  DataColumn(label: Text("PROGRAMME APPLIED FOR")),
                  DataColumn(label: Text("COMMUNITY / CATEGORY")),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("UPDATED")),
                ],
                rows: _records.map((r) {
                  final statusType = r["statusType"] as String;
                  Color statusBg;
                  Color statusColor;

                  if (statusType == "enrolled") {
                    statusBg = const Color(0xFFDCFCE7);
                    statusColor = const Color(0xFF16A34A);
                  } else if (statusType == "verified") {
                    statusBg = const Color(0xFFCCFBF1);
                    statusColor = const Color(0xFF0D9488);
                  } else if (statusType == "offer_sent" ||
                      statusType == "shortlisted") {
                    statusBg = const Color(0xFFE0F2FE);
                    statusColor = const Color(0xFF0284C7);
                  } else {
                    statusBg = const Color(0xFFFFE4E6);
                    statusColor = const Color(0xFFE11D48);
                  }

                  return DataRow(
                    cells: [
                      // ID
                      DataCell(
                        Text(
                          r["id"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      // Full name
                      DataCell(
                        Text(
                          r["name"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Mobile
                      DataCell(
                        Text(
                          r["mobile"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      // HSC
                      DataCell(
                        Text(
                          r["hsc"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Program
                      DataCell(
                        Text(
                          r["program"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      // Community
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            r["community"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ),
                      ),
                      // Status
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            r["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ),
                      // Updated
                      DataCell(
                        Text(
                          r["updated"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF64748B),
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
