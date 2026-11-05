import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiStudyTwinScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const AiStudyTwinScreen({super.key, this.onBack});

  @override
  State<AiStudyTwinScreen> createState() => _AiStudyTwinScreenState();
}

class _AiStudyTwinScreenState extends State<AiStudyTwinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, screenConstraints) {
            final isMobile = screenConstraints.maxWidth < 640;
            final isDesktop = screenConstraints.maxWidth >= 960;
            final horizPadding = isMobile ? 14.0 : 24.0;
            final vertPadding = isMobile ? 14.0 : 20.0;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizPadding,
                vertical: vertPadding,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1320),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top Hero Banner
                      _buildHeroBanner(isMobile: isMobile),
                      SizedBox(height: isMobile ? 16 : 24),

                      // Middle Section: Radar Chart (Left) + Dimensions (Right)
                      if (isDesktop)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: _buildRadarChartCard(isMobile: isMobile),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 5,
                              child: _buildDimensionsCard(isMobile: isMobile),
                            ),
                          ],
                        )
                      else ...[
                        _buildRadarChartCard(isMobile: isMobile),
                        const SizedBox(height: 16),
                        _buildDimensionsCard(isMobile: isMobile),
                      ],
                      SizedBox(height: isMobile ? 16 : 20),

                      // Bottom Section: Strengths, Gaps, Improvement Plan
                      if (isDesktop)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildStrengthsCard(isMobile: isMobile)),
                            const SizedBox(width: 20),
                            Expanded(child: _buildGapsCard(isMobile: isMobile)),
                            const SizedBox(width: 20),
                            Expanded(child: _buildImprovementPlanCard(isMobile: isMobile)),
                          ],
                        )
                      else ...[
                        _buildStrengthsCard(isMobile: isMobile),
                        const SizedBox(height: 16),
                        _buildGapsCard(isMobile: isMobile),
                        const SizedBox(height: 16),
                        _buildImprovementPlanCard(isMobile: isMobile),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeroBanner({required bool isMobile}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF131838),
            Color(0xFF1B2358),
            Color(0xFF232D6E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B2358).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        child: Stack(
          children: [
            // Grid background pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _TwinGridPainter(),
              ),
            ),

            // Giant brain watermark on bottom right
            Positioned(
              right: -10,
              bottom: -20,
              child: Icon(
                Icons.psychology_rounded,
                size: isMobile ? 110 : 155,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),

            // Banner content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 28,
                vertical: isMobile ? 18 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb row (horizontal scroll to prevent overflow)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (widget.onBack != null || Navigator.canPop(context)) ...[
                          InkWell(
                            onTap: widget.onBack ?? () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(6),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 13,
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        ],
                        Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            "›",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                        Text(
                          "Student Success",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            "›",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                        Text(
                          "AI Study Twin",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 14 : 18),

                  // Hero Title & Badges
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Brain icon badge
                      Container(
                        width: isMobile ? 44 : 50,
                        height: isMobile ? 44 : 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1.2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.psychology_rounded,
                            size: isMobile ? 22 : 26,
                            color: const Color(0xFFFBBF24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Text column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.14),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "STUDENT SUCCESS",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Phase 2",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "AI Study Twin",
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 21 : 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "How you learn best — pace, strong and weak subjects, revision behaviour — adapted over time.",
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 12 : 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.82),
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

  Widget _buildRadarChartCard({required bool isMobile}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 14 : 18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AI Study Twin — Anand Kumar's Learning Dynamics",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 13.5 : 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Dimension-level view — no single number decides outcomes",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 11.5 : 12,
              color: const Color(0xFF64748B),
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),

          // Fully responsive Radar Chart container
          LayoutBuilder(
            builder: (context, constraints) {
              final double cardWidth = constraints.maxWidth;
              final double chartHeight = (cardWidth * 0.72).clamp(200.0, 270.0);

              return Center(
                child: SizedBox(
                  width: cardWidth,
                  height: chartHeight,
                  child: CustomPaint(
                    painter: _SpiderRadarPainter(isMobile: isMobile),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E286D),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "Current",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF475569),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 8,
                height: 8,
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
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFD97706),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionsCard({required bool isMobile}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 14 : 18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dimensions",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Overall 0%",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          SizedBox(height: isMobile ? 16 : 22),

          _dimensionSliderItem("Learning pace", 0, 80),
          _dimensionSliderItem("Retention rate (7-day)", 0, 75),
          _dimensionSliderItem("Practice consistency", 0, 80),
          _dimensionSliderItem("Revision discipline", 0, 75),
          _dimensionSliderItem("Focus duration", 0, 80, isLast: true),
        ],
      ),
    );
  }

  Widget _dimensionSliderItem(
    String label,
    int current,
    int target, {
    bool isLast = false,
  }) {
    final double targetFraction = target / 100.0;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "$current / target $target",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Slider track with target notch marker
          LayoutBuilder(
            builder: (context, constraints) {
              final double trackWidth = constraints.maxWidth;
              final double notchPosition =
                  (trackWidth * targetFraction).clamp(0, trackWidth);

              return SizedBox(
                height: 14,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // Base horizontal track
                    Container(
                      height: 5,
                      width: trackWidth,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    // Target notch marker line
                    Positioned(
                      left: (notchPosition - 1.25).clamp(0, trackWidth - 2.5),
                      child: Container(
                        width: 2.5,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF334155),
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStrengthsCard({required bool isMobile}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 14 : 18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Strengths",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),

          _strengthBullet(
            "Study twin initialized for current academic curriculum",
          ),
          const SizedBox(height: 14),
          _strengthBullet(
            "Optimal focus windows mapped to standard timetable",
          ),
          const SizedBox(height: 14),
          _strengthBullet(
            "Cognitive model ready to calibrate with your first study session",
          ),
        ],
      ),
    );
  }

  Widget _strengthBullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle_outline_rounded,
          size: 16,
          color: Color(0xFF10B981),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              height: 1.45,
              color: const Color(0xFF334155),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGapsCard({required bool isMobile}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 14 : 18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gaps",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                size: 16,
                color: Color(0xFFD97706),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Awaiting initial learning session telemetry to measure retention curve",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    height: 1.45,
                    color: const Color(0xFF334155),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImprovementPlanCard({required bool isMobile}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 14 : 18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Improvement plan",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),

          _planStep("1",
              "Utilize 25-minute Pomodoro focus blocks with formula flashcards"),
          const SizedBox(height: 14),
          _planStep("2",
              "Schedule Sunday morning 30-minute spaced revision for lowest-mastery units"),
          const SizedBox(height: 14),
          _planStep("3",
              "Practice 5 adaptive quiz questions immediately after each class"),
        ],
      ),
    );
  }

  Widget _planStep(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2563EB),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              height: 1.45,
              color: const Color(0xFF334155),
            ),
          ),
        ),
      ],
    );
  }
}

class _TwinGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1;

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

class _SpiderRadarPainter extends CustomPainter {
  final bool isMobile;

  final List<String> labels = const [
    "Learning pace",
    "Retention rate (7-day)",
    "Practice consistency",
    "Revision discipline",
    "Focus duration",
  ];

  final List<double> targetValues = const [0.80, 0.75, 0.80, 0.75, 0.80];

  _SpiderRadarPainter({this.isMobile = false});

  @override
  void paint(Canvas canvas, Size size) {
    // Dynamically calculate radius so labels NEVER clip on left or right
    final double radius = math.min(size.width * 0.24, size.height * 0.36);
    final center = Offset(size.width / 2, size.height / 2 + 5);

    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final axisPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw 5 concentric pentagon grid rings
    const int levels = 5;
    for (int lvl = 1; lvl <= levels; lvl++) {
      final r = radius * (lvl / levels);
      final path = Path();
      for (int i = 0; i < 5; i++) {
        final angle = -math.pi / 2 + i * (2 * math.pi / 5);
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

    // Draw 5 axis lines from center to outer vertices
    for (int i = 0; i < 5; i++) {
      final angle = -math.pi / 2 + i * (2 * math.pi / 5);
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), axisPaint);
    }

    // Draw Target Polygon (amber filled)
    final targetPath = Path();
    for (int i = 0; i < 5; i++) {
      final angle = -math.pi / 2 + i * (2 * math.pi / 5);
      final r = radius * targetValues[i];
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        targetPath.moveTo(x, y);
      } else {
        targetPath.lineTo(x, y);
      }
    }
    targetPath.close();

    final targetFillPaint = Paint()
      ..color = const Color(0xFFFDE68A).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;
    canvas.drawPath(targetPath, targetFillPaint);

    final targetStrokePaint = Paint()
      ..color = const Color(0xFFD97706)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    canvas.drawPath(targetPath, targetStrokePaint);

    // Draw Labels around the pentagon
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final double fontSize = isMobile ? 9.5 : 10.5;

    for (int i = 0; i < 5; i++) {
      final angle = -math.pi / 2 + i * (2 * math.pi / 5);
      final double labelDist = radius + (isMobile ? 12 : 16);
      double lx = center.dx + labelDist * math.cos(angle);
      double ly = center.dy + labelDist * math.sin(angle);

      textPainter.text = TextSpan(
        text: labels[i],
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          color: const Color(0xFF475569),
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();

      // Adjust alignment based on angle position
      if (i == 0) {
        // Top
        lx -= textPainter.width / 2;
        ly -= textPainter.height;
      } else if (i == 1) {
        // Top-Right
        lx += 2;
        ly -= textPainter.height / 2;
      } else if (i == 2) {
        // Bottom-Right
        lx += 2;
      } else if (i == 3) {
        // Bottom-Left
        lx -= textPainter.width + 2;
      } else if (i == 4) {
        // Top-Left
        lx -= textPainter.width + 2;
        ly -= textPainter.height / 2;
      }

      // Clamp label horizontally inside canvas bounds
      lx = lx.clamp(2.0, size.width - textPainter.width - 2.0);

      textPainter.paint(canvas, Offset(lx, ly));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
