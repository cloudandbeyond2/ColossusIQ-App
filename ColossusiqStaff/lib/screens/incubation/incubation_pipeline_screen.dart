import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INCUBATION HEAD: INCUBATION PIPELINE SCREEN (Matches Image 1)
// - Blueprint Hero Banner: "Home > Incubation > Incubation Pipeline", badges INCUBATION, Phase 2
// - Left Card: "Incubation pipeline — 2026 cohort", "6 of 11 stages complete"
//   Vertical pipeline stepper:
//   1. Idea (41 submissions, Screened by Incubation Agent + panel)
//   2. Problem validation (22 ventures)
//   3. Market analysis (15 ventures)
//   4. Customer persona (15 ventures)
//   5. Business model (11 ventures)
//   6. MVP (8 ventures)
//   7. Mentor (Current badge, 8 ventures matched)
//   8. Prototype (6 ventures)
//   9. Pitch deck (4 ventures)
//   10. Incubation review panel (2 ventures)
//   11. Incubated (2 ventures)
// - Right Column:
//   * Overall progress card (55%, progress bar)
//   * Information card: "Each stage can be supported by an AI agent, but stage approvals are made by your mentor or faculty."
// =============================================================================

class IncubationPipelineScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const IncubationPipelineScreen({super.key, this.onBack});

  @override
  State<IncubationPipelineScreen> createState() =>
      _IncubationPipelineScreenState();
}

class _IncubationPipelineScreenState extends State<IncubationPipelineScreen> {
  final List<Map<String, dynamic>> _stages = [
    {
      'title': 'Idea',
      'count': '41 submissions',
      'isCompleted': true,
      'isCurrent': false,
      'badge': 'Screened by Incubation Agent + panel',
    },
    {
      'title': 'Problem validation',
      'count': '22 ventures',
      'isCompleted': true,
      'isCurrent': false,
    },
    {
      'title': 'Market analysis',
      'count': '15 ventures',
      'isCompleted': true,
      'isCurrent': false,
    },
    {
      'title': 'Customer persona',
      'count': '15 ventures',
      'isCompleted': true,
      'isCurrent': false,
    },
    {
      'title': 'Business model',
      'count': '11 ventures',
      'isCompleted': true,
      'isCurrent': false,
    },
    {
      'title': 'MVP',
      'count': '8 ventures',
      'isCompleted': true,
      'isCurrent': false,
    },
    {
      'title': 'Mentor',
      'count': '8 ventures matched',
      'isCompleted': false,
      'isCurrent': true,
      'badge': 'Current',
    },
    {
      'title': 'Prototype',
      'count': '6 ventures',
      'isCompleted': false,
      'isCurrent': false,
    },
    {
      'title': 'Pitch deck',
      'count': '4 ventures',
      'isCompleted': false,
      'isCurrent': false,
    },
    {
      'title': 'Incubation review panel',
      'count': '2 ventures',
      'isCompleted': false,
      'isCurrent': false,
    },
    {
      'title': 'Incubated',
      'count': '2 ventures',
      'isCompleted': false,
      'isCurrent': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 960;
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
                const SizedBox(height: 20),

                // 2. MAIN SPLIT CONTENT: Pipeline Stepper + Progress / Info Cards
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: Pipeline Stepper Card
                      Expanded(
                        flex: 7,
                        child: _buildPipelineStepperCard(),
                      ),
                      const SizedBox(width: 20),

                      // Right: Progress Card + Info Note
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            _buildProgressCard(),
                            const SizedBox(height: 16),
                            _buildInfoCard(),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildProgressCard(),
                      const SizedBox(height: 16),
                      _buildInfoCard(),
                      const SizedBox(height: 20),
                      _buildPipelineStepperCard(),
                    ],
                  ),
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
        gradient: const LinearGradient(
          colors: [Color(0xFF131B4D), Color(0xFF1D2866), Color(0xFF273680)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Technical Blueprint Grid Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),

            // Decorative outline rocket on right (Image 1)
            Positioned(
              right: 18,
              top: 6,
              bottom: 6,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  size: 96,
                  color: Colors.white,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs & Back
                  Row(
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
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        'Home',
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
                        'Incubation',
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
                        'Incubation Pipeline',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Badges: INCUBATION, Phase 2
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
                          'INCUBATION',
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
                  const SizedBox(height: 12),

                  // Icon + Title & Subtitle
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
                        child: const Icon(
                          Icons.rocket_launch_rounded,
                          color: Color(0xFFFBBF24), // Gold Rocket (Image 1)
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Incubation Pipeline',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Idea → validation → market → business model → MVP → pitch → incubation review.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFFCBD5E1),
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
  // 2. LEFT: PIPELINE STEPPER CARD (Image 1)
  // ===========================================================================
  Widget _buildPipelineStepperCard() {
    return Container(
      padding: const EdgeInsets.all(24),
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
            'Incubation pipeline — 2026 cohort',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '6 of 11 stages complete',
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 24),

          // Stepper List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _stages.length,
            itemBuilder: (context, index) {
              final stage = _stages[index];
              final isLast = index == _stages.length - 1;
              final isCompleted = stage['isCompleted'] as bool;
              final isCurrent = stage['isCurrent'] as bool;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Indicator Column (Circle + Vertical Line)
                    Column(
                      children: [
                        // Circle Indicator
                        if (isCompleted)
                          Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0D9488), // Teal/Green
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.check, size: 14, color: Colors.white),
                            ),
                          )
                        else if (isCurrent)
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFD97706), // Amber
                                width: 2,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.auto_awesome_rounded,
                                size: 12,
                                color: Color(0xFFD97706),
                              ),
                            ),
                          )
                        else
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFCBD5E1),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFCBD5E1),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),

                        // Vertical connecting line
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: isCompleted
                                  ? const Color(0xFF0D9488)
                                  : isCurrent
                                      ? const Color(0xFFD97706)
                                      : const Color(0xFFE2E8F0),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 14),

                    // Stage content details
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                Text(
                                  stage['title'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.5,
                                    fontWeight: isCurrent
                                        ? FontWeight.w700
                                        : isCompleted
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                    color: isCurrent
                                        ? const Color(0xFF0F172A)
                                        : isCompleted
                                            ? const Color(0xFF0F172A)
                                            : const Color(0xFF64748B),
                                  ),
                                ),
                                if (isCurrent)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 1.5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEF3C7),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Current',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFD97706),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              stage['count'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),

                            // Optional Sub-Badge (like "Screened by Incubation Agent + panel")
                            if (stage['badge'] != null && !isCurrent) ...[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                  ),
                                ),
                                child: Text(
                                  stage['badge'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF475569),
                                  ),
                                ),
                              ),
                            ],
                          ],
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

  // ===========================================================================
  // 3. RIGHT: PROGRESS CARD (Image 1)
  // ===========================================================================
  Widget _buildProgressCard() {
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
            'Overall progress',
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '55%',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: const LinearProgressIndicator(
              value: 0.55,
              backgroundColor: Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF0D9488), // Teal progress bar (Image 1)
              ),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. RIGHT: INFO CARD (Image 1)
  // ===========================================================================
  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // Light blue
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: Color(0xFF1E40AF),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Each stage can be supported by an AI agent, but stage approvals are made by your mentor or faculty.',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF1E3A8A),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT GRID PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

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
