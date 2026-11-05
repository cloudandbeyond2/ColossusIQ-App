import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalPlacementAnalyticsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalPlacementAnalyticsScreen({super.key, this.onBack});

  @override
  State<PrincipalPlacementAnalyticsScreen> createState() =>
      _PrincipalPlacementAnalyticsScreenState();
}

class _PrincipalPlacementAnalyticsScreenState
    extends State<PrincipalPlacementAnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
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
                const SizedBox(height: 14),

                // Live status row
                _buildLiveStatusRow(),
                const SizedBox(height: 14),

                // 2. 6 METRIC KPI CARDS (Image 1)
                _buildKpiCards(constraints.maxWidth),
                const SizedBox(height: 20),

                // 3. ROW OF 2 CHARTS: Offers by company & Readiness by Dept (Image 1)
                _buildRowOfTwoCharts(constraints.maxWidth),
                const SizedBox(height: 20),

                // 4. 2X2 GRID OF 4 CHARTS (Image 2)
                _buildFourChartsGrid(constraints.maxWidth),
                const SizedBox(height: 20),

                // 5. AI INSIGHTS CARD (Image 3)
                _buildAiInsightsCard(),
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
                  Icons.bar_chart_rounded,
                  size: 180,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
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
                              child: const Icon(Icons.arrow_back_rounded,
                                  size: 14, color: Colors.white),
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
                          "Placement",
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
                          "Placement Analytics",
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

                  // Badges: PLACEMENT, Phase 2
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
                          "PLACEMENT",
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
                          "Phase 2",
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

                  // Main Title & Subtitle
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
                            Icons.bar_chart_rounded,
                            color: Color(0xFFFBBF24), // Amber Chart
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Placement Analytics",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Readiness, resume completion, mock-interview participation and offers.",
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

  Widget _buildLiveStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Live · updated 01:16:51 pm",
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(width: 10),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.sync_rounded, size: 14, color: Color(0xFF475569)),
          label: Text("Refresh",
              style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF475569))),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 2. 6 METRIC KPI CARDS (Image 1)
  // ===========================================================================
  Widget _buildKpiCards(double maxWidth) {
    double cardWidth;
    if (maxWidth >= 1200) {
      cardWidth = (maxWidth - (5 * 10)) / 6;
    } else if (maxWidth >= 900) {
      cardWidth = (maxWidth - (2 * 10)) / 3;
    } else if (maxWidth >= 540) {
      cardWidth = (maxWidth - 10) / 2;
    } else {
      cardWidth = maxWidth;
    }

    final cards = [
      _buildSingleKpi(
        title: "Placement readiness",
        value: "65%",
        icon: Icons.work_outline_rounded,
        iconBg: const Color(0xFFCCFBF1),
        iconColor: const Color(0xFF0D9488),
        badge: "3 of 14 placement ready",
        badgeBg: const Color(0xFFCCFBF1),
        badgeColor: const Color(0xFF0D9488),
      ),
      _buildSingleKpi(
        title: "Offers",
        value: "46",
        icon: Icons.work_outline_rounded,
        iconBg: const Color(0xFFFEF3C7),
        iconColor: const Color(0xFFD97706),
        badge: "2 drives completed",
        badgeBg: const Color(0xFFCCFBF1),
        badgeColor: const Color(0xFF0D9488),
      ),
      _buildSingleKpi(
        title: "Average package",
        value: "₹8 LPA",
        icon: Icons.description_outlined,
        iconBg: const Color(0xFFE0F2FE),
        iconColor: const Color(0xFF0284C7),
        badge: "Highest ₹9.5 LPA",
        badgeBg: const Color(0xFFCCFBF1),
        badgeColor: const Color(0xFF0D9488),
      ),
      _buildSingleKpi(
        title: "Resume completion",
        value: "64%",
        icon: Icons.show_chart_rounded,
        iconBg: const Color(0xFFF3E8FF),
        iconColor: const Color(0xFF7C3AED),
        subtext: "Resume ATS score of 70 or more",
      ),
      _buildSingleKpi(
        title: "Mock interview participation",
        value: "100%",
        icon: Icons.work_outline_rounded,
        iconBg: const Color(0xFFCCFBF1),
        iconColor: const Color(0xFF0D9488),
        badge: "Average score 60",
        badgeBg: const Color(0xFFCCFBF1),
        badgeColor: const Color(0xFF0D9488),
      ),
      _buildSingleKpi(
        title: "Registered to offer",
        value: "11%",
        icon: Icons.work_outline_rounded,
        iconBg: const Color(0xFFE0F2FE),
        iconColor: const Color(0xFF0284C7),
        badge: "46 of 437 registered",
        badgeBg: const Color(0xFFCCFBF1),
        badgeColor: const Color(0xFF0D9488),
      ),
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: cards
          .map((c) => SizedBox(
                width: cardWidth,
                child: c,
              ))
          .toList(),
    );
  }

  Widget _buildSingleKpi({
    required String title,
    required String value,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    String? badge,
    Color? badgeBg,
    Color? badgeColor,
    String? subtext,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, size: 14, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          if (badge != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "↗ $badge",
                style: GoogleFonts.poppins(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                  color: badgeColor,
                ),
              ),
            ),
          if (subtext != null)
            Text(
              subtext,
              style: GoogleFonts.poppins(
                fontSize: 9.5,
                color: const Color(0xFF94A3B8),
              ),
            ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. ROW OF 2 CHARTS (Image 1)
  // ===========================================================================
  Widget _buildRowOfTwoCharts(double maxWidth) {
    final chart1 = _buildChartCard(
      title: "Offers by company",
      child: _buildOffersByCompanyChart(),
    );

    final chart2 = _buildChartCard(
      title: "Readiness and mock interview by department",
      child: _buildDepartmentReadinessChart(),
    );

    if (maxWidth >= 850) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: chart1),
          const SizedBox(width: 16),
          Expanded(child: chart2),
        ],
      );
    }

    return Column(
      children: [
        chart1,
        const SizedBox(height: 16),
        chart2,
      ],
    );
  }

  Widget _buildChartCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  Widget _buildOffersByCompanyChart() {
    const double maxH = 130.0;
    return SizedBox(
      height: 170,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Y-axis
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("28",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("21",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("14",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("7",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
              Text("0",
                  style: GoogleFonts.poppins(
                      fontSize: 9, color: const Color(0xFF94A3B8))),
            ],
          ),
          const SizedBox(width: 14),

          // Bars
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildSingleBar("Tata Consultancy Services (TCS)", (28 / 28) * maxH),
                _buildSingleBar("Zoho Corporation", (18 / 28) * maxH),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleBar(String label, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: height,
          decoration: const BoxDecoration(
            color: Color(0xFF131B4D),
            borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 110,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 8.5,
              color: const Color(0xFF64748B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDepartmentReadinessChart() {
    const double maxH = 120.0;
    final depts = [
      {"name": "Information Tech.", "r": 75.0, "i": 85.0},
      {"name": "Computer Science & Eng.", "r": 75.0, "i": 68.0},
      {"name": "Mechanical Eng.", "r": 62.0, "i": 48.0},
      {"name": "Science & Humanities", "r": 52.0, "i": 48.0},
    ];

    return Column(
      children: [
        SizedBox(
          height: 145,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Y-axis
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("100",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("75",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("50",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("25",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("0",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                ],
              ),
              const SizedBox(width: 10),

              // Dual bars
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: depts.map((d) {
                    final rH = ((d["r"] as num).toDouble() / 100.0) * maxH;
                    final iH = ((d["i"] as num).toDouble() / 100.0) * maxH;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 16,
                              height: rH,
                              decoration: const BoxDecoration(
                                color: Color(0xFF131B4D),
                                borderRadius:
                                    BorderRadius.vertical(top: Radius.circular(3)),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Container(
                              width: 16,
                              height: iH,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD4AF37),
                                borderRadius:
                                    BorderRadius.vertical(top: Radius.circular(3)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 65,
                          child: Text(
                            d["name"] as String,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                              color: const Color(0xFF64748B),
                            ),
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
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                  color: Color(0xFF131B4D), shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
            Text("Readiness",
                style: GoogleFonts.poppins(
                    fontSize: 10, color: const Color(0xFF475569))),
            const SizedBox(width: 14),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                  color: Color(0xFFD4AF37), shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
            Text("Interview",
                style: GoogleFonts.poppins(
                    fontSize: 10, color: const Color(0xFF475569))),
          ],
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. 2X2 GRID OF 4 CHARTS (Image 2)
  // ===========================================================================
  Widget _buildFourChartsGrid(double maxWidth) {
    final card1 = _buildChartCard(
      title: "Hiring funnel",
      child: _buildHiringFunnelChart(),
    );

    final card2 = _buildChartCard(
      title: "Registrations and offers by drive month",
      child: _buildDriveMonthTrendChart(),
    );

    final card3 = _buildChartCard(
      title: "Readiness status",
      child: _buildReadinessDonutChart(),
    );

    final card4 = _buildChartCard(
      title: "Readiness score distribution",
      child: _buildScoreDistributionChart(),
    );

    if (maxWidth >= 850) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: card1),
              const SizedBox(width: 16),
              Expanded(child: card2),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: card3),
              const SizedBox(width: 16),
              Expanded(child: card4),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        card1,
        const SizedBox(height: 16),
        card2,
        const SizedBox(height: 16),
        card3,
        const SizedBox(height: 16),
        card4,
      ],
    );
  }

  Widget _buildHiringFunnelChart() {
    const double maxH = 120.0;
    return SizedBox(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Y-axis
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("600",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("450",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("300",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("150",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("0",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
            ],
          ),
          const SizedBox(width: 12),

          // Bars
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildFunnelBar("Registered", (437 / 600) * maxH),
                _buildFunnelBar("Shortlisted", (85 / 600) * maxH),
                _buildFunnelBar("Offers", (46 / 600) * maxH),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelBar(String label, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: height,
          decoration: const BoxDecoration(
            color: Color(0xFF131B4D),
            borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 9.5,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildDriveMonthTrendChart() {
    return Column(
      children: [
        SizedBox(
          height: 135,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Y-axis
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("280",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("210",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("140",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("70",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("0",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                ],
              ),
              const SizedBox(width: 10),

              // Custom Painter Curve
              Expanded(
                child: CustomPaint(
                  size: const Size(double.infinity, 120),
                  painter: _TrendLinesPainter(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        // X-axis labels
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sept 26",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF64748B))),
              Text("Oct 26",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF64748B))),
              Text("Nov 26",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF64748B))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                  color: Color(0xFF131B4D), shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
            Text("Registered",
                style: GoogleFonts.poppins(
                    fontSize: 10, color: const Color(0xFF475569))),
            const SizedBox(width: 14),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                  color: Color(0xFFD4AF37), shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
            Text("Offers",
                style: GoogleFonts.poppins(
                    fontSize: 10, color: const Color(0xFF475569))),
          ],
        ),
      ],
    );
  }

  Widget _buildReadinessDonutChart() {
    return Column(
      children: [
        SizedBox(
          height: 135,
          child: Center(
            child: CustomPaint(
              size: const Size(120, 120),
              painter: _DonutChartPainter(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 6,
          alignment: WrapAlignment.center,
          children: [
            _buildDonutLegendItem("Placement ready", const Color(0xFF131B4D)),
            _buildDonutLegendItem("Almost ready", const Color(0xFFD4AF37)),
            _buildDonutLegendItem("Needs work", const Color(0xFF0D9488)),
          ],
        ),
      ],
    );
  }

  Widget _buildDonutLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 9.5,
            color: const Color(0xFF475569),
          ),
        ),
      ],
    );
  }

  Widget _buildScoreDistributionChart() {
    const double maxH = 120.0;
    final buckets = [
      {"label": "0–39", "val": 0},
      {"label": "40–54", "val": 3},
      {"label": "55–69", "val": 5},
      {"label": "70–84", "val": 6},
      {"label": "85–100", "val": 0},
    ];

    return SizedBox(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Y-axis
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("8",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("6",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("4",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("2",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("0",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
            ],
          ),
          const SizedBox(width: 12),

          // Bars
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: buckets.map((b) {
                final val = b["val"] as int;
                final h = val == 0 ? 3.0 : (val / 8.0) * maxH;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 24,
                      height: h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF131B4D),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(3)),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      b["label"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 8.5,
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
    );
  }

  // ===========================================================================
  // 5. AI INSIGHTS CARD (Image 3)
  // ===========================================================================
  Widget _buildAiInsightsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.lightbulb_outline_rounded,
                        size: 15, color: Color(0xFFD97706)),
                  ),
                  const SizedBox(width: 8),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "Evidence-linked",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          _buildInsightItem(
            dotColor: const Color(0xFFD97706),
            title: "Certificates is the weakest readiness area",
            desc:
                "Students average 59% in certificates, against 78% in resume. Targeted practice here lifts the most students toward placement ready.",
            evidence: "Evidence: 14 students on the readiness board",
          ),
          const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),

          _buildInsightItem(
            dotColor: const Color(0xFF0D9488),
            title: "8 students are close to placement ready",
            desc:
                "The most common gap among them is quiz average (5 students). A short push there moves them onto the shortlist.",
            evidence: "Evidence: Almost ready = total 55–69 or one criterion missing",
          ),
          const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),

          _buildInsightItem(
            dotColor: const Color(0xFFE11D48),
            title: "Artificial Intelligence trails the other departments",
            desc:
                "Artificial Intelligence averages 60 readiness with 1 of 2 placement ready, against 76 in Information Tech..",
            evidence: "Evidence: Department averages of the readiness total",
          ),
          const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),

          _buildInsightItem(
            dotColor: const Color(0xFF1E2865),
            title: "Google India is next on the calendar",
            desc: "2 students meet the rules for the 25 Oct drive and 48 registered.",
            evidence:
                "Evidence: Software Development Engineer (SDE-1) · ₹18–32.5 LPA",
          ),
          const SizedBox(height: 16),

          Text(
            "Insights support — not replace — human decisions.",
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem({
    required Color dotColor,
    required String title,
    required String desc,
    required String evidence,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                desc,
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF475569),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                evidence,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// PAINTERS
// =============================================================================

class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    const double step = 28;
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

class _TrendLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final navyPaint = Paint()
      ..color = const Color(0xFF131B4D)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final goldPaint = Paint()
      ..color = const Color(0xFFD4AF37)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Navy line: 260 -> 110 -> 65
    final path1 = Path();
    path1.moveTo(0, size.height * 0.1);
    path1.quadraticBezierTo(
        size.width * 0.45, size.height * 0.65, size.width, size.height * 0.78);
    canvas.drawPath(path1, navyPaint);

    // Gold line: 46 -> 18 -> 10
    final path2 = Path();
    path2.moveTo(0, size.height * 0.8);
    path2.quadraticBezierTo(
        size.width * 0.45, size.height * 0.9, size.width, size.height * 0.95);
    canvas.drawPath(path2, goldPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeW = 20.0;

    final paintNavy = Paint()
      ..color = const Color(0xFF131B4D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW;

    final paintGold = Paint()
      ..color = const Color(0xFFD4AF37)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW;

    final paintTeal = Paint()
      ..color = const Color(0xFF0D9488)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW;

    // 21% placement ready -> ~1.32 rad
    // 57% almost ready -> ~3.58 rad
    // 22% needs work -> ~1.38 rad
    final rect = Rect.fromCircle(center: center, radius: radius - strokeW / 2);

    canvas.drawArc(rect, -1.57, 1.32, false, paintNavy);
    canvas.drawArc(rect, -1.57 + 1.32, 3.58, false, paintGold);
    canvas.drawArc(rect, -1.57 + 1.32 + 3.58, 1.38, false, paintTeal);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
