import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// UNIVERSITY: CURRICULUM STUDIO (FACULTY PORTAL)
// =============================================================================
class CurriculumStudioScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CurriculumStudioScreen({super.key, this.onBack});

  @override
  State<CurriculumStudioScreen> createState() => _CurriculumStudioScreenState();
}

class _CurriculumStudioScreenState extends State<CurriculumStudioScreen> {
  bool _showSampleCurricula = false;

  final List<Map<String, dynamic>> _sampleCurricula = [
    {
      "programme": "B.E. Computer Science & Engineering",
      "regulation": "Regulation 2024 (CBCS)",
      "semesters": "8 Semesters",
      "credits": "165 Total Credits",
      "status": "Active & Published",
      "departments": "CSE & Allied Branches",
    },
    {
      "programme": "B.Tech. Artificial Intelligence & Data Science",
      "regulation": "Regulation 2024 (CBCS)",
      "semesters": "8 Semesters",
      "credits": "165 Total Credits",
      "status": "Active & Published",
      "departments": "AI & DS Department",
    },
    {
      "programme": "B.E. Electronics & Communication Engineering",
      "regulation": "Regulation 2024 (CBCS)",
      "semesters": "8 Semesters",
      "credits": "162 Total Credits",
      "status": "Active & Published",
      "departments": "ECE Department",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
        children: [
          // 1. Top Hero Banner
          _buildHeroBanner(),
          const SizedBox(height: 18),

          // 2. Section Intro Text
          Text(
            "Your university's published curricula. Open a programme to see each course's syllabus, and plan your teaching from it.",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF475569),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),

          // 3. Main Content Panel (Graph Paper Background & Empty State)
          _buildMainPanel(),
        ],
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HERO BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF141A46),
            Color(0xFF1E2865),
            Color(0xFF283685),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141A46).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Background blueprint grid texture
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),

            // Large decorative stack watermark on the right
            Positioned(
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.layers_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),

            // Foreground Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            "Home",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFFC7D2FE),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          "University",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          "Curriculum Studio",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Main Title & Icon row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Layered stack icon rounded box
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2865).withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF3B487A),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.layers_rounded,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Title + Badges + Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A2352),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: const Color(0xFF38467D), width: 1),
                                  ),
                                  child: Text(
                                    "UNIVERSITY",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D9488),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "MVP",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // Main Title
                            Text(
                              "Curriculum Studio",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),

                            // Subtitle description
                            Text(
                              "Prepare programme curricula: semesters, courses, credits, L-T-P, syllabus units and course outcomes, drafted with AI and published to every college.",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFFC7D2FE).withValues(alpha: 0.9),
                                height: 1.35,
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
  // 2. MAIN PANEL (GRAPH PAPER BACKGROUND + EMPTY STATE)
  // ===========================================================================
  Widget _buildMainPanel() {
    return Container(
      constraints: const BoxConstraints(minHeight: 380),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Faint graph paper / grid background
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: const Color(0xFFF1F5F9),
                  step: 24.0,
                ),
              ),
            ),

            // Empty State (Default) or Sample Curricula
            if (!_showSampleCurricula)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No curricula yet",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Your university has not published a curriculum here yet.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 18),
                      OutlinedButton.icon(
                        onPressed: () => setState(() => _showSampleCurricula = true),
                        icon: const Icon(Icons.menu_book_rounded, size: 15),
                        label: const Text("View University Draft Curricula"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF141A46),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          textStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Published University Curricula (3 Programmes)",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () => setState(() => _showSampleCurricula = false),
                          child: Text(
                            "Show Empty State",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ..._sampleCurricula.map((c) {
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
                            const CircleAvatar(
                              backgroundColor: Color(0xFFEEF2FF),
                              child: Icon(Icons.school_rounded, color: Color(0xFF4338CA)),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(c["programme"] as String, style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 2),
                                  Text("${c["regulation"]} · ${c["credits"]} · ${c["semesters"]}", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(6)),
                              child: Text(c["status"] as String, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFF15803D))),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SUBTLE GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;
  const _GridPaperPainter({required this.gridColor, this.step = 28.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor || oldDelegate.step != step;
}
