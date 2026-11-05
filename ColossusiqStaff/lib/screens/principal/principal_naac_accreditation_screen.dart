import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalNaacAccreditationScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalNaacAccreditationScreen({super.key, this.onBack});

  @override
  State<PrincipalNaacAccreditationScreen> createState() =>
      _PrincipalNaacAccreditationScreenState();
}

class _PrincipalNaacAccreditationScreenState
    extends State<PrincipalNaacAccreditationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 950;
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

                // 2. RADAR CHART & DIMENSIONS PROGRESS BARS
                _buildTopVisualSection(isDesktop),
                const SizedBox(height: 20),

                // 3. BOTTOM THREE CARDS (STRENGTHS, GAPS, IMPROVEMENT PLAN)
                _buildBottomCardsSection(constraints.maxWidth),
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
                  Icons.settings_suggest_rounded,
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
                          "NAAC Accreditation Readiness",
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

                  // Title block with Icon & badges
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
                            Icons.settings_suggest_rounded,
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
                              "NAAC Accreditation Readiness",
                              style: GoogleFonts.poppins(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Seven NAAC criteria scored against evidence collected across the college.",
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
  // 2. RADAR CHART & DIMENSIONS PROGRESS BARS
  // ===========================================================================
  Widget _buildTopVisualSection(bool isDesktop) {
    // 1. Radar Chart Card
    final radarCard = Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "NAAC readiness — seven criteria, 1 of 7 at target",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Dimension-level view — no single number decides outcomes",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),

          // Custom Radar Chart Canvas
          SizedBox(
            height: 340,
            width: double.infinity,
            child: CustomPaint(
              painter: _NaacRadarChartPainter(),
            ),
          ),
          const SizedBox(height: 12),

          // Legend (Current & Target)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E293B),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "Current",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(width: 18),
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFFD97706),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "Target",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFD97706),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // 2. Dimensions Progress Bars Card
    final dimensionsCard = Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dimensions",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Overall 38%",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          // 7 Dimensions
          _buildDimensionRow(
            label: "C1 Curricular aspects",
            current: 45,
            target: 80,
            color: const Color(0xFFB45309), // Amber/brown
          ),
          const SizedBox(height: 14),
          _buildDimensionRow(
            label: "C2 Teaching-learning & evaluation",
            current: 100,
            target: 80,
            color: const Color(0xFF0F766E), // Teal/green
          ),
          const SizedBox(height: 14),
          _buildDimensionRow(
            label: "C3 Research, innovation & extension",
            current: 55,
            target: 75,
            color: const Color(0xFF1E293B), // Navy/Slate
          ),
          const SizedBox(height: 14),
          _buildDimensionRow(
            label: "C4 Infrastructure & learning resources",
            current: 0,
            target: 75,
            color: const Color(0xFF1E293B),
          ),
          const SizedBox(height: 14),
          _buildDimensionRow(
            label: "C5 Student support & progression",
            current: 64,
            target: 75,
            color: const Color(0xFF1E293B),
          ),
          const SizedBox(height: 14),
          _buildDimensionRow(
            label: "C6 Governance & leadership",
            current: 0,
            target: 75,
            color: const Color(0xFF1E293B),
          ),
          const SizedBox(height: 14),
          _buildDimensionRow(
            label: "C7 Institutional values & best practices",
            current: 0,
            target: 75,
            color: const Color(0xFF1E293B),
          ),
        ],
      ),
    );

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: radarCard),
          const SizedBox(width: 18),
          Expanded(flex: 5, child: dimensionsCard),
        ],
      );
    }

    return Column(
      children: [
        radarCard,
        const SizedBox(height: 18),
        dimensionsCard,
      ],
    );
  }

  Widget _buildDimensionRow({
    required String label,
    required int current,
    required int target,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "$current / target $target",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF475569),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final targetFraction = (target / 100.0).clamp(0.0, 1.0);
            final currentFraction = (current / 100.0).clamp(0.0, 1.0);

            return Stack(
              clipBehavior: Clip.none,
              children: [
                // Background Track
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                // Filled progress
                if (currentFraction > 0)
                  Container(
                    height: 6,
                    width: w * currentFraction,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                // Target vertical indicator mark
                Positioned(
                  left: (w * targetFraction) - 1,
                  top: -3,
                  bottom: -3,
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // 3. BOTTOM THREE CARDS (Strengths, Gaps, Improvement plan)
  // ===========================================================================
  Widget _buildBottomCardsSection(double maxWidth) {
    // 1. Strengths
    final strengthsCard = Container(
      padding: const EdgeInsets.all(20),
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
          Text(
            "Strengths",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  size: 17,
                  color: Color(0xFF0D9488),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "C2 Teaching-learning & evaluation: 100% of courses have an assigned faculty; student-teacher ratio 1:7.0; 2 of 2 teaching staff hold a doctorate.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF475569),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // 2. Gaps
    final gapsCard = Container(
      padding: const EdgeInsets.all(20),
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
          Text(
            "Gaps",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 17,
                  color: Color(0xFFD97706),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "C4 Infrastructure & learning resources (0 of 75): 0 of 3 departments run practical or laboratory courses; 0 approved documents in the Knowledge Base.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF475569),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 17,
                  color: Color(0xFFD97706),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "C6 Governance & leadership (0 of 75): IQAC not recorded; 0 of 6 statutory bodies constituted; 0 of 9 compliance actions resolved.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF475569),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // 3. Improvement plan
    final improvementPlanCard = Container(
      padding: const EdgeInsets.all(20),
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
          Text(
            "Improvement plan",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFFEEF2FF),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "1",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF283685),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Register practical courses for the departments without one and approve handbooks and syllabi in the Knowledge Base.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF475569),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFFEEF2FF),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "2",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF283685),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Record the IQAC and the other statutory committees (with certified minutes) on the AICTE Compliance page and close open actions.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF475569),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (maxWidth >= 1050) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: strengthsCard),
          const SizedBox(width: 16),
          Expanded(child: gapsCard),
          const SizedBox(width: 16),
          Expanded(child: improvementPlanCard),
        ],
      );
    }

    return Column(
      children: [
        strengthsCard,
        const SizedBox(height: 16),
        gapsCard,
        const SizedBox(height: 16),
        improvementPlanCard,
      ],
    );
  }
}

// =============================================================================
// NAAC RADAR / SPIDER CHART PAINTER
// =============================================================================
class _NaacRadarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Responsive radius that guarantees 70-100px margins on left/right for labels
    final maxRadius = math.min(size.width * 0.25, size.height * 0.32).clamp(50.0, 95.0);

    const numAxes = 7;
    // Labels for each axis matching Image 5 with clean line breaks
    final labels = [
      "C1 Curricular\naspects",
      "C2 Teaching-learning\n& evaluation",
      "C3 Research,\ninnovation & ext.",
      "C4 Infrastructure &\nlearning resources",
      "C5 Student support\n& progression",
      "C6 Governance &\nleadership",
      "C7 Institutional\nvalues & practices",
    ];

    // Data fractions (out of 100)
    // C1: 45, C2: 100, C3: 55, C4: 0, C5: 64, C6: 0, C7: 0
    final currentValues = [0.45, 1.0, 0.55, 0.0, 0.64, 0.0, 0.0];
    // Targets: C1: 80, C2: 80, C3: 75, C4: 75, C5: 75, C6: 75, C7: 75
    final targetValues = [0.80, 0.80, 0.75, 0.75, 0.75, 0.75, 0.75];

    // Angles for the 7 vertices (starting from -pi / 2 for Top)
    final angles = List.generate(
      numAxes,
      (i) => -math.pi / 2 + (i * 2 * math.pi / numAxes),
    );

    // 1. Draw concentric regular 7-sided polygons (grid)
    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const levels = [0.25, 0.5, 0.75, 1.0];
    for (final level in levels) {
      final polyPath = Path();
      for (int i = 0; i < numAxes; i++) {
        final r = maxRadius * level;
        final x = center.dx + r * math.cos(angles[i]);
        final y = center.dy + r * math.sin(angles[i]);
        if (i == 0) {
          polyPath.moveTo(x, y);
        } else {
          polyPath.lineTo(x, y);
        }
      }
      polyPath.close();
      canvas.drawPath(polyPath, gridPaint);
    }

    // 2. Draw radial axis lines from center to outer points
    final axisPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1.0;

    for (int i = 0; i < numAxes; i++) {
      final x = center.dx + maxRadius * math.cos(angles[i]);
      final y = center.dy + maxRadius * math.sin(angles[i]);
      canvas.drawLine(center, Offset(x, y), axisPaint);
    }

    // 3. Draw Target Polygon (Gold fill & outline)
    final targetPath = Path();
    for (int i = 0; i < numAxes; i++) {
      final r = maxRadius * targetValues[i];
      final x = center.dx + r * math.cos(angles[i]);
      final y = center.dy + r * math.sin(angles[i]);
      if (i == 0) {
        targetPath.moveTo(x, y);
      } else {
        targetPath.lineTo(x, y);
      }
    }
    targetPath.close();

    final targetFillPaint = Paint()
      ..color = const Color(0xFFFEF08A).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;
    final targetStrokePaint = Paint()
      ..color = const Color(0xFFEAB308)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawPath(targetPath, targetFillPaint);
    canvas.drawPath(targetPath, targetStrokePaint);

    // 4. Draw Current Polygon (Navy fill & outline)
    final currentPath = Path();
    for (int i = 0; i < numAxes; i++) {
      final r = maxRadius * currentValues[i];
      final x = center.dx + r * math.cos(angles[i]);
      final y = center.dy + r * math.sin(angles[i]);
      if (i == 0) {
        currentPath.moveTo(x, y);
      } else {
        currentPath.lineTo(x, y);
      }
    }
    currentPath.close();

    final currentFillPaint = Paint()
      ..color = const Color(0xFF1E293B).withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;
    final currentStrokePaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    canvas.drawPath(currentPath, currentFillPaint);
    canvas.drawPath(currentPath, currentStrokePaint);

    // 5. Draw Axis Labels around periphery with boundary clamping
    final labelStyle = GoogleFonts.poppins(
      fontSize: 8.8,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF475569),
      height: 1.25,
    );

    final maxLabelWidth = (size.width < 420) ? 75.0 : 100.0;

    for (int i = 0; i < numAxes; i++) {
      final labelR = maxRadius + 8;
      final lx = center.dx + labelR * math.cos(angles[i]);
      final ly = center.dy + labelR * math.sin(angles[i]);

      final tp = TextPainter(
        text: TextSpan(text: labels[i], style: labelStyle),
        textAlign: (i == 0)
            ? TextAlign.center
            : (i == 1 || i == 2 || i == 3)
                ? TextAlign.left
                : TextAlign.right,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: maxLabelWidth);

      // Adjust text offset according to angle quadrant with safe margin clamping
      double offsetX;
      double offsetY = (ly - tp.height / 2).clamp(4.0, size.height - tp.height - 4.0);

      if (i == 0) {
        // Top
        offsetX = (lx - tp.width / 2).clamp(4.0, size.width - tp.width - 4.0);
        offsetY = (ly - tp.height - 4).clamp(2.0, size.height - tp.height - 2.0);
      } else if (i == 1 || i == 2 || i == 3) {
        // Right side
        offsetX = (lx + 6).clamp(4.0, size.width - tp.width - 4.0);
      } else {
        // Left side (i == 4, 5, 6)
        offsetX = (lx - tp.width - 6).clamp(4.0, size.width - tp.width - 4.0);
      }

      tp.paint(canvas, Offset(offsetX, offsetY));
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
