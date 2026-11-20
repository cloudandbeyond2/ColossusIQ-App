import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/certificate_pdf_service.dart';

// =============================================================================
// PRINCIPAL: ISSUED CERTIFICATES SCREEN (Exact implementation of Image 1)
// - Hero Blueprint Banner: "Home > AI Course & Certification > Issued Certificates"
//   Badges: "AI COURSE & CERTIFICATION", "MVP"
// - 6 KPI Stat Cards: Issued (6), Grade O (3), Grade A+ (2), Grade A (0), Grade B (0), Grade C (1)
// - Course & quiz certificates Card with Search, Filter & Complete Data Table
// - Fully responsive with horizontal table scrolling and PDF preview/printing
// =============================================================================

class PrincipalIssuedCertificatesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalIssuedCertificatesScreen({super.key, this.onBack});

  @override
  State<PrincipalIssuedCertificatesScreen> createState() =>
      _PrincipalIssuedCertificatesScreenState();
}

class _PrincipalIssuedCertificatesScreenState
    extends State<PrincipalIssuedCertificatesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedGrade = "All Grades";

  // Data matching Image 1
  final List<Map<String, dynamic>> _allCertificates = [
    {
      "id": "CIQ-2026-E4A7CF18",
      "student": "Anand Kumar",
      "quiz": "Emerging Technologies — final assessment",
      "dept": "Computer Science & Engineering",
      "marks": "26/30 (87%)",
      "grade": "A+",
      "issued": "21 Oct 2026",
    },
    {
      "id": "CIQ-2026-E1453EBA",
      "student": "Anand Kumar",
      "quiz": "Computer Science & Engineering — Data Structures and Algorithms quiz",
      "dept": "Computer Science & Engineering",
      "marks": "9/10 (90%)",
      "grade": "O",
      "issued": "15 Oct 2026",
    },
    {
      "id": "CIQ-2026-9C6D8BFD",
      "student": "Anand Kumar",
      "quiz": "Computer Science & Engineering — Web Technologies quiz",
      "dept": "Computer Science & Engineering",
      "marks": "8/10 (80%)",
      "grade": "A+",
      "issued": "6 Oct 2026",
    },
    {
      "id": "CIQ-2026-A8B5E350",
      "student": "Anand Kumar",
      "quiz": "Computer Science & Engineering — DBMS quiz",
      "dept": "Computer Science & Engineering",
      "marks": "4/8 (50%)",
      "grade": "C",
      "issued": "6 Oct 2026",
    },
    {
      "id": "CIQ-2026-B2CFB2C3",
      "student": "Divya Ramesh",
      "quiz": "Operating Systems — final assessment",
      "dept": "Computer Science & Engineering",
      "marks": "30/30 (100%)",
      "grade": "O",
      "issued": "5 Oct 2026",
    },
    {
      "id": "CIQ-2026-B1FB8977",
      "student": "Anand Kumar",
      "quiz": "Database Management Systems — final assessment",
      "dept": "Computer Science & Engineering",
      "marks": "4/4 (100%)",
      "grade": "O",
      "issued": "29 Sept 2026",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredCertificates {
    final query = _searchController.text.trim().toLowerCase();
    return _allCertificates.where((cert) {
      final matchesSearch = query.isEmpty ||
          cert["id"]!.toLowerCase().contains(query) ||
          cert["student"]!.toLowerCase().contains(query) ||
          cert["quiz"]!.toLowerCase().contains(query);

      final matchesGrade = _selectedGrade == "All Grades" ||
          _selectedGrade == "All" ||
          cert["grade"] == _selectedGrade.replaceAll("Grade ", "").trim();

      return matchesSearch && matchesGrade;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas matching screenshot
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 950;
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
                const SizedBox(height: 20),

                // 2. 6 STAT KPI CARDS (Image 1: 6, 3, 2, 0, 0, 1)
                _buildKpiCards(isWide),
                const SizedBox(height: 20),

                // 3. MAIN CARD WITH SEARCH, FILTER & CERTIFICATES TABLE (Image 1)
                _buildMainCard(),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER (Exact to Image 1)
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
                  Icons.workspace_premium_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
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
                        Text("Home",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xFF94A3B8))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text("AI Course & Certification",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xFF94A3B8))),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text("Issued Certificates",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges: AI COURSE & CERTIFICATION, MVP
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
                          "AI COURSE & CERTIFICATION",
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

                  // Title + Icon
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
                            Icons.workspace_premium_rounded,
                            color: Color(0xFFFBBF24), // Gold Medal Icon
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
                              "Issued Certificates",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Every certificate issued in your college, with grade, marks and verification status.",
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
  // 2. 6 STAT KPI CARDS (Image 1: 6, 3, 2, 0, 0, 1)
  // ===========================================================================
  Widget _buildKpiCards(bool isWide) {
    final cards = [
      {"label": "Issued", "value": "6"},
      {"label": "Grade O", "value": "3"},
      {"label": "Grade A+", "value": "2"},
      {"label": "Grade A", "value": "0"},
      {"label": "Grade B", "value": "0"},
      {"label": "Grade C", "value": "1"},
    ];

    if (isWide) {
      return Row(
        children: cards
            .map((c) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _buildSingleKpi(c["label"]!, c["value"]!),
                  ),
                ))
            .toList(),
      );
    } else {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: cards
            .map((c) => SizedBox(
                  width: 140,
                  child: _buildSingleKpi(c["label"]!, c["value"]!),
                ))
            .toList(),
      );
    }
  }

  Widget _buildSingleKpi(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. MAIN CARD WITH SEARCH, FILTER & CERTIFICATES TABLE (Image 1)
  // ===========================================================================
  Widget _buildMainCard() {
    final certs = _filteredCertificates;

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header section inside card
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Course & quiz certificates",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Issued automatically when students pass · signed under the Principal's authority · verifiable by QR at /verify",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 16),

                // Search & Filter Row
                Row(
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
                          onChanged: (_) => setState(() {}),
                          style: GoogleFonts.poppins(fontSize: 12.5),
                          decoration: const InputDecoration(
                            hintText: "Search student, quiz or ID",
                            hintStyle: TextStyle(
                                fontSize: 12, color: Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search_rounded,
                                size: 16, color: Color(0xFF94A3B8)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedGrade,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              size: 18, color: Color(0xFF64748B)),
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: const Color(0xFF334155)),
                          items: [
                            "All Grades",
                            "Grade O",
                            "Grade A+",
                            "Grade A",
                            "Grade B",
                            "Grade C"
                          ]
                              .map((g) => DropdownMenuItem(
                                  value: g, child: Text(g)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedGrade = val);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Data Table
          certs.isEmpty
              ? _buildEmptyState()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 800),
                    child: DataTable(
                      headingRowColor:
                          WidgetStateProperty.all(const Color(0xFFFAFAFA)),
                      headingTextStyle: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                      dataRowMinHeight: 52,
                      dataRowMaxHeight: 64,
                      horizontalMargin: 20,
                      columnSpacing: 24,
                      columns: const [
                        DataColumn(label: Text("CERTIFICATE")),
                        DataColumn(label: Text("STUDENT")),
                        DataColumn(label: Text("QUIZ")),
                        DataColumn(label: Text("MARKS")),
                        DataColumn(label: Text("GRADE")),
                        DataColumn(label: Text("ISSUED")),
                      ],
                      rows: certs.map((cert) {
                        return DataRow(
                          onSelectChanged: (_) => _showCertificateDialog(cert),
                          cells: [
                            // 1. Certificate ID (Monospace style)
                            DataCell(
                              Text(
                                cert["id"]!,
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                            ),

                            // 2. Student
                            DataCell(
                              Text(
                                cert["student"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),

                            // 3. Quiz & Department
                            DataCell(
                              Container(
                                constraints: const BoxConstraints(maxWidth: 320),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cert["quiz"]!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF1E293B),
                                      ),
                                    ),
                                    Text(
                                      cert["dept"]!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.5,
                                        color: const Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // 4. Marks
                            DataCell(
                              Text(
                                cert["marks"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ),

                            // 5. Grade Pill
                            DataCell(
                              _buildGradePill(cert["grade"]!),
                            ),

                            // 6. Issued Date
                            DataCell(
                              Text(
                                cert["issued"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Grade pill matching the exact soft warm aesthetic in Image 1
  Widget _buildGradePill(String grade) {
    Color bg = const Color(0xFFFEF3C7);
    Color text = const Color(0xFFB45309);

    if (grade == "O") {
      bg = const Color(0xFFFFF7ED);
      text = const Color(0xFFEA580C);
    } else if (grade == "A+" || grade == "A") {
      bg = const Color(0xFFFEF3C7);
      text = const Color(0xFFD97706);
    } else if (grade == "C") {
      bg = const Color(0xFFFFF1F2);
      text = const Color(0xFFE11D48);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        grade,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: text,
        ),
      ),
    );
  }

  // Blueprint Graph Paper Empty State
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFCBD5E1).withValues(alpha: 0.6),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _LightGridPainter(),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "No certificates matching criteria",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Try adjusting your search query or grade filter.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog to view certificate details & generate/print PDF
  void _showCertificateDialog(Map<String, dynamic> cert) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(Icons.workspace_premium_rounded,
                  color: Color(0xFFD97706), size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Certificate Details",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailRow("Certificate ID", cert["id"]!),
              _detailRow("Recipient", cert["student"]!),
              _detailRow("Course / Quiz", cert["quiz"]!),
              _detailRow("Department", cert["dept"]!),
              _detailRow("Marks Obtained", cert["marks"]!),
              _detailRow("Grade Awarded", cert["grade"]!),
              _detailRow("Issued Date", cert["issued"]!),
              _detailRow("Verification", "https://colossus-iq-new.vercel.app/verify/${cert["id"]}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("Close",
                  style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                Navigator.pop(ctx);
                try {
                  await CertificatePdfService.printOrSavePdf(
                    recipient: cert["student"]!,
                    type: "Course Completion",
                    event: cert["quiz"]!,
                    date: cert["issued"]!,
                    certId: cert["id"]!,
                    citation:
                        "has successfully passed the assessment with grade ${cert["grade"]}.",
                  );
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error opening PDF: $e")),
                    );
                  }
                }
              },
              icon: const Icon(Icons.print_rounded, size: 16, color: Colors.white),
              label: Text("Print / PDF",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label: ",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF475569),
              ),
            ),
            TextSpan(
              text: value,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// GRID PAINTERS
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

class _LightGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.5)
      ..strokeWidth = 0.8;

    const double step = 26.0;

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
