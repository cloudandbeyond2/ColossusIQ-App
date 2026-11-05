import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// ASSESSMENT: EXAM PREP STUDIO SCREEN
// Matches screenshot: Blueprint grid hero banner, AI disclaimer alert banner,
// 3 metric cards (Published question sets / Topic notes / AI notes to review),
// tabs (Question sets / Study notes), and graph paper empty/populated state.
// =============================================================================
class FacultyExamPrepScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyExamPrepScreen({super.key, this.onBack});

  @override
  State<FacultyExamPrepScreen> createState() => _FacultyExamPrepScreenState();
}

class _FacultyExamPrepScreenState extends State<FacultyExamPrepScreen> {
  int _activeTab = 0; // 0 = Question sets, 1 = Study notes

  final List<Map<String, dynamic>> _questionSets = [];
  final List<Map<String, dynamic>> _studyNotes = [];

  void _openCreateSetDialog() {
    final titleController = TextEditingController();
    final examController = TextEditingController(text: "GATE CS / IT");
    final countController = TextEditingController(text: "15");

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Create New Question Set",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Set Title / Subject",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "e.g. Relational Algebra & Normalization 2026",
                    hintStyle: GoogleFonts.poppins(fontSize: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Target Exam",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: examController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Question Count",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: countController,
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
                  setState(() {
                    _questionSets.insert(0, {
                      "title": titleController.text.trim(),
                      "exam": examController.text.trim(),
                      "count": countController.text.trim(),
                      "status": "Published",
                      "date": "Just now",
                    });
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Question set published to students' Prep Hub!"),
                      backgroundColor: Color(0xFF15803D),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF141938),
                foregroundColor: Colors.white,
              ),
              child: const Text("Publish Set"),
            ),
          ],
        );
      },
    );
  }

  void _openCreateNoteDialog() {
    final titleController = TextEditingController();
    final topicController = TextEditingController(text: "Operating Systems");

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Add Topic Notes",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Note Title",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "e.g. Banker's Algorithm & Resource Allocation Graph",
                    hintStyle: GoogleFonts.poppins(fontSize: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Subject / Topic",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: topicController,
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
                  setState(() {
                    _studyNotes.insert(0, {
                      "title": titleController.text.trim(),
                      "topic": topicController.text.trim(),
                      "date": "Just now",
                    });
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Topic note added!"),
                      backgroundColor: Color(0xFF15803D),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF141938),
                foregroundColor: Colors.white,
              ),
              child: const Text("Save Note"),
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
          final isNarrow = constraints.maxWidth < 750;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 14),

              // 2. Info Alert Banner
              _buildDisclaimerAlert(),
              const SizedBox(height: 16),

              // 3. Metric Tiles (3 Cards)
              if (isNarrow)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildMetricCard(
                      value: "${_questionSets.length}",
                      title: "Published question sets",
                      subtitle: "${_questionSets.length * 15} questions reaching students",
                    ),
                    const SizedBox(height: 12),
                    _buildMetricCard(
                      value: "${_studyNotes.length}",
                      title: "Topic notes by faculty",
                    ),
                    const SizedBox(height: 12),
                    _buildMetricCard(
                      value: "0",
                      title: "AI notes to review",
                      subtitle: "AI drafting is off: built-in drafts are used",
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        value: "${_questionSets.length}",
                        title: "Published question sets",
                        subtitle: "${_questionSets.length * 15} questions reaching students",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        value: "${_studyNotes.length}",
                        title: "Topic notes by faculty",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildMetricCard(
                        value: "0",
                        title: "AI notes to review",
                        subtitle: "AI drafting is off: built-in drafts are used",
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 18),

              // 4. Tabs: Question sets / Study notes
              _buildSegmentedTabs(),
              const SizedBox(height: 16),

              // 5. Main Card
              _buildMainCard(),
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
            // Blueprint grid background
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),

            // Large decorative watermark on the right
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

            // Foreground Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb row (Home clickable without leading arrow)
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
                          "Assessment",
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
                          "Exam Prep Studio",
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

                  // Badges + Title Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Sparkle icon box
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
                            // Badges
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildPillBadge(
                                  "ASSESSMENT",
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

                            // Main Title
                            Text(
                              "Exam Prep Studio",
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

                  // Subtitle
                  Text(
                    "Add question sets and study notes for competitive and entrance exams, by hand or from an AI draft you review. Published content reaches students' Prep Hub straight away.",
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
              "AI drafts are suggestions. Check every fact, question and answer before you publish.",
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
    required String value,
    required String title,
    String? subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            value,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. SEGMENTED TABS
  // ===========================================================================
  Widget _buildSegmentedTabs() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSegmentButton(
              title: "Question sets",
              isSelected: _activeTab == 0,
              onTap: () => setState(() => _activeTab = 0),
            ),
            _buildSegmentButton(
              title: "Study notes",
              isSelected: _activeTab == 1,
              onTap: () => setState(() => _activeTab = 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. MAIN CARD (QUESTION SETS OR STUDY NOTES)
  // ===========================================================================
  Widget _buildMainCard() {
    final isQuestionTab = _activeTab == 0;
    final hasItems = isQuestionTab ? _questionSets.isNotEmpty : _studyNotes.isNotEmpty;

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
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isQuestionTab ? "Question sets" : "Study notes",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      isQuestionTab
                          ? "Exam-style questions for any syllabus topic, or a new topic your college teaches. Published questions appear in drills and mocks."
                          : "Curated key concepts, quick formulas and revision cheatsheets published for student access.",
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
                onPressed: isQuestionTab ? _openCreateSetDialog : _openCreateNoteDialog,
                icon: const Icon(Icons.add, size: 16),
                label: Text(
                  isQuestionTab ? "New set" : "New note",
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
          const SizedBox(height: 20),

          // Content Area
          if (!hasItems)
            // Empty State (Matches screenshot blueprint grid paper container)
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 280),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFD),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _GridPaperPainter(
                          gridColor: const Color(0xFFE2E8F0).withValues(alpha: 0.7),
                          step: 24.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isQuestionTab ? "No question sets yet" : "No study notes yet",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            isQuestionTab
                                ? "Add previous-year-style questions for an exam, or a set for a topic your students find hard."
                                : "Add topic summaries, formula sheets or quick-revision mindmaps.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            // Populated State
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: isQuestionTab ? _questionSets.length : _studyNotes.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                if (isQuestionTab) {
                  final item = _questionSets[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.quiz_rounded, color: Color(0xFF4F46E5), size: 20),
                      ),
                    ),
                    title: Text(
                      item["title"],
                      style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "${item["exam"]} · ${item["count"]} Questions · ${item["date"]}",
                      style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item["status"],
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF15803D),
                        ),
                      ),
                    ),
                  );
                } else {
                  final item = _studyNotes[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.menu_book_rounded, color: Color(0xFFD97706), size: 20),
                      ),
                    ),
                    title: Text(
                      item["title"],
                      style: GoogleFonts.poppins(fontSize: 13.5, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "${item["topic"]} · ${item["date"]}",
                      style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                    ),
                  );
                }
              },
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
