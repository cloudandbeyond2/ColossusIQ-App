import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalAdmissionInsightsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalAdmissionInsightsScreen({super.key, this.onBack});

  @override
  State<PrincipalAdmissionInsightsScreen> createState() =>
      _PrincipalAdmissionInsightsScreenState();
}

class _PrincipalAdmissionInsightsScreenState
    extends State<PrincipalAdmissionInsightsScreen> {
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
                const SizedBox(height: 18),

                // 2. 4 METRIC KPI CARDS (Image 1)
                _buildKpiCards(constraints.maxWidth),
                const SizedBox(height: 20),

                // 3. ROW OF 2 CHARTS: Admission funnel & Community mix (Image 1)
                _buildRowOfTwoCharts1(constraints.maxWidth),
                const SizedBox(height: 20),

                // 4. ROW OF 2 CHARTS: Demand by programme & Applications per week (Image 2)
                _buildRowOfTwoCharts2(constraints.maxWidth),
                const SizedBox(height: 20),

                // 5. AI INSIGHTS CARD (Image 2)
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
                  Icons.insights_rounded,
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
                          "Admissions",
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
                          "Admission Insights",
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

                  // Badges: ADMISSIONS, MVP
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
                          "ADMISSIONS",
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
                            Icons.insights_rounded,
                            color: Color(0xFFFBBF24),
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
                              "Admission Insights",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Funnel, programme demand, category mix and conversion for the current cycle.",
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
  // 2. 4 METRIC KPI CARDS (Image 1)
  // ===========================================================================
  Widget _buildKpiCards(double maxWidth) {
    double cardWidth;
    if (maxWidth >= 1050) {
      cardWidth = (maxWidth - (3 * 12)) / 4;
    } else if (maxWidth >= 540) {
      cardWidth = (maxWidth - 12) / 2;
    } else {
      cardWidth = maxWidth;
    }

    final cards = [
      _buildSingleKpi(
        title: "Applications",
        value: "8",
        icon: Icons.people_outline_rounded,
        iconBg: const Color(0xFFEDE9FE),
        iconColor: const Color(0xFF7C3AED),
        badge: "Current cycle",
        badgeBg: const Color(0xFFCCFBF1),
        badgeColor: const Color(0xFF0D9488),
      ),
      _buildSingleKpi(
        title: "Enrolled",
        value: "1",
        icon: Icons.trending_up_rounded,
        iconBg: const Color(0xFFCCFBF1),
        iconColor: const Color(0xFF0D9488),
        badge: "17% of applicants",
        badgeBg: const Color(0xFFCCFBF1),
        badgeColor: const Color(0xFF0D9488),
        topAccentColor: const Color(0xFF0D9488),
      ),
      _buildSingleKpi(
        title: "Offers pending",
        value: "1",
        icon: Icons.work_outline_rounded,
        iconBg: const Color(0xFFFEF3C7),
        iconColor: const Color(0xFFD97706),
        topAccentColor: const Color(0xFFD97706),
      ),
      _buildSingleKpi(
        title: "Average 12th %",
        value: "82.5",
        icon: Icons.description_outlined,
        iconBg: const Color(0xFFE0F2FE),
        iconColor: const Color(0xFF0284C7),
        topAccentColor: const Color(0xFF0284C7),
      ),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
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
    Color? topAccentColor,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (topAccentColor != null)
            Container(
              height: 3,
              decoration: BoxDecoration(
                color: topAccentColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(14)),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
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
                          fontSize: 12,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
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
                  )
                else
                  const SizedBox(height: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. ROW OF 2 CHARTS 1 (Image 1)
  // ===========================================================================
  Widget _buildRowOfTwoCharts1(double maxWidth) {
    final chart1 = _buildChartCard(
      title: "Admission funnel",
      child: _buildAdmissionFunnelChart(),
    );

    final chart2 = _buildChartCard(
      title: "Community / category mix",
      child: _buildCommunityMixChart(),
    );

    if (maxWidth >= 850) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: chart1),
          const SizedBox(width: 16),
          Expanded(flex: 5, child: chart2),
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

  Widget _buildAdmissionFunnelChart() {
    const double maxH = 120.0;
    final stages = [
      {"label": "Enquiry", "val": 6},
      {"label": "Applied", "val": 6},
      {"label": "Docs verified", "val": 6},
      {"label": "Shortlisted", "val": 3},
      {"label": "Offer sent", "val": 2},
      {"label": "Fee paid", "val": 1},
      {"label": "Enrolled", "val": 1},
    ];

    return SizedBox(
      height: 155,
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
          const SizedBox(width: 10),

          // Bars
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: stages.map((s) {
                final val = s["val"] as int;
                final h = (val / 8.0) * maxH;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 18,
                      height: h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF131B4D),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(3)),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 48,
                      child: Text(
                        s["label"] as String,
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
    );
  }

  Widget _buildCommunityMixChart() {
    return Column(
      children: [
        SizedBox(
          height: 125,
          child: Center(
            child: CustomPaint(
              size: const Size(115, 115),
              painter: _CommunityDonutPainter(),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 4,
          alignment: WrapAlignment.center,
          children: [
            _buildDonutLegendItem("ST", const Color(0xFF131B4D)),
            _buildDonutLegendItem("MBC", const Color(0xFFD4AF37)),
            _buildDonutLegendItem("OC", const Color(0xFF0D9488)),
            _buildDonutLegendItem("EWS", const Color(0xFF1D4ED8)),
            _buildDonutLegendItem("SC", const Color(0xFFDC2626)),
            _buildDonutLegendItem("BC", const Color(0xFFC2410C)),
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
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 9,
            color: const Color(0xFF475569),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. ROW OF 2 CHARTS 2 (Image 2)
  // ===========================================================================
  Widget _buildRowOfTwoCharts2(double maxWidth) {
    final chart1 = _buildChartCard(
      title: "Demand by programme",
      child: _buildProgrammeDemandChart(),
    );

    final chart2 = _buildChartCard(
      title: "Applications per week",
      child: _buildApplicationsPerWeekChart(),
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

  Widget _buildProgrammeDemandChart() {
    const double maxH = 120.0;
    final progs = [
      {"label": "Computer Science", "val": 3.0},
      {"label": "Electrical & ..", "val": 1.0},
      {"label": "Mechanical Engineering", "val": 1.0},
      {"label": "Information Technology", "val": 1.0},
    ];

    return SizedBox(
      height: 155,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Y-axis
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("3",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("2.25",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("1.5",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("0.75",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
              Text("0",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF94A3B8))),
            ],
          ),
          const SizedBox(width: 10),

          // Bars
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: progs.map((p) {
                final val = p["val"] as double;
                final h = (val / 3.0) * maxH;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 18,
                      height: h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF131B4D),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(3)),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 60,
                      child: Text(
                        p["label"] as String,
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
    );
  }

  Widget _buildApplicationsPerWeekChart() {
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
                  Text("60",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("45",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("30",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("15",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                  Text("0",
                      style: GoogleFonts.poppins(
                          fontSize: 8.5, color: const Color(0xFF94A3B8))),
                ],
              ),
              const SizedBox(width: 10),

              // Curve
              Expanded(
                child: CustomPaint(
                  size: const Size(double.infinity, 120),
                  painter: _AppPerWeekPainter(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        // X-axis
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("W1",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF64748B))),
              Text("W2",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF64748B))),
              Text("W3",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF64748B))),
              Text("W4",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF64748B))),
              Text("W5",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF64748B))),
              Text("W6",
                  style: GoogleFonts.poppins(
                      fontSize: 8.5, color: const Color(0xFF64748B))),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5. AI INSIGHTS CARD (Image 2)
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
            title: "Document verification is the bottleneck",
            desc:
                "Applicants stall most between Applied and Documents verified. Consider a verification help desk.",
            evidence: "Evidence: 0 of 6 applicants not yet verified",
          ),
          const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),

          _buildInsightItem(
            dotColor: const Color(0xFF1D4ED8),
            title: "Scholarship interest",
            desc: "2 applicants requested scholarship support.",
            evidence: "Evidence: Admissions records · scholarship flag",
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

class _CommunityDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeW = 18.0;

    final rect = Rect.fromCircle(center: center, radius: radius - strokeW / 2);

    final colors = [
      const Color(0xFF131B4D), // ST
      const Color(0xFFD4AF37), // MBC
      const Color(0xFF0D9488), // OC
      const Color(0xFF1D4ED8), // EWS
      const Color(0xFFDC2626), // SC
      const Color(0xFFC2410C), // BC
    ];

    const double gap = 0.08;
    const double sweep = (6.283 - (6 * gap)) / 6;

    double startAngle = -1.57;
    for (int i = 0; i < 6; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeW;

      canvas.drawArc(rect, startAngle, sweep, false, paint);
      startAngle += sweep + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AppPerWeekPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final navyPaint = Paint()
      ..color = const Color(0xFF131B4D)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.35); // ~40
    path.cubicTo(
      size.width * 0.25,
      size.height * 0.30, // W2 ~43
      size.width * 0.45,
      size.height * 0.42, // W3 ~37
      size.width * 0.65,
      size.height * 0.15, // W4 ~53
    );
    path.cubicTo(
      size.width * 0.8,
      size.height * 0.16,
      size.width * 0.9,
      size.height * 0.18,
      size.width,
      size.height * 0.18, // W6 ~50
    );

    canvas.drawPath(path, navyPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
