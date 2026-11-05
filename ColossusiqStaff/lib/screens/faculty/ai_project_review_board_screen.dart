import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PROJECT & INNOVATION: AI PROJECT REVIEW BOARD SCREEN
// Exactly matches screenshots 2 & 3:
// - Blueprint grid hero banner with watermark & badges (PROJECT & INNOVATION, Phase 2)
// - Top Project Selector Card:
//     * "DEPARTMENT PROJECTS EVALUATION 2 Total Projects"
//     * Subtitle: "Select a student project to review AI evaluation & faculty rubric scorecards:"
//     * Dropdown: "Smart Campus AI (AI Review · 80%)"
//     * Team & Mentor row with "Stage: AI Review (80%)" and "Grade in Project Hub >" link
// - Two-Column Middle Section:
//     * Left Card: "Smart Campus AI — review report" with custom Radar/Spider Chart (6 vertices) & Legend (● Current, ● Target)
//     * Right Card: "Dimensions Overall 74%" with 6 dimension progress bars and target markers (Architecture, Documentation, Code quality, Test coverage, Innovation, Presentation)
// - Bottom 3-Card Row (Screenshot 3):
//     * "Strengths" with verified check badges
//     * "Gaps" with warning check badges
//     * "Improvement plan" with numbered action steps
// =============================================================================

class AiProjectReviewBoardScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AiProjectReviewBoardScreen({super.key, this.onBack});

  @override
  State<AiProjectReviewBoardScreen> createState() =>
      _AiProjectReviewBoardScreenState();
}

class _AiProjectReviewBoardScreenState
    extends State<AiProjectReviewBoardScreen> {
  String _selectedProject = "Smart Campus AI (AI Review · 80%)";

  final List<String> _projects = [
    "Smart Campus AI (AI Review · 80%)",
    "AgriSoil Sense — low-cost soil health kit (Architecture · 30%)",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 950;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. Department Projects Evaluation Selector
              _buildSelectorCard(),
              const SizedBox(height: 18),

              // 3. Middle Section: Radar Chart + Dimensions
              if (isNarrow)
                Column(
                  children: [
                    _buildRadarChartCard(),
                    const SizedBox(height: 18),
                    _buildDimensionsCard(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 11,
                      child: _buildRadarChartCard(),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      flex: 10,
                      child: _buildDimensionsCard(),
                    ),
                  ],
                ),
              const SizedBox(height: 18),

              // 4. Bottom 3 Cards: Strengths, Gaps, Improvement plan
              _buildBottomInsightCards(),
            ],
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
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF141A46),
            Color(0xFF1E2865),
            Color(0xFF283685),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141A46).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: 25,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.assignment_outlined,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs (clean, no leading arrow)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            "Home",
                            style: GoogleFonts.poppins(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "Project & Innovation",
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "AI Project Review Board",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges Row
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildPillBadge(
                        "PROJECT & INNOVATION",
                        const Color(0xFF232D60),
                        Colors.white,
                      ),
                      _buildPillBadge(
                        "Phase 2",
                        const Color(0xFFD97706),
                        Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Icon + Title + Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232F6E),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: const Icon(
                          Icons.assignment_outlined,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "AI Project Review Board",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Architecture, documentation, code quality, tests, innovation and risk review for faculty.",
                              style: GoogleFonts.poppins(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 13,
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

  Widget _buildPillBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: text,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. PROJECT EVALUATION SELECTOR CARD
  // ===========================================================================
  Widget _buildSelectorCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBF7),
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
          // Top Row: Badge + Dropdown
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Text(
                    "DEPARTMENT PROJECTS EVALUATION",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F766E),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCFBF1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "2 Total Projects",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                  ),
                ],
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedProject,
                      isExpanded: true,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                      items: _projects.map((p) {
                        return DropdownMenuItem(
                          value: p,
                          child: Text(
                            p,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedProject = val);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Text(
            "Select a student project to review AI evaluation & faculty rubric scorecards:",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF334155),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          // Team line and Grade in Project Hub button (Responsive)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.people_outline_rounded,
                      size: 16,
                      color: Color(0xFF0F766E),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF475569),
                        ),
                        children: [
                          TextSpan(
                            text: "Team: ",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                            ),
                          ),
                          const TextSpan(
                            text:
                                "Anand Kumar, Divya Raman, Karthik Iyer · Mentor: Dr. Meena Raghavan",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: [
                  Text(
                    "Stage: AI Review (80%)",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFD97706),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Navigating to Project Hub grading desk...",
                            style: GoogleFonts.poppins(),
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Grade in Project Hub",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 14,
                            color: Color(0xFF0F766E),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. MIDDLE: RADAR CHART CARD
  // ===========================================================================
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
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Smart Campus AI — review report",
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Dimension-level view — no single number decides outcomes",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          // Custom Radar Chart Canvas
          Center(
            child: SizedBox(
              width: 320,
              height: 290,
              child: CustomPaint(
                painter: _SpiderRadarPainter(
                  dimensions: const [
                    "Architecture",
                    "Documentation",
                    "Code quality",
                    "Test coverage",
                    "Innovation",
                    "Presentation",
                  ],
                  currentScores: const [82, 64, 76, 58, 88, 74],
                  targetScores: const [75, 75, 75, 70, 70, 75],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendDot(const Color(0xFF1E2865), "Current"),
              const SizedBox(width: 24),
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
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. MIDDLE: DIMENSIONS PROGRESS BARS CARD
  // ===========================================================================
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
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dimensions",
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Overall 74%",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),

          _buildDimensionBar("Architecture", 82, 75, const Color(0xFF0F766E)),
          const SizedBox(height: 14),
          _buildDimensionBar("Documentation", 64, 75, const Color(0xFF1E2865)),
          const SizedBox(height: 14),
          _buildDimensionBar("Code quality", 76, 75, const Color(0xFF0F766E)),
          const SizedBox(height: 14),
          _buildDimensionBar("Test coverage", 58, 70, const Color(0xFF1E2865)),
          const SizedBox(height: 14),
          _buildDimensionBar("Innovation", 88, 70, const Color(0xFF0F766E)),
          const SizedBox(height: 14),
          _buildDimensionBar("Presentation", 74, 75, const Color(0xFF1E2865)),
        ],
      ),
    );
  }

  Widget _buildDimensionBar(
      String label, int current, int target, Color barColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$current ",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  TextSpan(
                    text: "/ target $target",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Progress bar with target vertical line
        LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth = constraints.maxWidth;
            final currentFactor = (current / 100.0).clamp(0.0, 1.0);
            final targetX = (target / 100.0) * totalWidth;

            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                // Background Track
                Container(
                  width: totalWidth,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                // Current Fill Bar
                Container(
                  width: totalWidth * currentFactor,
                  height: 5,
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                // Target Marker Line
                Positioned(
                  left: targetX,
                  top: -2.5,
                  bottom: -2.5,
                  child: Container(
                    width: 2,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // 5. BOTTOM SECTION: 3 CARDS (STRENGTHS, GAPS, IMPROVEMENT PLAN)
  // ===========================================================================
  Widget _buildBottomInsightCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;
        if (isNarrow) {
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
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildStrengthsCard()),
            const SizedBox(width: 18),
            Expanded(child: _buildGapsCard()),
            const SizedBox(width: 18),
            Expanded(child: _buildImprovementPlanCard()),
          ],
        );
      },
    );
  }

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
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Strengths",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          _buildInsightBullet(
            icon: Icons.check_circle_outline_rounded,
            iconColor: const Color(0xFF0F766E),
            text: "High innovation index (88%) in AI/ML · IoT",
          ),
          const SizedBox(height: 12),
          _buildInsightBullet(
            icon: Icons.check_circle_outline_rounded,
            iconColor: const Color(0xFF0F766E),
            text: "Robust modular system architecture verified",
          ),
        ],
      ),
    );
  }

  Widget _buildGapsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
            "Gaps",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          _buildInsightBullet(
            icon: Icons.check_circle_outline_rounded,
            iconColor: const Color(0xFFD97706),
            text: "Automated test coverage is at 58% (target 75%)",
          ),
          const SizedBox(height: 12),
          _buildInsightBullet(
            icon: Icons.check_circle_outline_rounded,
            iconColor: const Color(0xFFD97706),
            text: "Architecture documentation requires updated IEEE citations",
          ),
        ],
      ),
    );
  }

  Widget _buildImprovementPlanCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
            "Improvement plan",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),
          _buildNumberedStep(
            number: "1",
            text: "Verify edge telemetry and battery failover bench tests",
          ),
          const SizedBox(height: 12),
          _buildNumberedStep(
            number: "2",
            text: "Rehearse capstone defense with AI Viva Simulator",
          ),
        ],
      ),
    );
  }

  Widget _buildInsightBullet({
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
              fontSize: 12,
              color: const Color(0xFF334155),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberedStep({
    required String number,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF4F46E5),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF334155),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// SPIDER RADAR CHART CUSTOM PAINTER
// =============================================================================
class _SpiderRadarPainter extends CustomPainter {
  final List<String> dimensions;
  final List<int> currentScores;
  final List<int> targetScores;

  _SpiderRadarPainter({
    required this.dimensions,
    required this.currentScores,
    required this.targetScores,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.36;
    final count = dimensions.length;
    final angleStep = (2 * math.pi) / count;

    // 1. Draw 3 concentric polygon webs
    final webPaint = Paint()
      ..color = const Color(0xFFCBD5E1).withValues(alpha: 0.6)
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;

    final levels = [0.33, 0.66, 1.0];
    for (final level in levels) {
      final path = Path();
      for (int i = 0; i < count; i++) {
        final angle = -math.pi / 2 + i * angleStep;
        final x = center.dx + radius * level * math.cos(angle);
        final y = center.dy + radius * level * math.sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, webPaint);
    }

    // 2. Draw radial lines from center to outer points
    for (int i = 0; i < count; i++) {
      final angle = -math.pi / 2 + i * angleStep;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), webPaint);
    }

    // 3. Draw Target polygon (Amber/Gold outline with light tint)
    final targetPath = Path();
    for (int i = 0; i < count; i++) {
      final angle = -math.pi / 2 + i * angleStep;
      final factor = (targetScores[i] / 100.0).clamp(0.0, 1.0);
      final x = center.dx + radius * factor * math.cos(angle);
      final y = center.dy + radius * factor * math.sin(angle);
      if (i == 0) {
        targetPath.moveTo(x, y);
      } else {
        targetPath.lineTo(x, y);
      }
    }
    targetPath.close();

    final targetFill = Paint()
      ..color = const Color(0xFFD97706).withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    final targetStroke = Paint()
      ..color = const Color(0xFFD97706)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    canvas.drawPath(targetPath, targetFill);
    canvas.drawPath(targetPath, targetStroke);

    // 4. Draw Current polygon (Navy/Indigo)
    final currentPath = Path();
    for (int i = 0; i < count; i++) {
      final angle = -math.pi / 2 + i * angleStep;
      final factor = (currentScores[i] / 100.0).clamp(0.0, 1.0);
      final x = center.dx + radius * factor * math.cos(angle);
      final y = center.dy + radius * factor * math.sin(angle);
      if (i == 0) {
        currentPath.moveTo(x, y);
      } else {
        currentPath.lineTo(x, y);
      }
    }
    currentPath.close();

    final currentFill = Paint()
      ..color = const Color(0xFF1E2865).withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    final currentStroke = Paint()
      ..color = const Color(0xFF1E2865)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawPath(currentPath, currentFill);
    canvas.drawPath(currentPath, currentStroke);

    // 5. Draw Dimension Labels around perimeter
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i < count; i++) {
      final angle = -math.pi / 2 + i * angleStep;
      final labelDist = radius + 24;
      final x = center.dx + labelDist * math.cos(angle);
      final y = center.dy + labelDist * math.sin(angle);

      textPainter.text = TextSpan(
        text: dimensions[i],
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF475569),
        ),
      );
      textPainter.layout();

      // Adjust offset based on quadrant
      double dx = x - textPainter.width / 2;
      double dy = y - textPainter.height / 2;
      textPainter.paint(canvas, Offset(dx, dy));
    }
  }

  @override
  bool shouldRepaint(covariant _SpiderRadarPainter oldDelegate) => true;
}

// =============================================================================
// GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) {
    return oldDelegate.gridColor != gridColor || oldDelegate.step != step;
  }
}
