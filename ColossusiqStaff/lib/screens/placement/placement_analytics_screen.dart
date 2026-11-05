import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PLACEMENT: PLACEMENT ANALYTICS SCREEN
// Exactly matches Screenshots 2 & 3:
// - Blueprint grid hero banner with analytics watermark, PLACEMENT and Phase 2 badges
// - Live indicator & Refresh button
// - 6 KPI Metric Cards with top color accent borders and badges
// - 6 Chart Cards:
//   1. Offers by company (TCS 28, Zoho 18)
//   2. Readiness and mock interview by department (Grouped bars with legend)
//   3. Hiring funnel (Registered 437, Shortlisted 112, Offers 46)
//   4. Registrations and offers by drive month (Curved line graph Sept-Nov 26)
//   5. Readiness status (Donut chart: Placement ready, Almost ready, Needs work)
//   6. Readiness score distribution (Histogram: 0-39, 40-54, 55-69, 70-84, 85-100)
// - Bottom AI insights card with Evidence-linked badge and 2 bullet recommendations
// =============================================================================

class PlacementAnalyticsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PlacementAnalyticsScreen({super.key, this.onBack});

  @override
  State<PlacementAnalyticsScreen> createState() =>
      _PlacementAnalyticsScreenState();
}

class _PlacementAnalyticsScreenState extends State<PlacementAnalyticsScreen> {
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
              const SizedBox(height: 12),
              _buildLiveUpdateBar(),
              const SizedBox(height: 12),
              _buildMetricCards(),
              const SizedBox(height: 20),
              _buildChartsGrid(),
              const SizedBox(height: 20),
              _buildAiInsightsCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 2)
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
            // Watermark graph
            Positioned(
              right: -15,
              bottom: -25,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.show_chart_rounded,
                  size: 200,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb
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
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.arrow_back,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                        ],
                        Text(
                          'Home',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('>',
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.5))),
                        const SizedBox(width: 6),
                        Text(
                          'Placement',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('>',
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.5))),
                        const SizedBox(width: 6),
                        Text(
                          'Placement Analytics',
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bar chart Icon Box
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.bar_chart_rounded,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.16),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Text(
                                    'PLACEMENT',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Phase 2',
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
                              'Placement Analytics',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Readiness, resume completion, mock-interview participation and offers.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
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
  // LIVE UPDATE BAR (Screenshot 2)
  // ===========================================================================
  Widget _buildLiveUpdateBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Live · updated 02:56:17 pm',
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(width: 10),
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Refreshed placement analytics.',
                    style: GoogleFonts.poppins()),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.refresh_rounded,
              size: 14, color: Color(0xFF334155)),
          label: Text(
            'Refresh',
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 6 STAT METRIC KPI CARDS (Screenshot 2)
  // ===========================================================================
  Widget _buildMetricCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth >= 1150
            ? 6
            : (constraints.maxWidth >= 800
                ? 3
                : (constraints.maxWidth >= 500 ? 2 : 1));
        final ratio = constraints.maxWidth >= 1150
            ? 1.6
            : (constraints.maxWidth >= 800
                ? 1.7
                : (constraints.maxWidth >= 500 ? 1.5 : 2.4));

        return GridView.count(
          crossAxisCount: count,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: ratio,
          children: [
            _buildKpiCard(
              title: 'Placement readiness',
              value: '65%',
              badge: '3 of 14 placement ready',
              topAccent: const Color(0xFF0D9488),
              icon: Icons.work_outline_rounded,
              iconColor: const Color(0xFF0D9488),
              iconBg: const Color(0xFFCCFBF1),
            ),
            _buildKpiCard(
              title: 'Offers',
              value: '46',
              badge: '2 drives completed',
              topAccent: const Color(0xFFD97706),
              icon: Icons.work_outline_rounded,
              iconColor: const Color(0xFFD97706),
              iconBg: const Color(0xFFFEF3C7),
            ),
            _buildKpiCard(
              title: 'Average package',
              value: '₹8 LPA',
              badge: 'Highest ₹9.5 LPA',
              topAccent: const Color(0xFF1E2865),
              icon: Icons.description_outlined,
              iconColor: const Color(0xFF1E2865),
              iconBg: const Color(0xFFEFF6FF),
            ),
            _buildKpiCard(
              title: 'Resume completion',
              value: '64%',
              subtext: 'Resume ATS score of 70 or more',
              topAccent: const Color(0xFF334155),
              icon: Icons.trending_up_rounded,
              iconColor: const Color(0xFF334155),
              iconBg: const Color(0xFFF1F5F9),
            ),
            _buildKpiCard(
              title: 'Mock interview participation',
              value: '100%',
              badge: 'Average score 60',
              topAccent: const Color(0xFF0D9488),
              icon: Icons.work_outline_rounded,
              iconColor: const Color(0xFF0D9488),
              iconBg: const Color(0xFFCCFBF1),
            ),
            _buildKpiCard(
              title: 'Registered to offer',
              value: '11%',
              badge: '46 of 437 registered',
              topAccent: const Color(0xFF2563EB),
              icon: Icons.work_outline_rounded,
              iconColor: const Color(0xFF2563EB),
              iconBg: const Color(0xFFEFF6FF),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    String? badge,
    String? subtext,
    required Color topAccent,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Accent Line
            Container(height: 3, color: topAccent),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: iconBg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(icon, size: 14, color: iconColor),
                        ),
                      ],
                    ),
                    Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    if (badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCCFBF1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.arrow_upward_rounded,
                                size: 10, color: Color(0xFF0F766E)),
                            const SizedBox(width: 3),
                            Text(
                              badge,
                              style: GoogleFonts.poppins(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F766E),
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (subtext != null)
                      Text(
                        subtext,
                        style: GoogleFonts.poppins(
                          fontSize: 9.5,
                          color: const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 6 CHARTS GRID (Screenshot 2 & 3)
  // ===========================================================================
  Widget _buildChartsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;

        final chart1 = _buildOffersByCompanyCard();
        final chart2 = _buildReadinessByDeptCard();
        final chart3 = _buildHiringFunnelCard();
        final chart4 = _buildRegistrationsLineCard();
        final chart5 = _buildReadinessStatusDonutCard();
        final chart6 = _buildReadinessScoreDistCard();

        if (isDesktop) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: chart1),
                  const SizedBox(width: 18),
                  Expanded(child: chart2),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: chart3),
                  const SizedBox(width: 18),
                  Expanded(child: chart4),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: chart5),
                  const SizedBox(width: 18),
                  Expanded(child: chart6),
                ],
              ),
            ],
          );
        } else {
          return Column(
            children: [
              chart1,
              const SizedBox(height: 16),
              chart2,
              const SizedBox(height: 16),
              chart3,
              const SizedBox(height: 16),
              chart4,
              const SizedBox(height: 16),
              chart5,
              const SizedBox(height: 16),
              chart6,
            ],
          );
        }
      },
    );
  }

  // Chart 1: Offers by company (TCS 28, Zoho 18)
  Widget _buildOffersByCompanyCard() {
    return _buildChartContainer(
      title: 'Offers by company',
      child: _buildBarChartArea(
        yLabels: ['28', '21', '14', '7', '0'],
        bars: [
          {'label': 'Tata Consultancy Services (TCS)', 'heightFrac': 1.0, 'color': const Color(0xFF1E2865)},
          {'label': 'Zoho Corporation', 'heightFrac': 18 / 28, 'color': const Color(0xFF1E2865)},
        ],
      ),
    );
  }

  // Chart 2: Readiness and mock interview by department
  Widget _buildReadinessByDeptCard() {
    return _buildChartContainer(
      title: 'Readiness and mock interview by department',
      child: Column(
        children: [
          SizedBox(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Y-Axis
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: ['100', '75', '50', '25', '0'].map((y) {
                    return SizedBox(
                      height: 14,
                      child: Text(
                        y,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 8),
                // Area with grouped bars
                Expanded(
                  child: Stack(
                    children: [
                      // Gridlines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(5, (_) => const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9))),
                      ),
                      Positioned.fill(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildGroupedBars(0.75, 0.85),
                            _buildGroupedBars(0.74, 0.66),
                            _buildGroupedBars(0.66, 0.61),
                            _buildGroupedBars(0.62, 0.49),
                            _buildGroupedBars(0.60, 0.45),
                            _buildGroupedBars(0.58, 0.65),
                            _buildGroupedBars(0.52, 0.48),
                            _buildGroupedBars(0.51, 0.46),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          // X-Labels
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Information Tech.',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 9.5, color: const Color(0xFF64748B)),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Computer Science',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 9.5, color: const Color(0xFF64748B)),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Mechanical Eng.',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 9.5, color: const Color(0xFF64748B)),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Science & Hum.',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 9.5, color: const Color(0xFF64748B)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF1E2865), shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Text('Readiness', style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B))),
              const SizedBox(width: 14),
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFD97706), shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Text('Interview', style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedBars(double f1, double f2) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 14,
          height: 130 * f1,
          decoration: const BoxDecoration(
            color: Color(0xFF1E2865),
            borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
          ),
        ),
        const SizedBox(width: 2),
        Container(
          width: 14,
          height: 130 * f2,
          decoration: const BoxDecoration(
            color: Color(0xFFD97706),
            borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
          ),
        ),
      ],
    );
  }

  // Chart 3: Hiring funnel (Registered 437, Shortlisted 112, Offers 46)
  Widget _buildHiringFunnelCard() {
    return _buildChartContainer(
      title: 'Hiring funnel',
      child: _buildBarChartArea(
        yLabels: ['600', '450', '300', '150', '0'],
        bars: [
          {'label': 'Registered', 'heightFrac': 437 / 600, 'color': const Color(0xFF1E2865)},
          {'label': 'Shortlisted', 'heightFrac': 112 / 600, 'color': const Color(0xFF1E2865)},
          {'label': 'Offers', 'heightFrac': 46 / 600, 'color': const Color(0xFF1E2865)},
        ],
      ),
    );
  }

  // Chart 4: Registrations and offers by drive month
  Widget _buildRegistrationsLineCard() {
    return _buildChartContainer(
      title: 'Registrations and offers by drive month',
      child: Column(
        children: [
          SizedBox(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Y-Axis
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: ['280', '210', '140', '70', '0'].map((y) {
                    return SizedBox(
                      height: 14,
                      child: Text(
                        y,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Stack(
                    children: [
                      // Gridlines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(5, (_) => const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9))),
                      ),
                      // Smooth Line graph painter
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _CurvedDriveGraphPainter(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sept 26', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
                Text('Oct 26', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
                Text('Nov 26', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF1E2865), shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Text('Registered', style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B))),
              const SizedBox(width: 14),
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFD97706), shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Text('Offers', style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B))),
            ],
          ),
        ],
      ),
    );
  }

  // Chart 5: Readiness status Donut
  Widget _buildReadinessStatusDonutCard() {
    return _buildChartContainer(
      title: 'Readiness status',
      child: Column(
        children: [
          SizedBox(
            height: 170,
            child: Center(
              child: SizedBox(
                width: 140,
                height: 140,
                child: CustomPaint(
                  painter: _DonutChartPainter(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDot(const Color(0xFF1E2865), 'Placement ready'),
              const SizedBox(width: 12),
              _buildDot(const Color(0xFFD97706), 'Almost ready'),
              const SizedBox(width: 12),
              _buildDot(const Color(0xFF0F766E), 'Needs work'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B))),
      ],
    );
  }

  // Chart 6: Readiness score distribution
  Widget _buildReadinessScoreDistCard() {
    return _buildChartContainer(
      title: 'Readiness score distribution',
      child: _buildBarChartArea(
        yLabels: ['8', '6', '4', '2', '0'],
        bars: [
          {'label': '0–39', 'heightFrac': 0.0, 'color': const Color(0xFF1E2865)},
          {'label': '40–54', 'heightFrac': 3 / 8, 'color': const Color(0xFF1E2865)},
          {'label': '55–69', 'heightFrac': 5 / 8, 'color': const Color(0xFF1E2865)},
          {'label': '70–84', 'heightFrac': 6 / 8, 'color': const Color(0xFF1E2865)},
          {'label': '85–100', 'heightFrac': 0.0, 'color': const Color(0xFF1E2865)},
        ],
      ),
    );
  }

  Widget _buildChartContainer({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(minHeight: 280),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildBarChartArea({
    required List<String> yLabels,
    required List<Map<String, dynamic>> bars,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 170,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Y-Axis labels
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: yLabels.map((y) {
                  return SizedBox(
                    height: 14,
                    child: Text(
                      y,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(width: 8),
              // Grid and Bars
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        yLabels.length,
                        (_) => const Divider(
                            height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                      ),
                    ),
                    Positioned.fill(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: bars.map((b) {
                          final frac = (b['heightFrac'] as num).toDouble();
                          final color = b['color'] as Color;
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (frac > 0)
                                  Container(
                                    width: 30,
                                    height: 130 * frac,
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(3)),
                                    ),
                                  )
                                else
                                  const SizedBox(height: 2),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: bars.map((b) {
              return Expanded(
                child: Text(
                  b['label'] as String,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 9.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // BOTTOM AI INSIGHTS CARD (Screenshot 3)
  // ===========================================================================
  Widget _buildAiInsightsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFEF3C7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lightbulb_outline_rounded,
                        size: 16, color: Color(0xFFD97706)),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'AI insights',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Evidence-linked',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Bullet 1
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6),
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFFC2410C),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Certificates is the weakest readiness area',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Students average 59% in certificates, against 78% in resume. Targeted practice here lifts the most students toward placement ready.',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF475569),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Evidence: 14 students on the readiness board',
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Bullet 2
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6),
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF0D9488),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '8 students are close to placement ready',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'The most common gap among them is quiz average (5 students). A short push there moves them onto the shortlist.',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF475569),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Evidence: Almost ready = total 55–69 or one criterion missing',
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        color: const Color(0xFF94A3B8),
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

// Donut Chart Painter
class _DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 24.0;

    final paint1 = Paint()
      ..color = const Color(0xFF1E2865)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final paint2 = Paint()
      ..color = const Color(0xFFD97706)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final paint3 = Paint()
      ..color = const Color(0xFF0D9488)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    // 3 Placement ready (3/14 ~ 77 deg), 8 Almost ready (8/14 ~ 205 deg), 3 Needs work (3/14 ~ 78 deg)
    double startAngle = -math.pi / 2;
    const sweep1 = (3 / 14) * 2 * math.pi;
    const sweep2 = (8 / 14) * 2 * math.pi;
    const sweep3 = (3 / 14) * 2 * math.pi;

    canvas.drawArc(rect, startAngle, sweep1, false, paint1);
    startAngle += sweep1;
    canvas.drawArc(rect, startAngle, sweep2, false, paint2);
    startAngle += sweep2;
    canvas.drawArc(rect, startAngle, sweep3, false, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Curved Graph Painter for Registrations & Offers
class _CurvedDriveGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final navyPaint = Paint()
      ..color = const Color(0xFF1E2865)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final goldPaint = Paint()
      ..color = const Color(0xFFD97706)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Navy curve (high to lower)
    final pathNavy = Path();
    pathNavy.moveTo(0, 0);
    pathNavy.cubicTo(w * 0.35, h * 0.45, w * 0.65, h * 0.70, w, h * 0.75);
    canvas.drawPath(pathNavy, navyPaint);

    // Gold curve (lower to flat)
    final pathGold = Path();
    pathGold.moveTo(0, h * 0.75);
    pathGold.cubicTo(w * 0.35, h * 0.88, w * 0.65, h * 0.94, w, h * 0.95);
    canvas.drawPath(pathGold, goldPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Background painter for blueprint grid in top banner
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    const double step = 28.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
