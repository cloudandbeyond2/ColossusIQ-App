import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// DEPARTMENT: ACADEMIC PERFORMANCE SCREEN (HOD)
// Exactly matches Screenshot 3:
// - Blueprint hero banner with "DEPARTMENT" + "MVP" badges & chart watermark
// - 4 KPI Metric Cards with top teal accent borders:
//     * Active courses: 0
//     * Average marks: 0.0
//     * Pass percentage: 0%
//     * Course completion: 0%
// - 2 Side-by-Side Chart Cards:
//     * Pass % by subject (0-4 grid coordinate lines)
//     * Semester averages (0-4 grid coordinate lines with "Average : 0" tooltip)
// =============================================================================

class HodAcademicPerformanceScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const HodAcademicPerformanceScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeroBanner(),
              const SizedBox(height: 20),
              _buildKpiMetricsRow(),
              const SizedBox(height: 20),
              _buildChartsRow(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 3)
  // ===========================================================================
  Widget _buildTopHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF161E4A),
            Color(0xFF222B68),
            Color(0xFF38439E),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            // Watermark graph on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.show_chart_rounded,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            // Banner Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            'Home',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Department',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Academic Performance',
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.bar_chart_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E2548),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    'DEPARTMENT',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: const Color(0xFF93C5FD),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0F766E),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'MVP',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Academic Performance',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Subject-wise pass rates, averages and failure patterns.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.85),
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
  // 4 KPI METRIC CARDS WITH TOP ACCENT BORDER (Screenshot 3)
  // ===========================================================================
  Widget _buildKpiMetricsRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 860;
        final isTablet = constraints.maxWidth >= 540;

        final items = [
          {
            'title': 'Active courses',
            'value': '0',
            'icon': Icons.menu_book_outlined,
            'topColor': const Color(0xFF0F766E),
          },
          {
            'title': 'Average marks',
            'value': '0.0',
            'icon': Icons.description_outlined,
            'topColor': const Color(0xFF0F766E),
          },
          {
            'title': 'Pass percentage',
            'value': '0%',
            'icon': Icons.article_outlined,
            'topColor': const Color(0xFF0F766E),
          },
          {
            'title': 'Course completion',
            'value': '0%',
            'icon': Icons.import_contacts_outlined,
            'topColor': const Color(0xFF38439E),
          },
        ];

        if (isDesktop) {
          return Row(
            children: items.map((item) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _buildKpiCard(
                    title: item['title'] as String,
                    value: item['value'] as String,
                    icon: item['icon'] as IconData,
                    topColor: item['topColor'] as Color,
                  ),
                ),
              );
            }).toList(),
          );
        } else if (isTablet) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildKpiCard(
                      title: items[0]['title'] as String,
                      value: items[0]['value'] as String,
                      icon: items[0]['icon'] as IconData,
                      topColor: items[0]['topColor'] as Color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildKpiCard(
                      title: items[1]['title'] as String,
                      value: items[1]['value'] as String,
                      icon: items[1]['icon'] as IconData,
                      topColor: items[1]['topColor'] as Color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildKpiCard(
                      title: items[2]['title'] as String,
                      value: items[2]['value'] as String,
                      icon: items[2]['icon'] as IconData,
                      topColor: items[2]['topColor'] as Color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildKpiCard(
                      title: items[3]['title'] as String,
                      value: items[3]['value'] as String,
                      icon: items[3]['icon'] as IconData,
                      topColor: items[3]['topColor'] as Color,
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Column(
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildKpiCard(
                  title: item['title'] as String,
                  value: item['value'] as String,
                  icon: item['icon'] as IconData,
                  topColor: item['topColor'] as Color,
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required IconData icon,
    required Color topColor,
  }) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Accent Border Line
          Container(
            height: 3.5,
            decoration: BoxDecoration(
              color: topColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDFA),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCCFBF1)),
                      ),
                      child: Icon(
                        icon,
                        size: 16,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TWO CHARTS ROW (Screenshot 3)
  // ===========================================================================
  Widget _buildChartsRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 860;
        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildPassPercentageChart()),
              const SizedBox(width: 20),
              Expanded(child: _buildSemesterAveragesChart()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildPassPercentageChart(),
              const SizedBox(height: 20),
              _buildSemesterAveragesChart(),
            ],
          );
        }
      },
    );
  }

  // Chart 1: Pass % by subject
  Widget _buildPassPercentageChart() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pass % by subject',
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 24),
          _buildCoordinateGrid(showAveragePoint: false),
        ],
      ),
    );
  }

  // Chart 2: Semester averages
  Widget _buildSemesterAveragesChart() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Semester averages',
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 24),
          _buildCoordinateGrid(showAveragePoint: true),
        ],
      ),
    );
  }

  // Reusable Coordinate Grid for both charts
  Widget _buildCoordinateGrid({required bool showAveragePoint}) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          // Y-Axis Labels and Horizontal Grid Lines
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildGridLine('4'),
              _buildGridLine('3'),
              _buildGridLine('2'),
              _buildGridLine('1'),
              _buildGridLine('0'),
            ],
          ),
          // Vertical guide line and Average point if enabled (Screenshot 3)
          if (showAveragePoint) ...[
            Positioned(
              left: 200,
              top: 0,
              bottom: 0,
              child: Container(
                width: 1,
                color: const Color(0xFFE2E8F0),
              ),
            ),
            // Point dot at 0 line
            Positioned(
              left: 197.5,
              bottom: 6,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF0F172A),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Floating Tooltip: Average : 0
            Positioned(
              left: 204,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Average : 0',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF334155),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGridLine(String label) {
    return Row(
      children: [
        SizedBox(
          width: 18,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFF1F5F9),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// BLUEPRINT GRID BACKGROUND PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    const step = 28.0;
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
