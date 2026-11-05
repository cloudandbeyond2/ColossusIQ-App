import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hod_student_success_early_warning_screen.dart';
import 'hod_project_review_board_screen.dart';
import 'hod_skill_intelligence_screen.dart';
import 'hod_students_screen.dart';
import 'hod_academic_performance_screen.dart';
import 'hod_placement_readiness_board_screen.dart';
import 'hod_faculty_skill_booster_screen.dart';

// =============================================================================
// HEAD OF DEPARTMENT: HOME DASHBOARD (Matches Image 1)
// - Top Header: HEAD OF DEPARTMENT, Dr. S. Venkatesh · Department Intelligence
// - 4 Top Metric Cards (Students, Pass %, Placement Readiness, Faculty Upskilling)
//   with accent top border lines and pill change badges
// - Middle Row (3 cards):
//   1. Pass % by subject (custom bar chart)
//   2. Active projects (custom line/area chart)
//   3. Needs your attention (3 vertical color-coded alert items)
// - Bottom Row:
//   AI insights card with Evidence-linked badge and structured evidence
// =============================================================================

class HodHomeScreen extends StatelessWidget {
  final Function(Widget, {String? title, Widget? badge}) onOpenSubScreen;
  const HodHomeScreen({super.key, required this.onOpenSubScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1040;
        final isTablet =
            constraints.maxWidth >= 640 && constraints.maxWidth < 1040;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            isDesktop ? 28 : (isTablet ? 20 : 16),
            22,
            isDesktop ? 28 : (isTablet ? 20 : 16),
            120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Header Section (Fully responsive)
              _buildHeader(isDesktop, isTablet, constraints.maxWidth),
              const SizedBox(height: 20),

              // 2. Top 4 Metric KPI Cards (with colored accent top borders)
              _buildTopKpiRow(isDesktop, isTablet),
              const SizedBox(height: 20),

              // 3. Middle Section: Pass % by subject, Active projects, Needs your attention
              _buildMiddleSection(isDesktop, isTablet),
              const SizedBox(height: 20),

              // 4. Bottom Section: AI Insights Card
              _buildAiInsightsCard(),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 1. HEADER (Image 1) - Responsive across mobile, tablet & desktop
  // ---------------------------------------------------------------------------
  Widget _buildHeader(bool isDesktop, bool isTablet, double maxWidth) {
    final isMobile = maxWidth < 640;

    // Responsive typography based on viewport width
    final double categorySize = isDesktop ? 11.0 : (isTablet ? 10.5 : 10.0);
    final double titleSize = maxWidth >= 1200
        ? 24.0
        : (maxWidth >= 1040
            ? 22.0
            : (maxWidth >= 768
                ? 20.0
                : (maxWidth >= 480 ? 18.0 : 16.5)));
    final double subSize = isDesktop ? 13.0 : (isTablet ? 12.5 : 12.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "HEAD OF DEPARTMENT",
          style: GoogleFonts.poppins(
            fontSize: categorySize,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: const Color(0xFF64748B),
          ),
        ),
        SizedBox(height: isMobile ? 4 : 6),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            Text(
              "Good morning, Dr. S. Venkatesh",
              style: GoogleFonts.poppins(
                fontSize: titleSize,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.4,
                height: 1.25,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Color(0xFF64748B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Department Intelligence",
                  style: GoogleFonts.poppins(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.4,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: isMobile ? 4 : 5),
        Text(
          "Department intelligence, faculty, academics and placement readiness.",
          style: GoogleFonts.poppins(
            fontSize: subSize,
            color: const Color(0xFF64748B),
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 2. TOP 4 METRIC CARDS (Image 1)
  // ---------------------------------------------------------------------------
  Widget _buildTopKpiRow(bool isDesktop, bool isTablet) {
    final card1 = _buildTopMetricCard(
      title: "Students",
      value: "0",
      topAccentColor: const Color(0xFF1E2865),
      icon: Icons.people_outline_rounded,
      iconColor: const Color(0xFF4F46E5),
      iconBgColor: const Color(0xFFEEF2FF),
      onTap: () => onOpenSubScreen(
        const HodStudentsScreen(),
        title: "Students Directory",
      ),
    );

    final card2 = _buildTopMetricCard(
      title: "Pass percentage",
      value: "91.4%",
      badgeText: "+2.1%",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFF0D9488),
      icon: Icons.description_outlined,
      iconColor: const Color(0xFF0D9488),
      iconBgColor: const Color(0xFFCCFBF1),
      onTap: () => onOpenSubScreen(
        const HodAcademicPerformanceScreen(),
        title: "Academic Performance",
      ),
    );

    final card3 = _buildTopMetricCard(
      title: "Placement readiness",
      value: "66%",
      badgeText: "+5%",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFFD97706),
      icon: Icons.work_outline_rounded,
      iconColor: const Color(0xFFD97706),
      iconBgColor: const Color(0xFFFEF3C7),
      onTap: () => onOpenSubScreen(
        const HodPlacementReadinessBoardScreen(),
        title: "Placement Readiness Board",
      ),
    );

    final card4 = _buildTopMetricCard(
      title: "Faculty upskilling",
      value: "72%",
      badgeText: "on track",
      badgeColor: const Color(0xFF0D9488),
      badgeBgColor: const Color(0xFFCCFBF1),
      topAccentColor: const Color(0xFF2563EB),
      icon: Icons.co_present_outlined,
      iconColor: const Color(0xFF2563EB),
      iconBgColor: const Color(0xFFEFF6FF),
      onTap: () => onOpenSubScreen(
        const HodFacultySkillBoosterScreen(),
        title: "Faculty Skill Booster",
      ),
    );

    if (isDesktop) {
      return Row(
        children: [
          Expanded(child: card1),
          const SizedBox(width: 14),
          Expanded(child: card2),
          const SizedBox(width: 14),
          Expanded(child: card3),
          const SizedBox(width: 14),
          Expanded(child: card4),
        ],
      );
    } else if (isTablet) {
      return Column(
        children: [
          Row(children: [
            Expanded(child: card1),
            const SizedBox(width: 12),
            Expanded(child: card2),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: card3),
            const SizedBox(width: 12),
            Expanded(child: card4),
          ]),
        ],
      );
    } else {
      return Column(
        children: [
          card1,
          const SizedBox(height: 10),
          card2,
          const SizedBox(height: 10),
          card3,
          const SizedBox(height: 10),
          card4,
        ],
      );
    }
  }

  Widget _buildTopMetricCard({
    required String title,
    required String value,
    required Color topAccentColor,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    String? badgeText,
    Color? badgeColor,
    Color? badgeBgColor,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top colored accent bar
              Container(
                height: 3.5,
                decoration: BoxDecoration(
                  color: topAccentColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              value,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          if (badgeText != null) ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: badgeBgColor ?? const Color(0xFFCCFBF1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.trending_up_rounded,
                                    size: 11,
                                    color: badgeColor ?? const Color(0xFF0D9488),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    badgeText,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: badgeColor ??
                                          const Color(0xFF0D9488),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, color: iconColor, size: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. MIDDLE SECTION (Pass % by subject, Active projects, Needs attention)
  // ---------------------------------------------------------------------------
  Widget _buildMiddleSection(bool isDesktop, bool isTablet) {
    final chart1 = _buildPassBySubjectCard();
    final chart2 = _buildActiveProjectsCard();
    final attentionCard = _buildNeedsAttentionCard();

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 7, child: chart1),
          const SizedBox(width: 14),
          Expanded(flex: 7, child: chart2),
          const SizedBox(width: 14),
          Expanded(flex: 6, child: attentionCard),
        ],
      );
    } else if (isTablet) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: chart1),
              const SizedBox(width: 14),
              Expanded(child: chart2),
            ],
          ),
          const SizedBox(height: 14),
          attentionCard,
        ],
      );
    } else {
      return Column(
        children: [
          chart1,
          const SizedBox(height: 14),
          chart2,
          const SizedBox(height: 14),
          attentionCard,
        ],
      );
    }
  }

  // Card 1: Pass % by subject (Custom Bar Chart)
  Widget _buildPassBySubjectCard() {
    final subjects = [
      {'name': 'DBMS', 'pct': 92},
      {'name': 'OS', 'pct': 88},
      {'name': 'CN', 'pct': 90},
      {'name': 'TOC', 'pct': 85},
      {'name': 'ML', 'pct': 93},
      {'name': 'SE', 'pct': 96},
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pass % by subject",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-Axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("100",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("75",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("50",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("25",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("0",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                  ],
                ),
                const SizedBox(width: 8),
                // Bars Row with Grid Lines
                Expanded(
                  child: Stack(
                    children: [
                      // Grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          5,
                          (i) => const Divider(
                            height: 1,
                            thickness: 0.8,
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                      ),
                      // Bars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: subjects.map((s) {
                          final double heightFactor = (s['pct'] as int) / 100.0;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 22,
                                height: 135 * heightFactor,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF161E4A),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(4),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                s['name'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Card 2: Active projects (Custom Line/Area Chart)
  Widget _buildActiveProjectsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Active projects",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-Axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("160",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("120",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("80",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("40",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                    Text("0",
                        style: GoogleFonts.poppins(
                            fontSize: 9.5, color: const Color(0xFF94A3B8))),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: CustomPaint(
                          size: Size.infinite,
                          painter: _AreaChartPainter(),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // X-Axis labels
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov']
                            .map((m) => Text(
                                  m,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF64748B),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Card 3: Needs your attention (3 items with colored left border)
  Widget _buildNeedsAttentionCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Needs your attention",
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          _buildAttentionItem(
            barColor: const Color(0xFFDC2626), // Red
            title: "Early-warning reviews (7)",
            subtitle: "Pending faculty/counsellor review",
            onTap: () => onOpenSubScreen(
              const HodStudentSuccessEarlyWarningScreen(),
              title: "Early Warning",
            ),
          ),
          const SizedBox(height: 12),
          _buildAttentionItem(
            barColor: const Color(0xFF1E2865), // Navy
            title: "Approve project reviews (12)",
            subtitle: "AI Project Review Board",
            onTap: () => onOpenSubScreen(
              const HodProjectReviewBoardScreen(),
              title: "Project Review Board",
            ),
          ),
          const SizedBox(height: 12),
          _buildAttentionItem(
            barColor: const Color(0xFF0D9488), // Teal
            title: "Department skill report",
            subtitle: "Ready to export",
            onTap: () => onOpenSubScreen(
              const HodSkillIntelligenceScreen(),
              title: "Skill Intelligence",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttentionItem({
    required Color barColor,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            // Colored left indicator bar
            Container(
              width: 3.5,
              height: 38,
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(2),
              ),
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
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 14,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. BOTTOM SECTION: AI INSIGHTS CARD (Image 1)
  // ---------------------------------------------------------------------------
  Widget _buildAiInsightsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with bulb and Evidence-linked badge
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Color(0xFFD97706),
                  size: 16,
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
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Evidence-linked",
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Insight 1
          _buildInsightBullet(
            bulletColor: const Color(0xFFDC2626), // Red
            title: "Theory of Computation failures rising",
            subtitle: "Failures increased for two consecutive semesters.",
            evidence: "Evidence: Sem 5: 7% → 11% → 14%",
          ),
          const SizedBox(height: 14),

          // Insight 2
          _buildInsightBullet(
            bulletColor: const Color(0xFFD97706), // Amber
            title: "Cloud skills gap",
            subtitle:
                "Cloud skills are in high demand but only 22% of final-year students are ready.",
            evidence: "Evidence: 146 job descriptions vs skill graph",
          ),
        ],
      ),
    );
  }

  Widget _buildInsightBullet({
    required Color bulletColor,
    required String title,
    required String subtitle,
    required String evidence,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: bulletColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
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
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                evidence,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom painter for Active projects line and area chart (Jun to Nov, 0 to 160)
class _AreaChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 5 Horizontal grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 0.8;

    for (int i = 0; i <= 4; i++) {
      final y = size.height * (i / 4.0);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Normalized points for Jun, Jul, Aug, Sep, Oct, Nov:
    // Values roughly: 82, 100, 115, 134, 148, 155 (out of 160)
    final values = [82.0, 100.0, 115.0, 134.0, 148.0, 155.0];
    final points = <Offset>[];
    for (int i = 0; i < values.length; i++) {
      final x = size.width * (i / (values.length - 1));
      final y = size.height * (1.0 - (values[i] / 160.0));
      points.add(Offset(x, y));
    }

    // Path for smooth line & gradient area
    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlPoint = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
      linePath.quadraticBezierTo(p0.dx, p0.dy, controlPoint.dx, controlPoint.dy);
    }
    linePath.lineTo(points.last.dx, points.last.dy);

    // Area fill
    final areaPath = Path.from(linePath);
    areaPath.lineTo(size.width, size.height);
    areaPath.lineTo(0, size.height);
    areaPath.close();

    final areaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF161E4A).withValues(alpha: 0.12),
          const Color(0xFF161E4A).withValues(alpha: 0.01),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(areaPath, areaPaint);

    // Line stroke
    final linePaint = Paint()
      ..color = const Color(0xFF161E4A)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
