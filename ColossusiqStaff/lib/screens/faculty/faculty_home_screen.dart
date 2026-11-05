import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'my_classes_screen.dart';
import 'ai_evaluation_review_screen.dart';
import 'class_performance_screen.dart';
import 'faculty_skill_booster_screen.dart';
import 'question_paper_generator_screen.dart';
import 'faculty_ai_copilot_screen.dart';
import 'student_success_early_warning_screen.dart';

// =============================================================================
// FACULTY HOME DASHBOARD (Matches Modern Faculty Copilot Design)
// =============================================================================
class FacultyHomeScreen extends StatelessWidget {
  final Function(Widget, {String? title, Widget? badge}) onOpenSubScreen;
  const FacultyHomeScreen({super.key, required this.onOpenSubScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 980;
        final isTablet = constraints.maxWidth >= 640 && constraints.maxWidth < 980;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            isDesktop ? 28 : (isTablet ? 20 : 16),
            22,
            isDesktop ? 28 : (isTablet ? 20 : 16),
            120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Section (Fully responsive)
              _buildHeader(isDesktop, isTablet, constraints.maxWidth),
              const SizedBox(height: 22),

              // 2. Top Stats Cards (4 Cards)
              _buildStatsRow(isDesktop, isTablet),
              const SizedBox(height: 22),

              // 3. Middle Section: Topic Mastery, Class Average Trend, Needs Attention
              _buildMiddleSection(isDesktop, isTablet),
              const SizedBox(height: 22),

              // 4. Bottom Section: AI Insights
              _buildAiInsightsCard(),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER - Responsive across mobile, tablet & desktop
  // ---------------------------------------------------------------------------
  Widget _buildHeader(bool isDesktop, bool isTablet, double maxWidth) {
    final isMobile = maxWidth < 640;

    final double categorySize = isDesktop ? 11.0 : (isTablet ? 10.5 : 10.0);
    final double titleSize = maxWidth >= 1200
        ? 26.0
        : (maxWidth >= 980
            ? 23.0
            : (maxWidth >= 768
                ? 21.0
                : (maxWidth >= 480 ? 19.0 : 17.5)));
    final double subSize = isDesktop ? 13.5 : (isTablet ? 12.5 : 12.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "FACULTY",
          style: GoogleFonts.poppins(
            fontSize: categorySize,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.3,
            color: const Color(0xFF64748B),
          ),
        ),
        SizedBox(height: isMobile ? 4 : 6),
        Text(
          "Good morning, Dr. Meena Raghavan",
          style: GoogleFonts.poppins(
            fontSize: titleSize,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF0F172A),
            letterSpacing: -0.5,
            height: 1.25,
          ),
        ),
        SizedBox(height: isMobile ? 4 : 5),
        Text(
          "Teaching copilot, assessments, evaluation and skill development.",
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
  // STATS CARDS ROW
  // ---------------------------------------------------------------------------
  Widget _buildStatsRow(bool isDesktop, bool isTablet) {
    final cards = [
      _FacultyStatCard(
        accentColor: const Color(0xFF243B6B),
        title: "Classes today",
        value: "3",
        subtitle: "CSE-A, CSE-B, AI&DS lab",
        icon: Icons.auto_stories_outlined,
        iconBgColor: const Color(0xFFEEF2FF),
        iconColor: const Color(0xFF3B82F6),
        onTap: () => onOpenSubScreen(const MyClassesScreen(), title: "My Classes"),
      ),
      _FacultyStatCard(
        accentColor: const Color(0xFFC26118),
        title: "Answers to review",
        value: "14",
        badgeText: "AI pre-evaluated",
        icon: Icons.warning_amber_rounded,
        iconBgColor: const Color(0xFFFEF3C7),
        iconColor: const Color(0xFFD97706),
        onTap: () => onOpenSubScreen(const AiEvaluationReviewScreen(), title: "AI Evaluation Review"),
      ),
      _FacultyStatCard(
        accentColor: const Color(0xFF0F766E),
        title: "Class average (DBMS)",
        value: "68%",
        badgeText: "+4% vs IA1",
        icon: Icons.menu_book_rounded,
        iconBgColor: const Color(0xFFCCFBF1),
        iconColor: const Color(0xFF0F766E),
        onTap: () => onOpenSubScreen(const ClassPerformanceScreen(), title: "Class Performance"),
      ),
      _FacultyStatCard(
        accentColor: const Color(0xFFCA8A04),
        title: "Skill Booster",
        value: "Week 5/12",
        badgeText: "AI for Teaching",
        icon: Icons.show_chart_rounded,
        iconBgColor: const Color(0xFFFEF3C7),
        iconColor: const Color(0xFFCA8A04),
        onTap: () => onOpenSubScreen(const FacultySkillBoosterScreen(), title: "Skill Booster"),
      ),
    ];

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards.map((c) => Expanded(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: c,
        ))).toList(),
      );
    } else if (isTablet) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 12),
              Expanded(child: cards[1]),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: cards[2]),
              const SizedBox(width: 12),
              Expanded(child: cards[3]),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: cards.map((c) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: c,
        )).toList(),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // MIDDLE SECTION: 3 CARDS
  // ---------------------------------------------------------------------------
  Widget _buildMiddleSection(bool isDesktop, bool isTablet) {
    final masteryCard = _buildTopicMasteryCard();
    final trendCard = _buildClassAverageTrendCard();
    final attentionCard = _buildNeedsAttentionCard();

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: masteryCard),
          const SizedBox(width: 16),
          Expanded(flex: 3, child: trendCard),
          const SizedBox(width: 16),
          Expanded(flex: 3, child: attentionCard),
        ],
      );
    } else if (isTablet) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: masteryCard),
              const SizedBox(width: 16),
              Expanded(child: trendCard),
            ],
          ),
          const SizedBox(height: 16),
          attentionCard,
        ],
      );
    } else {
      return Column(
        children: [
          masteryCard,
          const SizedBox(height: 16),
          trendCard,
          const SizedBox(height: 16),
          attentionCard,
        ],
      );
    }
  }

  // Topic Mastery Card
  Widget _buildTopicMasteryCard() {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Topic mastery – CSE-A",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 210,
            child: _TopicMasteryBarChart(),
          ),
        ],
      ),
    );
  }

  // Class Average Trend Card
  Widget _buildClassAverageTrendCard() {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Class average trend",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 185,
            child: _ClassAverageTrendChart(),
          ),
          const SizedBox(height: 10),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E293B),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "CSE-A",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFD97706),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "CSE-B",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Needs Your Attention Card
  Widget _buildNeedsAttentionCard() {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Needs your attention",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          _AttentionActionRow(
            indicatorColor: const Color(0xFFEA580C),
            title: "Review AI-evaluated answers (14)",
            subtitle: "DBMS IA-I • 3 flagged low confidence",
            onTap: () => onOpenSubScreen(
              const AiEvaluationReviewScreen(),
              title: "AI Evaluation Review",
            ),
          ),
          const SizedBox(height: 14),
          _AttentionActionRow(
            indicatorColor: const Color(0xFF1E293B),
            title: "Generate IA-II question paper",
            subtitle: "Due Friday",
            onTap: () => onOpenSubScreen(
              const QuestionPaperGeneratorScreen(),
              title: "Question Paper Generator",
            ),
          ),
          const SizedBox(height: 14),
          _AttentionActionRow(
            indicatorColor: const Color(0xFF059669),
            title: "Lesson plan: BCNF",
            subtitle: "Tomorrow, CSE-A",
            onTap: () => onOpenSubScreen(
              const FacultyAiCopilotScreen(),
              title: "Faculty AI Copilot",
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // AI INSIGHTS BOTTOM CARD
  // ---------------------------------------------------------------------------
  Widget _buildAiInsightsCard() {
    return _DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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
                      size: 19,
                      color: Color(0xFFD97706),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "AI insights",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  "Evidence-linked",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Insight 1
          _InsightItem(
            title: "Remedial recap suggested",
            description:
                "18 students missed the lossless-join property on IA1 Q5. A 15-minute recap is recommended before IA2.",
            evidence: "Evidence: IA1 rubric criterion 3 • 18/64 scored 0",
            onTap: () => onOpenSubScreen(
              const FacultyAiCopilotScreen(),
              title: "Remedial Plan Copilot",
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(color: Color(0xFFF1F5F9), height: 1),
          ),

          // Insight 2
          _InsightItem(
            title: "6 support recommendations",
            description:
                "Six students show declining scores across three assessments. Review before contacting them.",
            evidence: "Evidence: Student Success Agent • last 4 weeks",
            onTap: () => onOpenSubScreen(
              const StudentSuccessEarlyWarningScreen(),
              title: "Early Warning & Student Success",
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

// =============================================================================
// REUSABLE DASHBOARD CARD CONTAINER
// =============================================================================
class _DashboardCard extends StatelessWidget {
  final Widget child;
  const _DashboardCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

// =============================================================================
// STAT CARD WITH TOP ACCENT BORDER & BADGE
// =============================================================================
class _FacultyStatCard extends StatelessWidget {
  final Color accentColor;
  final String title;
  final String value;
  final String? subtitle;
  final String? badgeText;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _FacultyStatCard({
    required this.accentColor,
    required this.title,
    required this.value,
    this.subtitle,
    this.badgeText,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top colored accent strip
              Container(
                height: 4,
                width: double.infinity,
                color: accentColor,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
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
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: iconBgColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(icon, size: 19, color: iconColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (badgeText != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.north_east_rounded,
                              size: 11,
                              color: Color(0xFF15803D),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              badgeText!,
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF15803D),
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (subtitle != null)
                      Text(
                        subtitle!,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
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
}

// =============================================================================
// NEEDS ATTENTION ACTION ROW
// =============================================================================
class _AttentionActionRow extends StatelessWidget {
  final Color indicatorColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AttentionActionRow({
    required this.indicatorColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left indicator vertical bar
            Container(
              width: 3.5,
              height: 38,
              decoration: BoxDecoration(
                color: indicatorColor,
                borderRadius: BorderRadius.circular(2),
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
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 16,
              color: Color(0xFF64748B),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// AI INSIGHT ITEM
// =============================================================================
class _InsightItem extends StatelessWidget {
  final String title;
  final String description;
  final String evidence;
  final VoidCallback onTap;

  const _InsightItem({
    required this.title,
    required this.description,
    required this.evidence,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: Color(0xFFEA580C),
                shape: BoxShape.circle,
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
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF475569),
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    evidence,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// TOPIC MASTERY BAR CHART (CUSTOM PAINTER)
// =============================================================================
class _TopicMasteryBarChart extends StatelessWidget {
  const _TopicMasteryBarChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _TopicMasteryChartPainter(),
    );
  }
}

class _TopicMasteryChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> items = const [
    {"label": "ER", "value": 78},
    {"label": "SQL", "value": 74},
    {"label": "FDs", "value": 61},
    {"label": "3NF", "value": 52},
    {"label": "BCNF", "value": 47},
    {"label": "ACID", "value": 69},
  ];

  @override
  void paint(Canvas canvas, Size size) {
    const leftMargin = 32.0;
    const bottomMargin = 26.0;
    const topMargin = 10.0;
    const rightMargin = 10.0;

    final chartWidth = size.width - leftMargin - rightMargin;
    final chartHeight = size.height - topMargin - bottomMargin;

    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    final barPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;

    // Y Axis levels: 0, 20, 40, 60, 80
    final levels = [80, 60, 40, 20, 0];
    for (int i = 0; i < levels.length; i++) {
      final y = topMargin + (i * chartHeight / (levels.length - 1));

      // Draw horizontal grid line
      canvas.drawLine(
        Offset(leftMargin, y),
        Offset(size.width - rightMargin, y),
        gridPaint,
      );

      // Draw Y label
      final tp = TextPainter(
        text: TextSpan(
          text: levels[i].toString(),
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: const Color(0xFF94A3B8),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(leftMargin - tp.width - 8, y - tp.height / 2));
    }

    // Bars
    final barCount = items.length;
    final totalSlotWidth = chartWidth / barCount;
    final barWidth = (totalSlotWidth * 0.55).clamp(18.0, 32.0);

    for (int i = 0; i < barCount; i++) {
      final item = items[i];
      final val = (item["value"] as num).toDouble();
      final barH = (val / 80.0) * chartHeight;
      final xCenter = leftMargin + (i * totalSlotWidth) + (totalSlotWidth / 2);
      final left = xCenter - (barWidth / 2);
      final top = topMargin + chartHeight - barH;

      final rect = Rect.fromLTWH(left, top, barWidth, barH);
      final rrect = RRect.fromRectAndCorners(
        rect,
        topLeft: const Radius.circular(5),
        topRight: const Radius.circular(5),
      );
      canvas.drawRRect(rrect, barPaint);

      // Label below bar
      final labelTp = TextPainter(
        text: TextSpan(
          text: item["label"] as String,
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF64748B),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      labelTp.paint(
        canvas,
        Offset(xCenter - (labelTp.width / 2), size.height - bottomMargin + 6),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// CLASS AVERAGE TREND LINE CHART (CUSTOM PAINTER)
// =============================================================================
class _ClassAverageTrendChart extends StatelessWidget {
  const _ClassAverageTrendChart();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _ClassAverageTrendPainter(),
    );
  }
}

class _ClassAverageTrendPainter extends CustomPainter {
  final List<String> months = const ["Jun", "Jul", "Aug", "Sep", "Oct", "Nov"];
  // Values out of 80 scale
  final List<double> cseA = const [60, 61, 63, 65, 67, 70];
  final List<double> cseB = const [58, 59, 61, 62, 63, 66];

  @override
  void paint(Canvas canvas, Size size) {
    const leftMargin = 32.0;
    const bottomMargin = 24.0;
    const topMargin = 10.0;
    const rightMargin = 12.0;

    final chartWidth = size.width - leftMargin - rightMargin;
    final chartHeight = size.height - topMargin - bottomMargin;

    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    final linePaintA = Paint()
      ..color = const Color(0xFF1E293B)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final linePaintB = Paint()
      ..color = const Color(0xFFD97706)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Y Axis levels: 80, 60, 40, 20, 0
    final levels = [80, 60, 40, 20, 0];
    for (int i = 0; i < levels.length; i++) {
      final y = topMargin + (i * chartHeight / (levels.length - 1));

      // Draw horizontal line
      canvas.drawLine(
        Offset(leftMargin, y),
        Offset(size.width - rightMargin, y),
        gridPaint,
      );

      // Label
      final tp = TextPainter(
        text: TextSpan(
          text: levels[i].toString(),
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: const Color(0xFF94A3B8),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(leftMargin - tp.width - 8, y - tp.height / 2));
    }

    // X Axis Months
    final pointCount = months.length;
    final slotWidth = chartWidth / (pointCount - 1);

    for (int i = 0; i < pointCount; i++) {
      final x = leftMargin + (i * slotWidth);
      final labelTp = TextPainter(
        text: TextSpan(
          text: months[i],
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: const Color(0xFF94A3B8),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      labelTp.paint(
        canvas,
        Offset(x - (labelTp.width / 2), size.height - bottomMargin + 6),
      );
    }

    // Path A (CSE-A)
    final pathA = Path();
    for (int i = 0; i < pointCount; i++) {
      final x = leftMargin + (i * slotWidth);
      final y = topMargin + chartHeight - ((cseA[i] / 80.0) * chartHeight);
      if (i == 0) {
        pathA.moveTo(x, y);
      } else {
        pathA.lineTo(x, y);
      }
    }
    canvas.drawPath(pathA, linePaintA);

    // Path B (CSE-B)
    final pathB = Path();
    for (int i = 0; i < pointCount; i++) {
      final x = leftMargin + (i * slotWidth);
      final y = topMargin + chartHeight - ((cseB[i] / 80.0) * chartHeight);
      if (i == 0) {
        pathB.moveTo(x, y);
      } else {
        pathB.lineTo(x, y);
      }
    }
    canvas.drawPath(pathB, linePaintB);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
