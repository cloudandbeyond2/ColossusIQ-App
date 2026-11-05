import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INCUBATION HEAD: FUNDING READINESS SCREEN (Matches Image 4)
// - Blueprint Hero Banner: "Home > Incubation > Funding Readiness", badges INCUBATION, Phase 3
// - Top Section:
//   * Left Card: "AgriSoil Sense", Radar / Spider Chart with 6 axes (Team, Problem validation, Product, Traction, Business model, Pitch)
//     Two polygons: Current (navy) and Target (amber) + Legend
//   * Right Card: "Dimensions", "Overall 61%", 6 horizontal metric bars with target tick markers
// - Bottom Section (3 Cards):
//   * Strengths: Well-validated problem, Complementary founding team
//   * Gaps: No paying pilots yet, Unit economics unproven
//   * Improvement plan: 1. Run paid pilot with one FPO, 2. Refine cost model, 3. Mentor pitch rehearsal
// =============================================================================

class FundingReadinessScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const FundingReadinessScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 960;
          final isMedium = constraints.maxWidth >= 720;
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
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. TOP SECTION: Radar Chart Card + Dimensions Card (Image 4)
                if (isDesktop)
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 5, child: _buildRadarCard()),
                        const SizedBox(width: 16),
                        Expanded(flex: 5, child: _buildDimensionsCard()),
                      ],
                    ),
                  )
                else
                  Column(
                    children: [
                      _buildRadarCard(),
                      const SizedBox(height: 16),
                      _buildDimensionsCard(),
                    ],
                  ),
                const SizedBox(height: 20),

                // 3. BOTTOM SECTION: Strengths, Gaps, Improvement plan (Image 4)
                _buildBottomCards(isMedium, isDesktop),
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
        gradient: const LinearGradient(
          colors: [Color(0xFF131B4D), Color(0xFF1D2866), Color(0xFF273680)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Technical Blueprint Grid Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),

            // Coins watermark on right (Image 4)
            Positioned(
              right: 18,
              top: 6,
              bottom: 6,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.monetization_on_rounded,
                  size: 96,
                  color: Colors.white,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs & Back (Scrollable on small devices)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        if (onBack != null) ...[
                          InkWell(
                            onTap: onBack,
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
                          'Home',
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
                          'Incubation',
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
                          'Funding Readiness',
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

                  // Badges: INCUBATION, Phase 3
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
                          'INCUBATION',
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
                          'Phase 3',
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

                  // Icon + Title & Subtitle
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
                        child: const Icon(
                          Icons.monetization_on_rounded,
                          color: Color(0xFFFBBF24), // Gold Coins (Image 4)
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Funding Readiness',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Team, traction, product and pitch readiness per venture.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
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
  // 2. RADAR / SPIDER CHART CARD (Image 4)
  // ===========================================================================
  Widget _buildRadarCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 360;
        final cardPadding = isNarrow ? 16.0 : 22.0;

        return Container(
          padding: EdgeInsets.all(cardPadding),
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
                'AgriSoil Sense',
                style: GoogleFonts.poppins(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Dimension-level view — no single number decides outcomes',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 18),

              // Spider / Radar Chart (Responsive)
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: CustomPaint(
                    painter: _RadarChartPainter(),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Legend (Image 4)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendDot(const Color(0xFF1E2865), 'Current'),
                  const SizedBox(width: 16),
                  _buildLegendDot(const Color(0xFFD97706), 'Target'),
                ],
              ),
            ],
          ),
        );
      },
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
            fontWeight: FontWeight.w500,
            color: const Color(0xFF334155),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 3. DIMENSIONS METRIC CARD (Image 4)
  // ===========================================================================
  Widget _buildDimensionsCard() {
    final dimensions = [
      {
        'title': 'Team',
        'current': 72,
        'target': 75,
        'color': const Color(0xFF1E2865),
      },
      {
        'title': 'Problem validation',
        'current': 81,
        'target': 75,
        'color': const Color(0xFF0D9488), // Teal (Target exceeded!)
      },
      {
        'title': 'Product',
        'current': 55,
        'target': 70,
        'color': const Color(0xFF1E2865),
      },
      {
        'title': 'Traction',
        'current': 30,
        'target': 60,
        'color': const Color(0xFFDC2626), // Red (Bottleneck in Image 4!)
      },
      {
        'title': 'Business model',
        'current': 60,
        'target': 70,
        'color': const Color(0xFF1E2865),
      },
      {
        'title': 'Pitch',
        'current': 66,
        'target': 75,
        'color': const Color(0xFF1E2865),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(22),
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
            'Dimensions',
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Overall 61%',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          // 6 Dimension Progress Bars with Target Tick
          ...dimensions.map((d) {
            final current = d['current'] as int;
            final target = d['target'] as int;
            final barColor = d['color'] as Color;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        d['title'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      Text(
                        '$current / target $target',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Progress track with target tick mark
                  SizedBox(
                    height: 8,
                    child: Stack(
                      children: [
                        // Background track
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),

                        // Current filled bar
                        FractionallySizedBox(
                          widthFactor: (current / 100).clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: barColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),

                        // Target notch tick line (Image 4)
                        Align(
                          alignment: Alignment(-1.0 + (target / 100) * 2.0, 0),
                          child: Container(
                            width: 2,
                            height: 12,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
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

  // ===========================================================================
  // 4. BOTTOM SECTION: Strengths, Gaps, Improvement plan (Image 4)
  // ===========================================================================
  Widget _buildBottomCards(bool isMedium, bool isDesktop) {
    final strengthsCard = _buildCardContainer(
      title: 'Strengths',
      children: [
        _buildBulletItem(
          icon: Icons.check_circle_outline_rounded,
          iconColor: const Color(0xFF0D9488),
          text: 'Well-validated problem',
        ),
        const SizedBox(height: 10),
        _buildBulletItem(
          icon: Icons.check_circle_outline_rounded,
          iconColor: const Color(0xFF0D9488),
          text: 'Complementary founding team',
        ),
      ],
    );

    final gapsCard = _buildCardContainer(
      title: 'Gaps',
      children: [
        _buildBulletItem(
          icon: Icons.adjust_rounded,
          iconColor: const Color(0xFFD97706),
          text: 'No paying pilots yet',
        ),
        const SizedBox(height: 10),
        _buildBulletItem(
          icon: Icons.adjust_rounded,
          iconColor: const Color(0xFFD97706),
          text: 'Unit economics unproven',
        ),
      ],
    );

    final planCard = _buildCardContainer(
      title: 'Improvement plan',
      children: [
        _buildNumberedItem('1', 'Run paid pilot with one FPO'),
        const SizedBox(height: 10),
        _buildNumberedItem('2', 'Refine cost model'),
        const SizedBox(height: 10),
        _buildNumberedItem('3', 'Mentor pitch rehearsal'),
      ],
    );

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: strengthsCard),
          const SizedBox(width: 16),
          Expanded(child: gapsCard),
          const SizedBox(width: 16),
          Expanded(child: planCard),
        ],
      );
    } else if (isMedium) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: strengthsCard),
              const SizedBox(width: 16),
              Expanded(child: gapsCard),
            ],
          ),
          const SizedBox(height: 16),
          planCard,
        ],
      );
    } else {
      return Column(
        children: [
          strengthsCard,
          const SizedBox(height: 14),
          gapsCard,
          const SizedBox(height: 14),
          planCard,
        ],
      );
    }
  }

  Widget _buildCardContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
            title,
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _buildBulletItem({
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF334155),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberedItem(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF475569),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF334155),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// RADAR / SPIDER CHART PAINTER (Image 4)
// =============================================================================

class _RadarChartPainter extends CustomPainter {
  final List<String> labels = const [
    'Team',
    'Problem validation',
    'Product',
    'Traction',
    'Business model',
    'Pitch',
  ];

  // Current values: Team 72, Problem 81, Product 55, Traction 30, Model 60, Pitch 66
  final List<double> currentValues = const [0.72, 0.81, 0.55, 0.30, 0.60, 0.66];

  // Target values: Team 75, Problem 75, Product 70, Traction 60, Model 70, Pitch 75
  final List<double> targetValues = const [0.75, 0.75, 0.70, 0.60, 0.70, 0.75];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final isCompact = size.width < 330;
    final horizontalMargin = isCompact ? 68.0 : 78.0;
    final verticalMargin = isCompact ? 16.0 : 20.0;

    final maxRadius = math.min(
      (size.width / 2 - horizontalMargin) / 0.866,
      size.height / 2 - verticalMargin - 12,
    ).clamp(42.0, 100.0);

    const int numAxes = 6;
    const double angleStep = (2 * math.pi) / numAxes;

    // 1. Draw concentric hexagon webs
    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int level = 1; level <= 3; level++) {
      final r = maxRadius * (level / 3.0);
      final path = Path();
      for (int i = 0; i < numAxes; i++) {
        final angle = -math.pi / 2 + i * angleStep;
        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // 2. Draw spokes to vertices
    for (int i = 0; i < numAxes; i++) {
      final angle = -math.pi / 2 + i * angleStep;
      final x = center.dx + maxRadius * math.cos(angle);
      final y = center.dy + maxRadius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), gridPaint);
    }

    // 3. Draw Target Polygon (Amber fill & stroke)
    final targetPath = Path();
    for (int i = 0; i < numAxes; i++) {
      final angle = -math.pi / 2 + i * angleStep;
      final r = maxRadius * targetValues[i];
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        targetPath.moveTo(x, y);
      } else {
        targetPath.lineTo(x, y);
      }
    }
    targetPath.close();

    final targetFill = Paint()
      ..color = const Color(0xFFFEF3C7).withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    final targetStroke = Paint()
      ..color = const Color(0xFFD97706)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    canvas.drawPath(targetPath, targetFill);
    canvas.drawPath(targetPath, targetStroke);

    // 4. Draw Current Polygon (Navy stroke & faint fill)
    final currentPath = Path();
    for (int i = 0; i < numAxes; i++) {
      final angle = -math.pi / 2 + i * angleStep;
      final r = maxRadius * currentValues[i];
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        currentPath.moveTo(x, y);
      } else {
        currentPath.lineTo(x, y);
      }
    }
    currentPath.close();

    final currentFill = Paint()
      ..color = const Color(0xFF1E2865).withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;
    final currentStroke = Paint()
      ..color = const Color(0xFF1E2865)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    canvas.drawPath(currentPath, currentFill);
    canvas.drawPath(currentPath, currentStroke);

    // 5. Draw Labels around the polygon
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i < numAxes; i++) {
      final angle = -math.pi / 2 + i * angleStep;
      final labelRadius = maxRadius + (isCompact ? 8 : 10);
      final x = center.dx + labelRadius * math.cos(angle);
      final y = center.dy + labelRadius * math.sin(angle);

      textPainter.text = TextSpan(
        text: labels[i],
        style: GoogleFonts.poppins(
          fontSize: isCompact ? 9.5 : 10.5,
          color: const Color(0xFF64748B),
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();

      // Offset alignment according to angle position
      double xOffset = -textPainter.width / 2;
      double yOffset = -textPainter.height / 2;

      if (math.cos(angle) > 0.3) {
        xOffset = 2; // Right side
      } else if (math.cos(angle) < -0.3) {
        xOffset = -textPainter.width - 2; // Left side
      }

      if (math.sin(angle) > 0.3) {
        yOffset = 2; // Bottom
      } else if (math.sin(angle) < -0.3) {
        yOffset = -textPainter.height - 2; // Top
      }

      textPainter.paint(canvas, Offset(x + xOffset, y + yOffset));
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
