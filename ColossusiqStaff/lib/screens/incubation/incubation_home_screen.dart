import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'incubation_pipeline_screen.dart';
import 'incubation_mentor_network_screen.dart';

// =============================================================================
// INCUBATION HEAD: DASHBOARD HOME SCREEN (Matches Image 1)
// - Top Greeting: "INCUBATION HEAD", "Good morning, Mr. Arjun Iyer · Innovation & Incubation"
// - 4 KPI Cards with colored top borders: Ideas submitted (41), Active ventures (11), Mentors (26), Funding-ready (3)
// - Middle Row:
//     * Pipeline by stage (Vertical bar chart: Idea 41, Validation 22, Model 11, MVP 8, Pitch 4, Incubated 2)
//     * Ventures by domain (Donut chart with legend: AgriTech, EdTech, HealthTech, ClimateTech)
//     * Needs your attention (Incubation review panel, Assign mentors)
// - Bottom Banner: AI insights (Evidence-linked, Validation bottleneck)
// =============================================================================

class IncubationHomeScreen extends StatelessWidget {
  final Function(Widget, {String? title, Widget? badge}) onOpenSubScreen;
  const IncubationHomeScreen({super.key, required this.onOpenSubScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Warm off-white canvas matching screenshot
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 1050;
          final isMedium = constraints.maxWidth >= 720;
          final horizPadding = constraints.maxWidth >= 1100
              ? 36.0
              : constraints.maxWidth >= 600
                  ? 24.0
                  : 16.0;

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(horizPadding, 24, horizPadding, 120),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HEADER SECTION (Image 1 - Fully responsive)
                _buildHeader(isWide, isMedium, constraints.maxWidth),
                const SizedBox(height: 22),

                // 2. TOP 4 KPI CARDS (Image 1)
                _buildKpiCards(isMedium, isWide),
                const SizedBox(height: 24),

                // 3. MIDDLE SECTION (Pipeline by stage, Ventures by domain, Needs your attention)
                _buildMiddleSection(context, isWide, isMedium),
                const SizedBox(height: 24),

                // 4. AI INSIGHTS CARD (Image 1)
                _buildAiInsightsCard(),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HEADER SECTION - Responsive across mobile, tablet & desktop
  // ===========================================================================
  Widget _buildHeader(bool isWide, bool isMedium, double maxWidth) {
    final isMobile = maxWidth < 640;

    final double categorySize = isWide ? 11.0 : (isMedium ? 10.5 : 10.0);
    final double titleSize = maxWidth >= 1200
        ? 24.0
        : (maxWidth >= 1050
            ? 22.0
            : (maxWidth >= 720
                ? 20.0
                : (maxWidth >= 480 ? 18.0 : 16.5)));
    final double subSize = isWide ? 13.5 : (isMedium ? 12.5 : 12.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INCUBATION HEAD',
          style: GoogleFonts.poppins(
            fontSize: categorySize,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
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
              'Good morning, Mr. Arjun Iyer',
              style: GoogleFonts.poppins(
                fontSize: titleSize,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
                letterSpacing: -0.3,
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
                  'Innovation & Incubation',
                  style: GoogleFonts.poppins(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.3,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: isMobile ? 4 : 5),
        Text(
          'Ideas, startups, hackathons, mentors and funding readiness.',
          style: GoogleFonts.poppins(
            fontSize: subSize,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF64748B),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 2. TOP 4 KPI METRIC CARDS
  // ===========================================================================
  Widget _buildKpiCards(bool isMedium, bool isWide) {
    final cards = [
      _buildStatCard(
        title: 'Ideas submitted',
        value: '41',
        topAccentColor: const Color(0xFF1E2865), // Navy
        icon: Icons.lightbulb_outline_rounded,
        iconBg: const Color(0xFFEEF2F6),
        iconColor: const Color(0xFF1E2865),
      ),
      _buildStatCard(
        title: 'Active ventures',
        value: '11',
        topAccentColor: const Color(0xFF0D9488), // Teal / Emerald
        icon: Icons.eco_outlined,
        iconBg: const Color(0xFFE6F4F1),
        iconColor: const Color(0xFF0D9488),
      ),
      _buildStatCard(
        title: 'Mentors',
        value: '26',
        topAccentColor: const Color(0xFFD97706), // Amber / Golden
        icon: Icons.psychology_outlined,
        iconBg: const Color(0xFFFEF3C7),
        iconColor: const Color(0xFFD97706),
      ),
      _buildStatCard(
        title: 'Funding-ready',
        value: '3',
        topAccentColor: const Color(0xFF2563EB), // Royal Blue
        icon: Icons.trending_up_rounded,
        iconBg: const Color(0xFFEFF6FF),
        iconColor: const Color(0xFF2563EB),
      ),
    ];

    if (isWide) {
      return Row(
        children: cards
            .map((card) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: card,
                  ),
                ))
            .toList(),
      );
    } else {
      // 2 columns, 2 rows (2x2 grid)
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 10),
              Expanded(child: cards[1]),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: cards[2]),
              const SizedBox(width: 10),
              Expanded(child: cards[3]),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color topAccentColor,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          // Top accent colored line
          Container(
            height: 3.5,
            decoration: BoxDecoration(
              color: topAccentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, size: 16, color: iconColor),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
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
  // 3. MIDDLE SECTION
  // ===========================================================================
  Widget _buildMiddleSection(BuildContext context, bool isWide, bool isMedium) {
    final pipelineCard = _buildPipelineCard();
    final domainCard = _buildDomainCard();
    final attentionCard = _buildAttentionCard(context);

    if (isWide) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 7, child: pipelineCard),
            const SizedBox(width: 14),
            Expanded(flex: 7, child: domainCard),
            const SizedBox(width: 14),
            Expanded(flex: 6, child: attentionCard),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          pipelineCard,
          const SizedBox(height: 16),
          domainCard,
          const SizedBox(height: 16),
          attentionCard,
        ],
      );
    }
  }

  // --- CARD 1: Pipeline by stage (Bar Chart) ---
  Widget _buildPipelineCard() {
    final stages = [
      {'label': 'Idea', 'count': 41},
      {'label': 'Validation', 'count': 22},
      {'label': 'Model', 'count': 11},
      {'label': 'MVP', 'count': 8},
      {'label': 'Pitch', 'count': 4},
      {'label': 'Incubated', 'count': 2},
    ];

    const double maxVal = 60.0;

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
            'Pipeline by stage',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 20),

          // Chart area with Y-axis & Bars
          SizedBox(
            height: 190,
            child: Row(
              children: [
                // Y-axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    _YTick(label: '60'),
                    _YTick(label: '45'),
                    _YTick(label: '30'),
                    _YTick(label: '15'),
                    _YTick(label: '0'),
                  ],
                ),
                const SizedBox(width: 8),

                // Chart Bars Area
                Expanded(
                  child: Stack(
                    children: [
                      // Grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(5, (_) {
                          return const Divider(
                            height: 1,
                            thickness: 0.8,
                            color: Color(0xFFF1F5F9),
                          );
                        }),
                      ),

                      // Bars
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: stages.map((s) {
                          final count = s['count'] as int;
                          final fraction = (count / maxVal).clamp(0.04, 1.0);

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Tooltip(
                                message: '${s['label']}: $count ventures',
                                child: Container(
                                  width: 28,
                                  height: 150 * fraction,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1E2865), // Dark Navy
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                s['label'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B),
                                  fontWeight: FontWeight.w500,
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

  // --- CARD 2: Ventures by domain (Donut Chart) ---
  Widget _buildDomainCard() {
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
            'Ventures by domain',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),

          // Donut Chart Container
          Center(
            child: SizedBox(
              height: 150,
              width: 240,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(140, 140),
                    painter: _DonutChartPainter(),
                  ),
                  // ClimateTech : 2 Tooltip pill (Image 1)
                  Positioned(
                    right: 6,
                    bottom: 22,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'ClimateTech : 2',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Legend
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 6,
            children: const [
              _LegendItem(color: Color(0xFF1E2865), label: 'AgriTech'),
              _LegendItem(color: Color(0xFFD97706), label: 'EdTech'),
              _LegendItem(color: Color(0xFF0D9488), label: 'HealthTech'),
              _LegendItem(color: Color(0xFF2563EB), label: 'ClimateTech'),
            ],
          ),
        ],
      ),
    );
  }

  // --- CARD 3: Needs your attention ---
  Widget _buildAttentionCard(BuildContext context) {
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
            'Needs your attention',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 18),

          // Item 1: Incubation review panel
          InkWell(
            onTap: () {
              onOpenSubScreen(
                IncubationPipelineScreen(onBack: () => Navigator.maybePop(context)),
                title: 'Incubation Pipeline',
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: const Border(
                  left: BorderSide(color: Color(0xFF1E2865), width: 3.5),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Incubation review panel',
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Nov 12 · 5 ventures',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
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
          ),
          const SizedBox(height: 12),

          // Item 2: Assign mentors
          InkWell(
            onTap: () {
              onOpenSubScreen(
                IncubationMentorNetworkScreen(onBack: () => Navigator.maybePop(context)),
                title: 'Mentor Network',
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: const Border(
                  left: BorderSide(color: Color(0xFFEA580C), width: 3.5),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assign mentors',
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '3 ventures without mentors',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
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
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. AI INSIGHTS CARD (Image 1)
  // ===========================================================================
  Widget _buildAiInsightsCard() {
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
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: Color(0xFFD97706),
                        size: 17,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'AI insights',
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
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
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Text(
                    'Evidence-linked',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEA580C),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Validation bottleneck',
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Half the ideas stall at problem validation. Customer-interview workshops are recommended.',
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Evidence: 41 → 22 ventures between stages',
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
            child: Text(
              'Insights support — not replace — human decisions.',
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: const Color(0xFF94A3B8),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// HELPER WIDGETS & PAINTERS
// =============================================================================

class _YTick extends StatelessWidget {
  final String label;
  const _YTick({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 10.5,
        color: const Color(0xFF94A3B8),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF475569),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 24.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Slices in percentages:
    // AgriTech (Dark Navy): 42%
    // EdTech (Amber): 25%
    // HealthTech (Teal): 18%
    // ClimateTech (Royal Blue): 15%
    final slices = [
      {'color': const Color(0xFF1E2865), 'sweep': 0.42 * 2 * math.pi},
      {'color': const Color(0xFFD97706), 'sweep': 0.25 * 2 * math.pi},
      {'color': const Color(0xFF0D9488), 'sweep': 0.18 * 2 * math.pi},
      {'color': const Color(0xFF2563EB), 'sweep': 0.15 * 2 * math.pi},
    ];

    double startAngle = -math.pi / 2;
    const gapAngle = 0.04;

    for (var slice in slices) {
      paint.color = slice['color'] as Color;
      final sweep = (slice['sweep'] as double) - gapAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle + gapAngle / 2,
        sweep,
        false,
        paint,
      );
      startAngle += (slice['sweep'] as double);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
