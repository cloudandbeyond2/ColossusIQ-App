import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PROJECT & INNOVATION: RESEARCH ASSISTANT SCREEN
// Exactly matches screenshot 1:
// - Blueprint grid hero banner with watermark & badges (PROJECT & INNOVATION, Phase 2)
// - Two-column responsive layout:
//     * Left Card: "Start a research project" with beaker icon pill, overview paragraph,
//       and literature citation guidance subtext
//     * Right Card: "New project" form with title/topic input, field input,
//       level & current stage dropdowns, optional goal textarea, and "+ Create project" button
// =============================================================================

class FacultyResearchAssistantScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyResearchAssistantScreen({super.key, this.onBack});

  @override
  State<FacultyResearchAssistantScreen> createState() =>
      _FacultyResearchAssistantScreenState();
}

class _FacultyResearchAssistantScreenState
    extends State<FacultyResearchAssistantScreen> {
  final TextEditingController _titleController = TextEditingController(
    text: "Low-cost IoT soil moisture sensing for far",
  );
  final TextEditingController _fieldController = TextEditingController(
    text: "Computer Science",
  );
  final TextEditingController _goalController = TextEditingController();

  String _selectedLevel = "Faculty";
  String _selectedStage = "Idea";

  final List<String> _levels = [
    "Faculty",
    "PhD",
    "Postgraduate",
    "Undergraduate",
  ];

  final List<String> _stages = [
    "Idea",
    "Literature review",
    "Drafting",
    "Completed",
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _fieldController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  void _createProject() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Research project \"$title\" created! Assistant work plan generated.",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color(0xFF1E2865),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

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

              // 2. Responsive Two-Column Layout
              if (isNarrow)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildOverviewCard(),
                    const SizedBox(height: 20),
                    _buildNewProjectFormCard(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 11,
                      child: _buildOverviewCard(),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 9,
                      child: _buildNewProjectFormCard(),
                    ),
                  ],
                ),
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
                  Icons.science_outlined,
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
                          "Research Assistant",
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
                          Icons.science_rounded,
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
                              "Research Assistant",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Research questions, literature discovery and comparison, planning and academic writing.",
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
  // 2. LEFT: START A RESEARCH PROJECT OVERVIEW CARD
  // ===========================================================================
  Widget _buildOverviewCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Beaker icon badge
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.science_outlined,
                size: 24,
                color: Color(0xFF4F46E5),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Title
          Text(
            "Start a research project",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),

          // Description Paragraph
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Text(
              "Save a project and the assistant works with it: sharper research questions, a search plan for the literature, a paper outline and a step-by-step work plan. Everything is saved for you, and you can keep several projects.",
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF475569),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 22),

          // Footnote
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Text(
              "The assistant cannot browse papers, so it never cites them. It writes search strings and you run them in Google Scholar, IEEE Xplore or Scopus.",
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF94A3B8),
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. RIGHT: NEW PROJECT FORM CARD
  // ===========================================================================
  Widget _buildNewProjectFormCard() {
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
            "New project",
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "You can change all of this later",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          // Project title or topic
          Text(
            "Project title or topic",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _titleController,
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: "e.g. Low-cost IoT soil moisture sensing for far",
              hintStyle: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF94A3B8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF4F46E5)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Field
          Text(
            "Field",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _fieldController,
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: "e.g. Computer Science",
              hintStyle: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF94A3B8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF4F46E5)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Level & Where are you now? (2 columns)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Level",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedLevel,
                          isExpanded: true,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: const Color(0xFF0F172A),
                          ),
                          items: _levels.map((l) {
                            return DropdownMenuItem(value: l, child: Text(l));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedLevel = val);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Where are you now?",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedStage,
                          isExpanded: true,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: const Color(0xFF0F172A),
                          ),
                          items: _stages.map((s) {
                            return DropdownMenuItem(value: s, child: Text(s));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedStage = val);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Goal (optional)
          Text(
            "Goal (optional)",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _goalController,
            maxLines: 3,
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF4F46E5)),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "For example: a conference paper, a final-year project, a thesis chapter.",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),

          // Action Button: + Create project
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _createProject,
              icon: const Icon(Icons.add_rounded, size: 16),
              label: Text(
                "Create project",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
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
