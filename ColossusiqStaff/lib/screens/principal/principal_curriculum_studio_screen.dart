import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PRINCIPAL: UNIVERSITY CURRICULUM STUDIO (Matches Image 5)
// - Blueprint Hero Banner: "Home > University > Curriculum Studio", badges UNIVERSITY, MVP
// - Golden Layered Stack Icon in rounded box
// - Title: "Curriculum Studio"
// - Subtitle: "Prepare programme curricula: semesters, courses, credits, L-T-P, syllabus units and course outcomes, drafted with AI and published to every college."
// - Explanatory subtext: "Your university's published curricula. Open a programme to see each course's syllabus, and plan your teaching from it."
// - Right/Main Panel: Technical blueprint graph paper grid background with centered empty state ("No curricula yet")
// =============================================================================

class PrincipalCurriculumStudioScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalCurriculumStudioScreen({super.key, this.onBack});

  @override
  State<PrincipalCurriculumStudioScreen> createState() =>
      _PrincipalCurriculumStudioScreenState();
}

class _PrincipalCurriculumStudioScreenState
    extends State<PrincipalCurriculumStudioScreen> {
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
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas matching screenshot
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizPadding = constraints.maxWidth >= 1100
              ? 32.0
              : constraints.maxWidth >= 600
                  ? 20.0
                  : 14.0;

          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(horizPadding, 20, horizPadding, 90),
            children: [
              // 1. TOP HERO BANNER (Image 5)
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. SECTION INTRO TEXT (Image 5)
              Text(
                "Your university's published curricula. Open a programme to see each course's syllabus, and plan your teaching from it.",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: const Color(0xFF475569),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16),

              // 3. MAIN PANEL: BLUEPRINT GRID BACKGROUND & EMPTY STATE (Image 5)
              _buildMainPanel(),
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HERO BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF131B4D), // Deep Royal Navy
            Color(0xFF1D2866),
            Color(0xFF283685),
          ],
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
            // Blueprint Grid Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),

            // Large decorative stack watermark on right
            Positioned(
              right: 16,
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
                  // Breadcrumbs row
                  Row(
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
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
                      ),
                      Text(
                        "University",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
                      ),
                      Text(
                        "Curriculum Studio",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Badges: UNIVERSITY, MVP
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          "UNIVERSITY",
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
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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

                  // Main Title & Icon row
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
                            Icons.layers_rounded,
                            color: Color(0xFFFBBF24), // Yellow Stack Icon
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
                              "Curriculum Studio",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Prepare programme curricula: semesters, courses, credits, L-T-P, syllabus units and course outcomes, drafted with AI and published to every college.",
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
  // 3. MAIN CONTENT PANEL (Graph Paper Background & Empty State)
  // ===========================================================================
  Widget _buildMainPanel() {
    return Container(
      width: double.infinity,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            // Technical Blueprint Grid Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _LightGridPainter(),
              ),
            ),

            // Dashed outline inner box
            Padding(
              padding: const EdgeInsets.all(18),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFCBD5E1).withValues(alpha: 0.6),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "No curricula yet",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
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

                    // Interactive toggle button
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _showSampleCurricula = !_showSampleCurricula;
                        });
                      },
                      icon: Icon(
                        _showSampleCurricula ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined,
                        size: 16,
                        color: const Color(0xFF1E2865),
                      ),
                      label: Text(
                        _showSampleCurricula ? "Hide Curricula Sample" : "Preview Autonomous Curricula",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E2865),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF1E2865)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),

                    if (_showSampleCurricula) ...[
                      const SizedBox(height: 20),
                      ..._sampleCurricula.map((c) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.school_outlined, color: Color(0xFF2563EB), size: 18),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      c["programme"]!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    Text(
                                      "${c["regulation"]} · ${c["credits"]} · ${c["departments"]}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCFCE7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  c["status"]!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF16A34A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ],
                ),
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
