import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// AI COURSE & CERTIFICATION: AI COURSE STUDIO SCREEN
// Matches screenshot 3: Blueprint grid hero banner, disclaimer banner,
// 4 metric cards (Courses 1, Published to students 1, Students learning 0, Certificates issued 0),
// Department courses data table with Database Management Systems row and "+ New course" dialog.
// =============================================================================
class AiCourseStudioScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AiCourseStudioScreen({super.key, this.onBack});

  @override
  State<AiCourseStudioScreen> createState() => _AiCourseStudioScreenState();
}

class _AiCourseStudioScreenState extends State<AiCourseStudioScreen> {
  final List<Map<String, dynamic>> _courses = [
    {
      "title": "Database Management Systems",
      "code": "CSE101 · Computer Science & Engineering · Term 3",
      "builtFrom": "Course title",
      "lessons": "32 in 10 chapters",
      "assessment": "30 questions",
      "students": "—",
      "status": "Published",
    },
  ];

  int get _publishedCount =>
      _courses.where((c) => c["status"] == "Published").length;

  void _openNewCourseDialog() {
    final titleController = TextEditingController();
    final codeController = TextEditingController(text: "CSE204 · Artificial Intelligence");
    final chaptersController = TextEditingController(text: "8");

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Build New Course with AI",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Course Title", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "e.g. Distributed Cloud Computing & Microservices",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 12),
                Text("Department / Course Code", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: codeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 12),
                Text("Target Chapters", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: chaptersController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isNotEmpty) {
                  final chapters = chaptersController.text.trim();
                  setState(() {
                    _courses.insert(0, {
                      "title": titleController.text.trim(),
                      "code": codeController.text.trim(),
                      "builtFrom": "Course title",
                      "lessons": "$chapters in $chapters chapters",
                      "assessment": "25 questions",
                      "students": "—",
                      "status": "Published",
                    });
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Course draft synthesized and published!"),
                      backgroundColor: Color(0xFF15803D),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF141938),
                foregroundColor: Colors.white,
              ),
              child: const Text("Generate Course"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 800;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 14),

              // 2. Info Alert Banner
              _buildDisclaimerAlert(),
              const SizedBox(height: 18),

              // 3. 4 Metric Cards
              if (isNarrow)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            icon: Icons.menu_book_outlined,
                            title: "Courses",
                            value: "${_courses.length}",
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMetricCard(
                            icon: Icons.check_box_outlined,
                            title: "Published to students",
                            value: "$_publishedCount",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            icon: Icons.groups_outlined,
                            title: "Students learning",
                            value: "0",
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMetricCard(
                            icon: Icons.military_tech_outlined,
                            title: "Certificates issued",
                            value: "0",
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        icon: Icons.menu_book_outlined,
                        title: "Courses",
                        value: "${_courses.length}",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        icon: Icons.check_box_outlined,
                        title: "Published to students",
                        value: "$_publishedCount",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        icon: Icons.groups_outlined,
                        title: "Students learning",
                        value: "0",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        icon: Icons.military_tech_outlined,
                        title: "Certificates issued",
                        value: "0",
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),

              // 4. Main Card: Department Courses
              _buildCoursesCard(),
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
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.auto_awesome_rounded,
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
                              fontSize: 11.5,
                              color: const Color(0xFFC7D2FE),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "AI Course & Certification",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "AI Course Studio",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.auto_awesome_rounded,
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
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildPillBadge(
                                  "AI COURSE & CERTIFICATION",
                                  backgroundColor: const Color(0xFF1E2958),
                                  textColor: const Color(0xFF93C5FD),
                                ),
                                _buildPillBadge(
                                  "MVP",
                                  backgroundColor: const Color(0xFF0F766E),
                                  textColor: const Color(0xFFCCFBF1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "AI Course Studio",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "Build a department course from a title or your own syllabus: lessons, outcomes and a 30-question final assessment. Then publish it to students.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w400,
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

  // ===========================================================================
  // 2. DISCLAIMER ALERT
  // ===========================================================================
  Widget _buildDisclaimerAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: Color(0xFFB45309),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "AI drafts lessons and questions. Review them before publishing; only the HOD or Principal can publish to students.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF92400E),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. METRIC CARDS
  // ===========================================================================
  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            children: [
              Icon(icon, size: 16, color: const Color(0xFF64748B)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. MAIN CARD: DEPARTMENT COURSES
  // ===========================================================================
  Widget _buildCoursesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header row with + New course button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Department courses",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Create and edit drafts; your HOD publishes them to students.",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              ElevatedButton.icon(
                onPressed: _openNewCourseDialog,
                icon: const Icon(Icons.add, size: 16),
                label: Text(
                  "New course",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141938),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Horizontally Scrollable Data Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 950),
              child: DataTable(
                dataRowMinHeight: 64,
                dataRowMaxHeight: 74,
                headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                dataTextStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF1E293B),
                ),
                horizontalMargin: 12,
                columnSpacing: 24,
                columns: const [
                  DataColumn(label: Text("COURSE")),
                  DataColumn(label: Text("BUILT FROM")),
                  DataColumn(label: Text("LESSONS")),
                  DataColumn(label: Text("ASSESSMENT")),
                  DataColumn(label: Text("STUDENTS")),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("ACTIONS")),
                ],
                rows: _courses.map((course) {
                  return DataRow(
                    cells: [
                      // COURSE
                      DataCell(
                        SizedBox(
                          width: 260,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                course["title"],
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                course["code"],
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // BUILT FROM
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFBFDBFE)),
                          ),
                          child: Text(
                            course["builtFrom"],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1E40AF),
                            ),
                          ),
                        ),
                      ),

                      // LESSONS
                      DataCell(
                        Text(
                          course["lessons"],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // ASSESSMENT
                      DataCell(
                        Text(
                          course["assessment"],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // STUDENTS
                      DataCell(
                        Text(
                          course["students"],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),

                      // STATUS
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            course["status"],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF15803D),
                            ),
                          ),
                        ),
                      ),

                      // ACTIONS
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Editing ${course["title"]}")),
                                );
                              },
                              icon: const Icon(Icons.edit_outlined, size: 14),
                              label: const Text("Edit"),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                foregroundColor: const Color(0xFF334155),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Opened ${course["title"]}")),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                foregroundColor: const Color(0xFF334155),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Open"),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.arrow_forward_rounded, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================
  Widget _buildPillBadge(
    String text, {
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT / GRAPH PAPER GRID PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

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
