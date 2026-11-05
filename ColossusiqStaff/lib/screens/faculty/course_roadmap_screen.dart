import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// FACULTY: COURSE ROADMAP SCREEN
// Exactly matches Screenshot 1:
// - Blueprint grid hero banner with watermark, badges (FACULTY, MVP)
// - Sub-bar with description & "+ New roadmap" button
// - Large blueprint graph paper empty state container ("No roadmaps yet")
// =============================================================================

class CourseRoadmapScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CourseRoadmapScreen({super.key, this.onBack});

  @override
  State<CourseRoadmapScreen> createState() => _CourseRoadmapScreenState();
}

class _CourseRoadmapScreenState extends State<CourseRoadmapScreen> {
  bool _hasRoadmap = false;

  void _createNewRoadmap() {
    showDialog(
      context: context,
      builder: (context) {
        String selectedCourse = "CS3492 · Database Management Systems";
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Create New Course Roadmap",
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Course",
                style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155)),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedCourse,
                    items: [
                      "CS3492 · Database Management Systems",
                      "CS3491 · Artificial Intelligence & Data Science",
                      "CS3401 · Algorithms & Complexity",
                    ]
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) {},
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "Teaching Schedule & Days",
                style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155)),
              ),
              const SizedBox(height: 6),
              Text(
                "Mon, Wed, Fri (45 Sessions · 3 Internal Milestones)",
                style: GoogleFonts.poppins(
                    fontSize: 12, color: const Color(0xFF64748B)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: GoogleFonts.poppins()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => _hasRoadmap = true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Generated session-by-session roadmap for $selectedCourse",
                      style: GoogleFonts.poppins(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
              ),
              child: Text("Generate Roadmap", style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

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
              _buildSubBar(),
              const SizedBox(height: 18),
              if (!_hasRoadmap)
                _buildEmptyGraphPaperCard()
              else
                _buildActiveRoadmapView(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 1)
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
            // Watermark compass on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.explore_rounded,
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
                  // Breadcrumb without arrow
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Home',
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
                          'Faculty',
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
                          'Course Roadmap',
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
                      // Golden Compass icon box
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
                          Icons.explore_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges
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
                                      color: Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    'FACULTY',
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
                              'Course Roadmap',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Turn a course\'s syllabus into a dated, session-by-session teaching plan and track what you have covered.',
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
  // SUB-BAR WITH DESCRIPTION & ACTION (Screenshot 1)
  // ===========================================================================
  Widget _buildSubBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 700;
        final desc = Text(
          'Pick a course and the days you teach it; the roadmap spreads the syllabus over dated sessions with tutorials, internal assessments and revision. Tick sessions off as you teach.',
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF475569),
            height: 1.45,
          ),
        );

        final button = ElevatedButton.icon(
          onPressed: _createNewRoadmap,
          icon: const Icon(Icons.add, size: 16),
          label: Text(
            'New roadmap',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2865),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              desc,
              const SizedBox(height: 12),
              button,
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: desc),
              const SizedBox(width: 20),
              button,
            ],
          );
        }
      },
    );
  }

  // ===========================================================================
  // LARGE BLUEPRINT GRAPH PAPER EMPTY STATE (Screenshot 1)
  // ===========================================================================
  Widget _buildEmptyGraphPaperCard() {
    return Container(
      height: 260,
      width: double.infinity,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _LightGraphPaperPainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'No roadmaps yet',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Create one for each course and section you teach this semester.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
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

  Widget _buildActiveRoadmapView() {
    final modules = [
      {
        "title": "Unit I: Relational Data Models & SQL Foundations",
        "sessions": "Sessions 1 - 9 · Planned: Aug 01 - Aug 22",
        "progress": "8 / 9 Done",
        "completed": true,
      },
      {
        "title": "Unit II: Relational Algebra, Calculus & Normalization",
        "sessions": "Sessions 10 - 18 · Planned: Aug 25 - Sep 18",
        "progress": "6 / 9 Done",
        "completed": false,
      },
      {
        "title": "Unit III: Transaction Processing & Concurrency Control",
        "sessions": "Sessions 19 - 28 · Planned: Sep 22 - Oct 14",
        "progress": "Upcoming",
        "completed": false,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(22),
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
              Expanded(
                child: Text(
                  "CS3492 · Database Management Systems (Semester 5)",
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () => setState(() => _hasRoadmap = false),
                child: const Text("Reset"),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...modules.map((m) {
            final isDone = m["completed"] as bool;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Icon(
                    isDone
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked,
                    color: isDone
                        ? const Color(0xFF10B981)
                        : const Color(0xFF94A3B8),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m["title"] as String,
                          style: GoogleFonts.poppins(
                              fontSize: 13.5, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          m["sessions"] as String,
                          style: GoogleFonts.poppins(
                              fontSize: 11.5, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDone
                          ? const Color(0xFFDCFCE7)
                          : const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      m["progress"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDone
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF2563EB),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// Blueprint grid painter
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

// Light graph paper painter for empty state container
class _LightGraphPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.45)
      ..strokeWidth = 1.0;

    const double step = 20.0;

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
