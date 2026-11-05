import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

// =============================================================================
// STUDENT: ACADEMIC TRACKER SCREEN
// Matches Image 3 (media_1793779519499_30578a73.jpg)
// =============================================================================

class AcademicTrackerScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const AcademicTrackerScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Academic Tracker",
      category: "Student Success",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Student Success  ›  Academic Tracker",
          category: "STUDENT SUCCESS",
          phase: "MVP",
          isMvp: true,
          icon: Icons.analytics_rounded,
          title: "Academic Tracker",
          subtitle: "Semester progress, internal marks, attendance and subject-wise performance.",
          watermarkIcon: Icons.trending_up_rounded,
        ),
        const SizedBox(height: 20),

        // 2. 4 Top Metric KPI Cards
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      label: "CGPA",
                      value: "1.66",
                      pillText: "Rank in CS&E-A",
                      icon: Icons.article_outlined,
                      iconBg: const Color(0xFFE0F2FE),
                      iconColor: const Color(0xFF0284C7),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMetricCard(
                      label: "Attendance",
                      value: "88%",
                      pillText: "Exam eligible",
                      icon: Icons.schedule_rounded,
                      iconBg: const Color(0xFFDCFCE7),
                      iconColor: const Color(0xFF16A34A),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMetricCard(
                      label: "Internal avg.",
                      value: "5%",
                      pillText: "+4% from IA-1",
                      icon: Icons.show_chart_rounded,
                      iconBg: const Color(0xFFF3E8FF),
                      iconColor: const Color(0xFF9333EA),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMetricCard(
                      label: "Credits earned",
                      value: "34 / 35",
                      pillText: "On track",
                      icon: Icons.menu_book_outlined,
                      iconBg: const Color(0xFFE0E7FF),
                      iconColor: const Color(0xFF4F46E5),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          label: "CGPA",
                          value: "1.66",
                          pillText: "Rank in CS&E-A",
                          icon: Icons.article_outlined,
                          iconBg: const Color(0xFFE0F2FE),
                          iconColor: const Color(0xFF0284C7),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMetricCard(
                          label: "Attendance",
                          value: "88%",
                          pillText: "Exam eligible",
                          icon: Icons.schedule_rounded,
                          iconBg: const Color(0xFFDCFCE7),
                          iconColor: const Color(0xFF16A34A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          label: "Internal avg.",
                          value: "5%",
                          pillText: "+4% from IA-1",
                          icon: Icons.show_chart_rounded,
                          iconBg: const Color(0xFFF3E8FF),
                          iconColor: const Color(0xFF9333EA),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMetricCard(
                          label: "Credits earned",
                          value: "34 / 35",
                          pillText: "On track",
                          icon: Icons.menu_book_outlined,
                          iconBg: const Color(0xFFE0E7FF),
                          iconColor: const Color(0xFF4F46E5),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 20),

        // 3. Middle Section: Two Charts (Subject-wise Bars + Semester Performance Line)
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 960;
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildBarChartCard()),
                  const SizedBox(width: 20),
                  Expanded(child: _buildLineChartCard()),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBarChartCard(),
                  const SizedBox(height: 20),
                  _buildLineChartCard(),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 20),

        // 4. Bottom Section: AI Insights Card
        _buildAiInsightsCard(),
        const SizedBox(height: 40),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Top Metric Card
  // ---------------------------------------------------------------------------
  Widget _buildMetricCard({
    required String label,
    required String value,
    required String pillText,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
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
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFDCFCE7)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.trending_up_rounded, size: 13, color: Color(0xFF16A34A)),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    pillText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF15803D),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Subject-wise Internal Marks & Attendance (%) Card
  // ---------------------------------------------------------------------------
  Widget _buildBarChartCard() {
    final subjects = [
      {"code": "CS3492", "ia1": 0, "ia2": 0, "att": 80},
      {"code": "CSE105", "ia1": 0, "ia2": 0, "att": 85},
      {"code": "CSE101", "ia1": 0, "ia2": 7, "att": 89},
      {"code": "DBMS", "ia1": 0, "ia2": 7, "att": 92},
      {"code": "CSE107", "ia1": 25, "ia2": 28, "att": 82},
      {"code": "CS201", "ia1": 0, "ia2": 0, "att": 86},
      {"code": "CSE102", "ia1": 0, "ia2": 0, "att": 89},
      {"code": "python", "ia1": 0, "ia2": 0, "att": 93},
      {"code": "CSE106", "ia1": 0, "ia2": 7, "att": 88},
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
            "Subject-wise Internal Marks & Attendance (%)",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 18),

          // Bar Chart with custom layout
          SizedBox(
            height: 200,
            child: Row(
              children: [
                // Y-axis labels (100, 75, 50, 25, 0)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    _AxisLabel("100"),
                    _AxisLabel("75"),
                    _AxisLabel("50"),
                    _AxisLabel("25"),
                    _AxisLabel("0"),
                  ],
                ),
                const SizedBox(width: 8),

                // Grid lines + bars
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const double minPlotWidth = 420.0;
                      final double plotWidth = math.max(constraints.maxWidth, minPlotWidth);

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          width: plotWidth,
                          height: 200,
                          child: Stack(
                            children: [
                              // Horizontal grid lines
                              Positioned.fill(
                                bottom: 24,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    5,
                                    (_) => const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                                  ),
                                ),
                              ),

                              // Bars for each subject
                              Positioned.fill(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: subjects.map((s) {
                                    final double attH = ((s["att"] as int) / 100) * 160;
                                    final double ia1H = ((s["ia1"] as int) / 100) * 160;
                                    final double ia2H = ((s["ia2"] as int) / 100) * 160;

                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // IA1 bar
                                            if (ia1H > 0)
                                              Container(
                                                width: 6,
                                                height: ia1H,
                                                margin: const EdgeInsets.only(right: 2),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF1E2865),
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                              ),
                                            // IA2 bar
                                            if (ia2H > 0)
                                              Container(
                                                width: 6,
                                                height: ia2H,
                                                margin: const EdgeInsets.only(right: 2),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFD97706),
                                                  borderRadius: BorderRadius.circular(2),
                                                ),
                                              ),
                                            // Attendance bar
                                            Container(
                                              width: 7,
                                              height: attH,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF0F766E), // Teal
                                                borderRadius: BorderRadius.circular(2),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          s["code"] as String,
                                          style: GoogleFonts.poppins(
                                            fontSize: 9.5,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF64748B),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _LegendDot(color: Color(0xFF1E2865), label: "IA1"),
              SizedBox(width: 14),
              _LegendDot(color: Color(0xFFD97706), label: "IA2"),
              SizedBox(width: 14),
              _LegendDot(color: Color(0xFF0F766E), label: "Attendance"),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Semester Performance Trend Card (Line Chart)
  // ---------------------------------------------------------------------------
  Widget _buildLineChartCard() {
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
            "Semester Performance Trend",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 18),

          // Line Chart Canvas
          SizedBox(
            height: 200,
            child: Row(
              children: [
                // Y-axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    _AxisLabel("100"),
                    _AxisLabel("75"),
                    _AxisLabel("50"),
                    _AxisLabel("25"),
                    _AxisLabel("0"),
                  ],
                ),
                const SizedBox(width: 8),

                // Chart drawing
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const double minPlotWidth = 340.0;
                      final double plotWidth = math.max(constraints.maxWidth, minPlotWidth);

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          width: plotWidth,
                          height: 200,
                          child: Stack(
                            children: [
                              // Grid lines
                              Positioned.fill(
                                bottom: 24,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    5,
                                    (_) => const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                                  ),
                                ),
                              ),

                              // Custom line paint
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: _SemesterTrendPainter(),
                                ),
                              ),

                              // X-axis Semester Labels
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    _AxisLabel("Sem 1"),
                                    _AxisLabel("Sem 2"),
                                    _AxisLabel("Sem 3"),
                                    _AxisLabel("Sem 4"),
                                    _AxisLabel("Sem 3 (Current)"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _LegendDot(color: Color(0xFF1E2865), label: "Progress"),
              SizedBox(width: 14),
              _LegendDot(color: Color(0xFFD97706), label: "Mastery"),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom AI Insights Card
  // ---------------------------------------------------------------------------
  Widget _buildAiInsightsCard() {
    return Container(
      width: double.infinity,
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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.lightbulb_outline_rounded,
                      color: Color(0xFFD97706),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "AI insights",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  "Evidence-linked",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Academic Standing
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(top: 6, right: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFF0F766E),
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Academic Standing",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "You are maintaining a strong 1.66 CGPA in B.E. Computer Science & Engineering. Your highest performance is in Advanced Java.",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF334155),
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Evidence: Verified by College Exam Cell · 34 credits recorded",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Helpers & Trend Painter
// -----------------------------------------------------------------------------
class _AxisLabel extends StatelessWidget {
  final String text;
  const _AxisLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8)),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF475569))),
      ],
    );
  }
}

class _SemesterTrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double h = size.height - 24; // leave bottom room for X-axis labels

    final progressPaint = Paint()
      ..color = const Color(0xFF1E2865)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final masteryPaint = Paint()
      ..color = const Color(0xFFD97706)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Progress Line (steady high ~100% then drops slightly at Current)
    final progressPath = Path()
      ..moveTo(0, h * 0.05)
      ..lineTo(size.width * 0.25, h * 0.05)
      ..lineTo(size.width * 0.50, h * 0.05)
      ..lineTo(size.width * 0.75, h * 0.08)
      ..lineTo(size.width, h * 0.38);

    // Mastery Line (steady ~75% then drops at Current)
    final masteryPath = Path()
      ..moveTo(0, h * 0.22)
      ..lineTo(size.width * 0.25, h * 0.20)
      ..lineTo(size.width * 0.50, h * 0.21)
      ..lineTo(size.width * 0.75, h * 0.20)
      ..lineTo(size.width, h * 0.95);

    canvas.drawPath(progressPath, progressPaint);
    canvas.drawPath(masterPath(masteryPath), masteryPaint);
  }

  Path masterPath(Path p) => p;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

