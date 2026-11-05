import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

// =============================================================================
// SKILL GRAPH SCREEN
// Matches Image 4 (media_1793779565592_54b91afa.jpg)
// and Image 5 (media_1793779574925_51a2c918.png)
// =============================================================================

class SkillGraphScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const SkillGraphScreen({super.key, this.onBack});

  static const List<String> _dimensions = [
    "Advanced Java",
    "CS3492",
    "CSE105",
    "CSE101",
    "DBMS",
    "CSE107",
    "CS201",
    "CSE102",
    "python",
    "CSE106",
  ];

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Skill Graph",
      category: "Student Success",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Student Success  ›  Skill Graph",
          category: "STUDENT SUCCESS",
          phase: "Phase 2",
          icon: Icons.hub_outlined,
          title: "Skill Graph",
          subtitle:
              "Every skill you are building — learned, in progress, weak, missing or job-ready.",
          watermarkIcon: Icons.hub_outlined,
        ),
        const SizedBox(height: 20),

        // 2. Middle Section: Radar Chart Card + Dimensions Progress Card
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 960;
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildRadarChartCard()),
                  const SizedBox(width: 20),
                  Expanded(child: _buildDimensionsCard()),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRadarChartCard(),
                  const SizedBox(height: 20),
                  _buildDimensionsCard(),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 20),

        // 3. Bottom Section: Strengths, Gaps, Improvement Plan (Image 5)
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 900;
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildStrengthsCard()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildGapsCard()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildImprovementPlanCard()),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildStrengthsCard(),
                  const SizedBox(height: 16),
                  _buildGapsCard(),
                  const SizedBox(height: 16),
                  _buildImprovementPlanCard(),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Left: Radar Chart Card
  // ---------------------------------------------------------------------------
  Widget _buildRadarChartCard() {
    return Container(
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
            "Target: Computer Science & Engineering Career Benchmark",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "Dimension-level view — no single number decides outcomes",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),

          // Radar Chart Canvas
          SizedBox(
            height: 340,
            width: double.infinity,
            child: CustomPaint(
              painter: _RadarChartPainter(labels: _dimensions),
            ),
          ),
          const SizedBox(height: 16),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendDot(const Color(0xFF1E2865), "Current"),
              const SizedBox(width: 20),
              _buildLegendDot(const Color(0xFFD97706), "Target"),
            ],
          ),
        ],
      ),
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
            fontSize: 12,
            color: const Color(0xFF475569),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Right: Dimensions Card (Progress Bars)
  // ---------------------------------------------------------------------------
  Widget _buildDimensionsCard() {
    return Container(
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
            "Overall 30%",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),

          ..._dimensions.map((dim) => _buildDimensionBarRow(dim)),
        ],
      ),
    );
  }

  Widget _buildDimensionBarRow(String label) {
    const double currentVal = 30.0;
    const double targetVal = 85.0;
    const double maxVal = 100.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              Text(
                "${currentVal.toInt()} / target ${targetVal.toInt()}",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),

          // Horizontal Progress Bar with Target Marker
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Background track
              Container(
                height: 7,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F5EE),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              // Red Progress Fill (30%)
              FractionallySizedBox(
                widthFactor: currentVal / maxVal,
                child: Container(
                  height: 7,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB91C1C),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Card 1: Strengths
  // ---------------------------------------------------------------------------
  Widget _buildStrengthsCard() {
    return Container(
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
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4EA),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0D9488), width: 1.2),
                ),
                child: const Icon(Icons.check, size: 12, color: Color(0xFF0D9488)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Advanced Java: Consistent practice streak (15 days)",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF334155),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Card 2: Gaps
  // ---------------------------------------------------------------------------
  Widget _buildGapsCard() {
    final gaps = [
      "Advanced Java: Core Principles & Architecture (0%)",
      "CS3492: Core Principles & Architecture (0%)",
      "CSE105: Core Principles & Architecture (0%)",
    ];

    return Container(
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
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          ...gaps.map((gap) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFD97706), width: 1.2),
                    ),
                    child: const Icon(Icons.check, size: 12, color: Color(0xFFD97706)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      gap,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
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

  // ---------------------------------------------------------------------------
  // Bottom Card 3: Improvement plan
  // ---------------------------------------------------------------------------
  Widget _buildImprovementPlanCard() {
    final steps = [
      "Complete adaptive revision quiz on Core Principles & Architecture (Advanced Java)",
      "Complete adaptive revision quiz on Core Principles & Architecture (CS3492)",
      "Complete adaptive revision quiz on Core Principles & Architecture (CSE105)",
    ];

    return Container(
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
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          ...steps.asMap().entries.map((entry) {
            final idx = entry.key + 1;
            final text = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
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
                        "$idx",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4338CA),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      text,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
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
}

// -----------------------------------------------------------------------------
// Spider / Radar Chart Painter (10 Axes)
// -----------------------------------------------------------------------------
class _RadarChartPainter extends CustomPainter {
  final List<String> labels;
  const _RadarChartPainter({required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 48;
    final int count = labels.length;
    final double angleStep = (2 * math.pi) / count;

    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final targetPaint = Paint()
      ..color = const Color(0xFFD97706)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final targetFill = Paint()
      ..color = const Color(0xFFFEF3C7).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    final currentPaint = Paint()
      ..color = const Color(0xFF1E2865)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    final currentFill = Paint()
      ..color = const Color(0xFF64748B).withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    // Concentric web rings
    for (int ring = 1; ring <= 4; ring++) {
      final r = radius * (ring / 4);
      final ringPath = Path();
      for (int i = 0; i < count; i++) {
        final angle = (i * angleStep) - (math.pi / 2);
        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);
        if (i == 0) {
          ringPath.moveTo(x, y);
        } else {
          ringPath.lineTo(x, y);
        }
      }
      ringPath.close();
      canvas.drawPath(ringPath, gridPaint);
    }

    // Radial spokes and label text
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i < count; i++) {
      final angle = (i * angleStep) - (math.pi / 2);
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), gridPaint);

      // Label positioning
      final labelR = radius + 18;
      final lx = center.dx + labelR * math.cos(angle);
      final ly = center.dy + labelR * math.sin(angle);

      textPainter.text = TextSpan(
        text: labels[i],
        style: GoogleFonts.poppins(
          fontSize: 9.5,
          color: const Color(0xFF475569),
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();

      final textOffset = Offset(
        lx - (textPainter.width / 2) + (math.cos(angle) * 8),
        ly - (textPainter.height / 2) + (math.sin(angle) * 4),
      );
      textPainter.paint(canvas, textOffset);
    }

    // Target polygon (~0.85 of radius)
    final targetPath = Path();
    for (int i = 0; i < count; i++) {
      final angle = (i * angleStep) - (math.pi / 2);
      final r = radius * 0.85;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        targetPath.moveTo(x, y);
      } else {
        targetPath.lineTo(x, y);
      }
    }
    targetPath.close();
    canvas.drawPath(targetPath, targetFill);
    canvas.drawPath(targetPath, targetPaint);

    // Current polygon (~0.30 of radius)
    final currentPath = Path();
    for (int i = 0; i < count; i++) {
      final angle = (i * angleStep) - (math.pi / 2);
      final r = radius * 0.30;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        currentPath.moveTo(x, y);
      } else {
        currentPath.lineTo(x, y);
      }
    }
    currentPath.close();
    canvas.drawPath(currentPath, currentFill);
    canvas.drawPath(currentPath, currentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

